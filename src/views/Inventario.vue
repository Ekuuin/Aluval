<template>
    <v-container fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="photos" :search="search" :page.sync="page" :items-per-page="itemsPerPage"
            hide-default-footer class="elevation-10" item-key="name" no-data-text="No hay información" :loading="loadingVar" loading-text="Cargando información..."
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
                                <v-btn color="green" block class="mr-5" @click="dialogNewProduct = true">+</v-btn>
                            </v-col>
                            <v-col cols="8" class="d-flex justify-space-between">
                                <v-text-field append-icon="mdi-magnify" v-model="search" label="Buscar" class="shrink"
                                    dense filled rounded hide-details single-line></v-text-field>
                            </v-col>
                        </v-row>
                    </v-toolbar>
                </div>
            </template>

            <template v-slot:[`item.actions`]="{}">
                <v-btn color="blue" depressed fab x-small dark class="mr-3">
                    <font-awesome-icon icon="fa-solid fa-pencil" class="fa-xl" />
                </v-btn>
                <v-btn color="error" depressed fab x-small>
                    <font-awesome-icon icon="fa-trash" class="fa-xl" />
                </v-btn>
            </template>
        </v-data-table>
        <v-pagination :length="pageCount" :total-visible="10" v-model="page" class="mt-2"></v-pagination>

        <v-dialog v-model="dialogNewProduct" scrollable persistent :overlay=false max-width="60%"
            transition="dialog-transition">
            <v-card height="60vh">
                <v-card-media src="src" height="100px">
                </v-card-media>
                <v-card-title primary-title>
                    <div>
                        <h3 class="headline mb-0">headline</h3>
                        <div>description</div>
                    </div>
                </v-card-title>
                <v-card-actions>
                    <v-btn color="red" dark @click="dialogNewProduct = false">Cancelar</v-btn>
                    <v-btn text color="primary">text</v-btn>
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
            loadingVar: true,
            itemsPerPage: 12,
            dialogNewProduct: false,
            search: "",
            page: 1,
            pageCount: 0,
            headers: [
                {
                    text: 'PRODUCTO',
                    align: 'start',
                    value: 'albumId'
                },
                { text: 'CATEGORÍA', value: 'id' },
                { text: 'MARCA', value: 'title' },
                { text: 'PRECIO', value: 'url', sortable: false },
                { text: 'UNIDAD', value: 'thumbnailUrl', sortable: false },
                { text: 'ACCIONES', value: 'actions', sortable: false, },
            ],

            photos:[],

            items: [
                {
                    name: 'Cristal templado 5mm',
                    brand: 'Aluval',
                    category: "Cristal",
                    price: 2500,
                    units: "m2"
                },
                {
                    name: 'Martillo',
                    category: 'Herramienta',
                    price: 150,
                    units: 'pieza',
                    brand: 'Truper'
                }
            ]
        }
    },

    methods: {
        async getPhotos(){
            const response = await this.axios.get('https://jsonplaceholder.typicode.com/photos')
            this.photos = response.data
            this.loadingVar = false
        },

        isMobile() {
            const val = (window.innerWidth <= 600 && window.innerHeight <= 1000)
            if(val){
                this.itemsPerPage = 5
            }
            return val
        }
    },

    created() {
        this.getPhotos()
    },

}

</script>

