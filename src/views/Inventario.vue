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
                <div v-if="!isMobile()">
                    <v-toolbar flat color="primary" dark>
                        <v-toolbar-title>
                            INVENTARIO
                        </v-toolbar-title>
                        <v-spacer></v-spacer>
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
            <template v-slot:[`item.actions`]="{ item }">
                <v-btn color="blue" depressed fab x-small dark class="mr-3" @click="dialog_EditProduct(item)">
                    <font-awesome-icon icon="fa-solid fa-pencil" class="fa-xl" />
                </v-btn>
                <v-btn color="error" depressed fab x-small @click="deleteProduct(item)">
                    <font-awesome-icon icon="fa-trash" class="fa-xl" />
                </v-btn>
            </template>
        </v-data-table>
        <v-pagination :length="pageCount" :total-visible="totalVisible" v-model="page" class="mt-2"></v-pagination>

        <div v-if="!isMobile()">
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
                        <v-btn color="red" dark @click="closeDialog()">Cancelar</v-btn>
                        <v-btn color="success" @click="test()">Guardar</v-btn>
                        <v-spacer></v-spacer>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </div>


        <div v-if="!isMobile()">
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
                        <v-btn color="red" dark @click="closeDialog()">Cancelar</v-btn>
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
                        <v-btn color="green">+</v-btn>
                    </v-toolbar>
                    <v-card-text>

                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="red" dark @click="closeDialog()">Cancelar</v-btn>
                        <v-btn color="success" @click="addNewProduct()">Guardar</v-btn>
                        <v-spacer></v-spacer>
                    </v-card-actions>
                </v-card>
            </v-dialog>

        </div>

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
            dialogEditProduct: false,
            dialogNewProduct: false,
            search: "",
            page: 1,
            pageCount: 0,
            headers: [
                { text: 'ID', value: 'pro_id'},
                { text: 'PRODUCTO', value: 'pro_name'},
                { text: 'CATEGORÍA', value: 'cat_name' },
                { text: 'MARCA', value: 'pro_brand' },
                { text: 'PRECIO', value: 'pro_cost', sortable: false },
                { text: 'UNIDAD', value: 'pro_unit', sortable: false },
                { text: 'ACCIONES', value: 'actions', sortable: false, align: "center"},
            ],

            products: [],

            categories: [],

            units: ["m2", "m", "Pieza"],

            newProduct: [{
                name: "",
                category: {
                    cat_id: '',
                    cat_name: ''
                },
                brand: "",
                cost: "",
                units: ""
            }
            ],
        }
    },

    methods: {

        isMobile() {
            const val = (window.innerWidth <= 600 && window.innerHeight <= 1000)
            if (val) {
                this.itemsPerPage = 2
                this.totalVisible = 5
            }
            return val
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

        async editProduct() {
            await this.axios.post('/api/inventario/actualizarProducto/', this.newProduct)
        }
        ,
        closeDialog() {
            this.dialogNewProduct = false
            this.dialogEditProduct = false
            this.newProduct = [
                {
                    name: "",
                    category: {
                        cat_id: '',
                        cat_name: ''
                    },
                    brand: "",
                    cost: "",
                    units: ""
                }
            ]
        },

        addNewProductRow() {
            this.newProduct.push({
                name: "",
                category: {
                    cat_id: '',
                    cat_name: ''
                },
                brand: "",
                cost: "",
                units: ""
            })
        },

        dialog_EditProduct(item) {
            /**
             * ! Usar el metodo JSON.parse(JSON.stringify()) para desconectar todas las referencias, instead of Object.assign
             */
            this.newProduct = JSON.parse(JSON.stringify(item))
            this.dialogEditProduct = true
        },

        async test() {
            /**
             * ! waiting for combobox to update before firing
             */
            await new Promise((r) => setTimeout(r, 100));

            console.log("🚀 ~ file: Inventario.vue ~ line 334 ~ test ~ newProduct", this.newProduct)

            const cond1 = this.categories.some(cat => cat.cat_id == this.newProduct.cat_name?.cat_id)
            console.log("🚀 ~ file: Inventario.vue ~ line 334 ~ test ~ cond1", cond1)
            const cond2 = this.categories.some(cat => cat.cat_name === this.newProduct.cat_name)
            console.log("🚀 ~ file: Inventario.vue ~ line 335 ~ test ~ cond2", cond2)

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
        }
    },

    created() {
        this.getProducts()
        this.getCategories()
    },

}

</script>

