<template>
    <v-container fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="items" :search="search" :page.sync="page" :items-per-page="15"
            hide-default-footer class="elevation-10" item-key="name" no-data-text="No hay información"
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
        <v-pagination :length="pageCount" v-model="page" class="mt-2"></v-pagination>

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
                    <v-btn text color="primary">text</v-btn>
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
            dialogNewProduct: false,
            search: "",
            page: 1,
            pageCount: 0,
            headers: [
                {
                    text: 'PRODUCTO',
                    align: 'start',
                    value: 'name'
                },
                { text: 'CATEGORÍA', value: 'category' },
                { text: 'MARCA', value: 'brand' },
                { text: 'PRECIO', value: 'price', sortable: false },
                { text: 'UNIDAD', value: 'units', sortable: false },
                { text: 'ACCIONES', value: 'actions', sortable: false, },
            ],

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
        isMobile() {
            return (window.innerWidth <= 600 && window.innerHeight <= 1000)
        }
    }

}

</script>

