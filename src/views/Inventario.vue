<!--
    ! Todo funciona correctamente!! Por el momento...
-->

<template>
    <v-container fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="products" :search="search" :page.sync="page"
            :items-per-page="itemsPerPage" hide-default-footer class="elevation-10" item-key="name"
            no-data-text="No hay información" :loading="loadingVar" loading-text="Cargando información..."
            no-results-text="No hay coincidencias" @page-count="pageCount = $event" sort-by="name">
            <template v-slot:top>
                <div v-if="!mobile">
                    <v-toolbar flat color="primary" dark>
                        <v-toolbar-title>
                            INVENTARIO
                        </v-toolbar-title>
                        <v-spacer></v-spacer>
                        <v-btn color="green" class="mr-5" @click="dialogShowCategories = true">Editar categorías</v-btn>
                        <v-btn color="green" class="mr-5" @click="dialogNewProduct = true">Agregar Producto</v-btn>
                        <v-text-field append-icon="mdi-magnify" v-model="search" label="Buscar" class="shrink" dense
                            filled rounded hide-details single-line></v-text-field>
                    </v-toolbar>
                </div>
                <div v-else>
                    <v-toolbar flat color="primary" height="150px" dark>
                        <v-row>
                            <v-col cols="12" class="d-flex justify-center">
                                <v-toolbar-title>
                                    INVENTARIO
                                </v-toolbar-title>
                            </v-col>
                            <v-col cols="4">
                                <v-btn color="green" block @click="dialogNewProduct = true">+</v-btn>
                            </v-col>
                            <v-col cols="8" class="d-flex justify-space-between">
                                <v-text-field append-icon="mdi-magnify" v-model="search" label="Buscar" class="shrink"
                                    dense filled rounded hide-details single-line></v-text-field>
                            </v-col>
                        </v-row>
                    </v-toolbar>
                </div>
            </template>
            <template v-slot:item.actions="{ item }">
                <v-btn color="blue" depressed fab x-small dark class="mr-6" @click="dialog_EditProduct(item)">
                    <font-awesome-icon icon="fa-solid fa-pencil" class="fa-xl" />
                </v-btn>
                <v-btn color="error" depressed fab x-small @click="deleteProduct(item)">
                    <font-awesome-icon icon="fa-trash" class="fa-xl" />
                </v-btn>
            </template>
        </v-data-table>
        <v-pagination :length="pageCount" :total-visible="totalVisible" v-model="page" class="mt-2"></v-pagination>

        <!--
    * ---------DIALOG EDITAR PRODUCTO---------
    -->

        <div v-if="!mobile">
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
                                    <v-text-field v-model.number="newProduct.pro_cost" label="Precio" dense type="float"
                                        rounded outlined>
                                    </v-text-field>
                                </v-col>
                                <v-col cols="4">
                                    <v-select v-model="newProduct.pro_unit" :items="units" label="Unidad" dense rounded
                                        outlined></v-select>
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
        </div>

        <div v-else>
            <v-dialog v-model="dialogEditProduct" scrollable persistent fullscreen transition="dialog-transition">
                <v-card>
                    <v-toolbar flat color="primary" dark style="flex: none">
                        <v-card-title class="overline" style="font-size: large !important">
                            EDITAR PRODUCTO
                        </v-card-title>
                    </v-toolbar>
                    <v-card-text>
                        <v-container>
                            <v-text-field v-model="newProduct.pro_name" label="Nombre" rounded outlined dense>
                            </v-text-field>
                            <v-combobox v-model="newProduct.cat_name" :items="categories" item-text="cat_name"
                                label="Categoría" dense rounded outlined></v-combobox>
                            <v-text-field v-model="newProduct.pro_brand" label="Marca" dense rounded outlined>
                            </v-text-field>
                            <v-text-field v-model.number="newProduct.pro_cost" label="Precio" dense type="float" rounded
                                outlined></v-text-field>
                            <v-select v-model="newProduct.pro_unit" :items="units" label="Unidad" dense rounded
                                outlined></v-select>
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
        </div>

        <!--
    * ---------DIALOG NUEVO PRODUCTO---------
    -->

        <div v-if="!mobile">
            <v-dialog v-model="dialogNewProduct" scrollable persistent max-width="800" transition="dialog-transition">
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
                                    <v-text-field v-model.number="newProduct.cost" label="Precio" dense type="float"
                                        rounded outlined>
                                    </v-text-field>
                                </v-col>
                                <v-col cols="4">
                                    <v-select v-model="newProduct.units" :items="units" label="Unidad" dense rounded
                                        outlined></v-select>
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
        </div>

        <div v-else>
            <v-dialog v-model="dialogNewProduct" fullscreen scrollable persistent :overlay=false
                transition="dialog-transition">
                <v-card height="60vh">
                    <v-toolbar flat color="primary" dark style="flex: none;">
                        <v-card-title class="overline" style="font-size: large !important">
                            AÑADIR PRODUCTOS
                        </v-card-title>
                        <v-spacer></v-spacer>
                        <v-btn color="green" @click="addNewProductRow()">+</v-btn>
                    </v-toolbar>
                    <v-card-text>
                        <v-container v-for="(newProduct, index) in newProduct" :key="index">
                            <v-text-field v-model="newProduct.name" label="Nombre" rounded outlined dense>
                            </v-text-field>
                            <v-combobox v-model="newProduct.category" :items="categories" item-text="cat_name"
                                label="Categoría" dense rounded outlined></v-combobox>
                            <v-text-field v-model="newProduct.brand" label="Marca" dense rounded outlined>
                            </v-text-field>
                            <v-text-field v-model.number="newProduct.cost" label="Precio" dense type="float" rounded
                                outlined>
                            </v-text-field>
                            <v-select v-model="newProduct.units" :items="units" label="Unidad" dense rounded outlined>
                            </v-select>
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
        </div>

        <!--
    * ---------DIALOG MOSTRAR CATEGORÍA---------
    -->
        <v-dialog v-model="dialogShowCategories" persistent transition="dialog-transition" width="auto"
            max-width="50%">
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

    <v-dialog
        v-model="dialogEditCategory"
        persistent
        max-width="25%"
        transition="dialog-transition"
    >
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
            <v-btn color="success" @click = "updateCategory()">Guardar</v-btn>
            <v-spacer></v-spacer>
        </v-card-actions>
    </v-card>
        
    </v-dialog>

    <v-dialog
        width="auto"
        v-model="dialogWarningDelete"
        persistent
        transition="dialog-transition"
    >
    <v-card>
        <v-toolbar color="primary" dark>
            <v-toolbar-title>
                ¿Estás seguro de eliminar esta categoría?
            </v-toolbar-title>
        </v-toolbar>
        <v-card-text>
            Esto también afectará a los productos dentro de la categoría
        </v-card-text>
        <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="error" @click="dialogWarningDelete = false">Cerrar</v-btn>
            <v-btn color="success" @click = "deleteCategory()">Guardar</v-btn>
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
            mobile: "",
            totalVisible: 10,
            loadingVar: true,
            itemsPerPage: 12,
            dialogEditCategory: false,
            dialogEditProduct: false,
            dialogShowCategories: false,
            dialogNewProduct: false,
            dialogWarningDelete: false,
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
                units: ""
            }
            ],
        }
    },

    methods: {

        isMobile() {
            this.mobile = (window.innerWidth <= 600 && window.innerHeight <= 1000)
            if (this.mobile) {
                this.itemsPerPage = 2
                this.totalVisible = 5
            }
        },

        async addNewProduct() {
            /**
             * Metodo some evalua si algún objeto o elemento cumple con la condición
             */
            for (const producto of this.newProduct) {
                if (!this.categories.some(cat => cat.cat_id === producto.category?.cat_id)) {
                    /**
                     * ! HDSPM el perro await al llamar la función
                     */
                    await this.addNewCategory(producto)
                }
                else {
                    producto.category = producto.category?.cat_id
                }
                await this.axios.post('/api/inventario/nuevoProducto', producto)
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

        async deleteProduct(item) {
            await this.axios.get('/api/inventario/borrarProducto/' + item.pro_id)
            this.getProducts()
        },

        async deleteCategory() {
            
            console.log("🚀 ~ file: Inventario.vue ~ line 437 ~ deleteCategory ~ this.newNameCategory", this.newNameCategory)
            await this.axios.get('/api/inventario/borrarCategoria/' + this.newNameCategory)
            this.closeDialog()
            this.getCategories()
            this.getProducts()
        },

        showDeleteWarning(item){
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
                this.newProduct.pro_category = this.newProduct.cat_name.cat_id
            }
            await this.axios.post('/api/inventario/actualizarProducto', this.newProduct)
            this.closeDialog()
            this.getProducts()
        },

        async updateCategory(){
            await this.axios.post('/api/inventario/actualizarCategoria', this.newNameCategory)
            this.closeDialog()
            this.getCategories()
            this.getProducts()
        },

        closeDialog() {
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
                    units: ""
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
                units: ""
            })
        },

        copyCategoryItem(item){
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
        this.isMobile()
        this.getProducts()
        this.getCategories()
    },

}

</script>

