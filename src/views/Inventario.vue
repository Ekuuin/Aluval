<!--
    ! Pendiente modificar dialog Actualizar
-->

<template>
    <v-container fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="products" :search="search" :page.sync="page"
            :items-per-page="itemsPerPage" hide-default-footer class="elevation-10" item-key="name"
            no-data-text="No hay información" :loading="loadingVar" loading-text="Cargando información..."
            no-results-text="No hay coincidencias" @page-count="pageCount = $event" sort-by="name">
            <template v-slot:top>
                <v-toolbar flat color="primary" dark>
                    <v-toolbar-title>
                        INVENTARIO
                    </v-toolbar-title>
                    <v-spacer></v-spacer>
                    <v-btn color="green" class="mr-5" @click="dialogShowCategories = true">Editar categorías</v-btn>
                    <v-btn color="green" class="mr-5" @click="dialogNewProduct = true">Agregar Producto</v-btn>
                    <v-text-field append-icon="mdi-magnify" v-model="search" label="Buscar" class="shrink" dense filled
                        rounded hide-details single-line></v-text-field>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{ item }">
                <v-btn color="blue" depressed fab x-small dark class="mr-6" @click="dialog_EditProduct(item)">
                    <font-awesome-icon icon="fa-solid fa-pencil" class="fa-xl" />
                </v-btn>
                <v-btn color="error" depressed fab x-small @click="showDialogDeleteProduct(item)">
                    <font-awesome-icon icon="fa-trash" class="fa-xl" />
                </v-btn>
            </template>
        </v-data-table>
        <v-pagination :length="pageCount" :total-visible="totalVisible" v-model="page" class="mt-2"></v-pagination>

        <!--
    * ---------DIALOG EDITAR PRODUCTO---------
    -->
        <v-dialog v-model="dialogEditProduct" scrollable persistent max-width="800" transition="dialog-transition">
            <v-card>
                <v-toolbar flat color="primary" dark style="flex: none">
                    <v-card-title class="overline" style="font-size: large !important">
                        EDITAR PRODUCTO
                    </v-card-title>
                </v-toolbar>
                <v-card-text>
                    <v-container class="rowSpacing">
                        <v-row>
                            <v-col cols="4">
                                <v-text-field v-model="newProduct.pro_name" label="Nombre" rounded outlined dense>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-combobox v-model="newProduct.cat_name" :items="categories" item-text="cat_name"
                                    label="Categoría" dense rounded outlined></v-combobox>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model="newProduct.pro_brand" label="Marca" dense rounded outlined>
                                </v-text-field>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.pro_cost" label="Precio" dense type="float" @click="newProduct.pro_cost = ''"
                                    rounded outlined :disabled="evalPerfiles(newProduct)">
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-select v-model="newProduct.pro_unit" :items="units" label="Unidad" dense rounded
                                    outlined></v-select>
                            </v-col>
                            <v-col v-if="evalPerfiles(newProduct)" cols="4">
                                <v-text-field v-model="newProduct.jambaC" label="Jamba Corrediza" dense rounded
                                    outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.mosquiteroC" label="Mosquitero Corrediza" dense
                                    rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.rielC" label="Riel Corrediza" dense rounded
                                    outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.adaptadorC" label="Adaptador Corrediza" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.zocloC" label="Zoclo Corrediza" dense rounded
                                    outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.traslapeC" label="Traslape Corrediza" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.bolsaF" label="Bolsa Fijo" dense rounded
                                    outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.escalonadoF" label="Escalonado Fijo" dense
                                    rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.junquilloF" label="Junquillo Fijo" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.marcoPE" label="Marco Puerta Económica" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.cercoPE" label="Cerco Puerta Económica" dense
                                    rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.zocloPE" label="Zoclo Puerta Económica" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.tubularPEsp"
                                    label="Fijo Tubular Puerta Española" dense rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.hojaPEsp"
                                    label="Hoja Monumental Puerta Española" dense rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.zocloPEsp" label="Zoclo Puerta Española" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.junquilloPEsp"
                                    label="Junquillo Puerta Española" dense rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-divider></v-divider>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="red" dark @click="closeDialog()">Cerrar</v-btn>
                    <v-btn color="success" @click="editProduct()">Guardar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <v-dialog width="auto" v-model="dialogWarningDeleteProduct" persistent transition="dialog-transition">
            <v-card>
                <v-toolbar color="primary" dark>
                    <v-toolbar-title>
                        ¿Estás seguro de eliminar este producto?
                    </v-toolbar-title>
                </v-toolbar>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="error" @click="dialogWarningDeleteProduct = false" class="mr-5">Cerrar</v-btn>
                    <v-btn color="success" @click="deleteProduct()">Sí</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>

        </v-dialog>


        <!--
    * ---------DIALOG NUEVO PRODUCTO---------
    -->
        <v-dialog v-model="dialogNewProduct" scrollable persistent max-width="1100" transition="dialog-transition">
            <v-card>
                <v-toolbar flat color="primary" dark style="flex: none">
                    <v-card-title class="overline" style="font-size: large !important">
                        AÑADIR PRODUCTOS
                    </v-card-title>
                    <v-spacer></v-spacer>
                    <v-btn color="green" @click="addNewProductRow()">+</v-btn>
                </v-toolbar>
                <v-card-text>
                    <v-container class="rowSpacing" v-for="(newProduct, index) in newProduct" :key="index">
                        <v-row>
                            <v-col cols="4">
                                <v-text-field v-model="newProduct.name" label="Nombre" rounded outlined dense>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-combobox v-model="newProduct.category" :items="categories" item-text="cat_name"
                                    label="Categoría" dense rounded outlined></v-combobox>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model="newProduct.brand" label="Marca" dense rounded outlined>
                                </v-text-field>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.cost" label="Precio" dense type="float" rounded
                                    outlined :disabled="evalPerfiles(newProduct)">
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-select v-model="newProduct.units" :items="units" label="Unidad" dense rounded
                                    outlined></v-select>
                            </v-col>
                            <v-col v-if="evalPerfiles(newProduct)" cols="4">
                                <v-text-field v-model="newProduct.jambaC" label="Jamba Corrediza" dense rounded
                                    outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.mosquiteroC" label="Mosquitero Corrediza" dense
                                    rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.rielC" label="Riel Corrediza" dense rounded
                                    outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.adaptadorC" label="Adaptador Corrediza" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.zocloC" label="Zoclo Corrediza" dense rounded
                                    outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.traslapeC" label="Traslape Corrediza" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.bolsaF" label="Bolsa Fijo" dense rounded
                                    outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.escalonadoF" label="Escalonado Fijo" dense
                                    rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.junquilloF" label="Junquillo Fijo" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.marcoPE" label="Marco Puerta Económica" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.cercoPE" label="Cerco Puerta Económica" dense
                                    rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.zocloPE" label="Zoclo Puerta Económica" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.tubularPEsp"
                                    label="Fijo Tubular Puerta Española" dense rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-row v-if="evalPerfiles(newProduct)">
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.hojaPEsp"
                                    label="Hoja Monumental Puerta Española" dense rounded outlined>
                                </v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.zocloPEsp" label="Zoclo Puerta Española" dense
                                    rounded outlined></v-text-field>
                            </v-col>
                            <v-col cols="4">
                                <v-text-field v-model.number="newProduct.junquilloPEsp"
                                    label="Junquillo Puerta Española" dense rounded outlined></v-text-field>
                            </v-col>
                        </v-row>
                        <v-divider></v-divider>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="red" dark @click="closeDialog()">Cerrar</v-btn>
                    <v-btn color="success" @click="addNewProduct()">Guardar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <!--
    * ---------DIALOG MOSTRAR CATEGORÍA---------
    -->
        <v-dialog v-model="dialogShowCategories" persistent transition="dialog-transition" width="auto" max-width="50%">
            <v-card>
                <v-data-table :headers="headersCategories" :items="categories" :search="searchCategories"
                    :page.sync="page" :items-per-page="itemsPerPage" hide-default-footer class="elevation-1"
                    item-key="name" no-data-text="No hay información" :loading="loadingVar"
                    loading-text="Cargando información..." no-results-text="No hay coincidencias"
                    @page-count="pageCount = $event" sort-by="name">
                    <template v-slot:top>
                        <v-toolbar flat color="primary" dark style="flex: none;">
                            <v-toolbar-title>
                                CATEGORÍAS
                            </v-toolbar-title>
                        </v-toolbar>
                    </template>
                    <template v-slot:[`item.actions`]="{ item }">
                        <v-btn color="blue" depressed fab x-small dark class="mr-6" @click="copyCategoryItem(item)">
                            <font-awesome-icon icon="fa-solid fa-pencil" class="fa-xl" />
                        </v-btn>
                        <v-btn color="error" depressed fab x-small @click="showDeleteWarning(item)">
                            <font-awesome-icon icon="fa-trash" class="fa-xl" />
                        </v-btn>
                    </template>
                </v-data-table>
                <v-pagination :length="pageCount" :total-visible="totalVisible" v-model="page" class="mt-2">
                </v-pagination>

                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="error" @click="dialogShowCategories = false">Cerrar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <!--
    * ---------DIALOGS EDITAR CATEGORÍA---------
    -->

        <v-dialog v-model="dialogEditCategory" persistent max-width="25%" transition="dialog-transition">
            <v-card>
                <v-toolbar color="primary" dark>
                    <v-toolbar-title>
                        Editar Categoría
                    </v-toolbar-title>
                </v-toolbar>
                <v-card-text>
                    <v-text-field label="Nombre" outlined v-model="newNameCategory.cat_name"></v-text-field>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="error" @click="dialogEditCategory = false">Cerrar</v-btn>
                    <v-btn color="success" @click="updateCategory()">Guardar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>

        </v-dialog>

        <v-dialog width="auto" v-model="dialogWarningDelete" persistent transition="dialog-transition">
            <v-card>
                <v-toolbar color="primary" dark>
                    <v-toolbar-title>
                        ¿Estás seguro de eliminar esta categoría?
                    </v-toolbar-title>
                </v-toolbar>
                <v-card-text>
                    <span class="title">Esto también eliminará a los productos dentro de la categoría.</span>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="error" @click="dialogWarningDelete = false" class="mr-5">Cerrar</v-btn>
                    <v-btn color="success" @click="deleteCategory()">Sí</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>

        </v-dialog>



    </v-container>
</template>

<script>

export default {
    name: "Inventario",
    data() {
        return {
            totalVisible: 10,
            loadingVar: true,
            itemsPerPage: 12,
            dialogEditCategory: false,
            dialogEditProduct: false,
            dialogShowCategories: false,
            dialogNewProduct: false,
            dialogWarningDelete: false,
            dialogWarningDeleteProduct: false,
            search: "",
            searchCategories: "",
            page: 1,
            pageCount: 0,
            headers: [
                { text: 'ID', value: 'pro_id' },
                { text: 'PRODUCTO', value: 'pro_name' },
                { text: 'CATEGORÍA', value: 'cat_name' },
                { text: 'MARCA', value: 'pro_brand' },
                { text: 'PRECIO', value: 'pro_cost', sortable: false },
                { text: 'UNIDAD', value: 'pro_unit', sortable: false },
                { text: 'ACCIONES', value: 'actions', sortable: false, align: "center" },
            ],

            products: [],

            headersCategories: [
                { text: 'ID', value: 'cat_id' },
                { text: 'NOMBRE', value: 'cat_name' },
                { text: 'ACCIONES', value: 'actions' }
            ],

            categories: [],

            newNameCategory: "",

            units: ["m2", "m", "Pieza"],

            newProduct: [{
                name: "",
                category: "",
                brand: "",
                cost: "",
                units: "",
                jambaC: "",
                mosquiteroC: "",
                rielC: "",
                adaptadorC: "",
                bolsaF: "",
                traslapeC: "",
                zocloC: "",
                escalonadoF: "",
                junquilloF: "",
                marcoPE: "",
                cercoPE: "",
                zocloPE: "",
                tubularPEsp: "",
                hojaPEsp: "",
                zocloPEsp: "",
                junquilloPEsp: ""
            }
            ],
        }
    },

    methods: {

        evalPerfiles(newProduct) {
            var result = this.categories.filter(elemento => elemento.cat_id == newProduct.category?.cat_id)
            const condPerfiles = result[0]?.cat_name == "Perfiles" || newProduct?.category == "Perfiles" || newProduct?.cat_name == 'Perfiles'
                || newProduct.cat_name?.cat_name == 'Perfiles'
            const condPerfil = result[0]?.cat_name == "Perfil" || newProduct?.category == "Perfil" || newProduct?.cat_name == 'Perfil'
                || newProduct.cat_name?.cat_name == 'Perfil'
            if (condPerfiles || condPerfil)
                return true
            return false
        },

        async addNewProduct() {
            /**
             * * Metodo some evalua si algún objeto o elemento cumple con la condición
             */
            for (const producto of this.newProduct) {
                if (!this.categories.some(cat => cat.cat_id === producto.category?.cat_id)) {
                    /**
                     * * En caso de la que la categoría no exista, se crea y se guarda su ID para la siguiente petición.
                     */
                    await this.addNewCategory(producto)
                }
                else {
                    producto.category = producto.category?.cat_id
                }
                /**
                 * * Se envía la petición para agregar el nuevo producto.
                 */
                await this.axios.post('/api/inventario/nuevoProducto', producto)
                console.log("🚀 ~ file: Inventario.vue ~ line 478 ~ addNewProduct ~ producto", producto)
            }
            this.closeDialog()
            this.getProducts()
        },

        async addNewCategory(producto) {
            const body = {
                category: producto.category
            }
            const response = await this.axios.post('/api/inventario/nuevaCategoria', body)
            producto.category = response.data[0].id
            this.getCategories()
        },

        async getProducts() {
            const api_data = await this.axios.get('/api/inventario/obtenerProductos')
            this.products = api_data.data
            this.loadingVar = false
        },

        async getCategories() {
            const api_data = await this.axios.get('/api/inventario/obtenerCategorias')
            this.categories = api_data.data
        },

        async deleteProduct() {
            await this.axios.get('/api/inventario/borrarProducto/' + this.newNameCategory)
            this.closeDialog()
            this.getProducts()
        },

        async deleteCategory() {
            await this.axios.get('/api/inventario/borrarCategoria/' + this.newNameCategory)
            this.closeDialog()
            this.getCategories()
            this.getProducts()
        },

        showDialogDeleteProduct(item) {
            this.newNameCategory = item.pro_id
            this.dialogWarningDeleteProduct = true
        },

        showDeleteWarning(item) {
            this.newNameCategory = item.cat_id
            this.dialogWarningDelete = true
        },

        async editProduct() {
            /**
             * ! waiting for combobox to update before firing
             */
            await new Promise((r) => setTimeout(r, 100));


            const cond1 = this.categories.some(cat => cat.cat_id == this.newProduct.cat_name?.cat_id)
            const cond2 = this.categories.some(cat => cat.cat_name === this.newProduct.cat_name)

            if (!(cond1 || cond2)) {
                const producto = {
                    category: ""
                }
                if (typeof this.newProduct.cat_name === 'object') {
                    producto.category = this.newProduct.cat_name.cat_name
                }
                else {
                    producto.category = this.newProduct.cat_name
                }
                await this.addNewCategory(producto)
                this.newProduct.pro_category = producto.category
            }
            else {
                if (typeof this.newProduct.cat_name.cat_id !== 'undefined')
                    this.newProduct.pro_category = this.newProduct.cat_name.cat_id
            }
            await this.axios.post('/api/inventario/actualizarProducto', this.newProduct)
            this.closeDialog()
            this.getProducts()
        },

        async updateCategory() {
            await this.axios.post('/api/inventario/actualizarCategoria', this.newNameCategory)
            this.closeDialog()
            this.getCategories()
            this.getProducts()
        },

        closeDialog() {
            this.dialogWarningDeleteProduct = false
            this.dialogWarningDelete = false
            this.dialogEditCategory = false
            this.dialogNewProduct = false
            this.dialogEditProduct = false
            this.newProduct = [
                {
                    name: "",
                    category: "",
                    brand: "",
                    cost: "",
                    units: "",
                    jambaC: "",
                    mosquiteroC: "",
                    rielC: "",
                    adaptadorC: "",
                    traslapeC: "",
                    zocloC: "",
                    bolsaF: "",
                    escalonadoF: "",
                    junquilloF: "",
                    marcoPE: "",
                    cercoPE: "",
                    zocloPE: "",
                    tubularPEsp: "",
                    hojaPEsp: "",
                    zocloPEsp: "",
                    junquilloPEsp: ""
                }
            ]
            this.newNameCategory = ""
        },

        addNewProductRow() {
            this.newProduct.push({
                name: "",
                category: "",
                brand: "",
                cost: "",
                units: "",
                jambaC: "",
                mosquiteroC: "",
                rielC: "",
                adaptadorC: "",
                bolsaF: "",
                traslapeC: "",
                zocloC: "",
                escalonadoF: "",
                junquilloF: "",
                marcoPE: "",
                cercoPE: "",
                zocloPE: "",
                tubularPEsp: "",
                hojaPEsp: "",
                zocloPEsp: "",
                junquilloPEsp: ""
            })
        },

        copyCategoryItem(item) {
            this.newNameCategory = Object.assign({}, item)
            this.dialogEditCategory = true
        },

        dialog_EditProduct(item) {
            /**
             * ! Usar el metodo JSON.parse(JSON.stringify()) para desconectar todas las referencias, instead of Object.assign
             */
            this.newProduct = JSON.parse(JSON.stringify(item))
            this.dialogEditProduct = true
        },

    },

    created() {
        this.getProducts()
        this.getCategories()
    },

}

</script>

