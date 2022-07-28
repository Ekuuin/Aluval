<template>
    <v-container grid-list-xs fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="photos" :search="search" :page.sync="page" no-results-text="No hay coincidencias" no-data-text="No hay información"
            :items-per-page="itemsPerPage" :expanded.sync="expanded" single-expand item-key="title" show-expand :loading="loadingVar" loading-text="Cargando información..."
            hide-default-footer class="elevation-10" @page-count="pageCount = $event">
            <template v-slot:top>
                <div v-if="!isMobile()">
                    <v-toolbar flat color="primary" dark>
                        <v-row justify="space-between">
                            <v-col cols="auto" class="d-flex align-center">
                                <v-toolbar-title>
                                    HISTORIAL DE PROYECTOS
                                </v-toolbar-title>
                            </v-col>
                            <v-col cols="auto">
                                <v-text-field v-model="search" append-icon="mdi-magnify" label="Buscar" single-line
                                    hide-details class="shrink" rounded filled dense></v-text-field>
                            </v-col>
                        </v-row>
                    </v-toolbar>
                </div>
                <div v-else>
                    <v-toolbar flat height="150px" color="primary" dark>
                        <v-row justify="space-between">
                            <v-col cols="12" class="d-flex justify-center">
                                <v-toolbar-title class="mobile">
                                    HISTORIAL DE PROYECTOS
                                </v-toolbar-title>
                            </v-col>
                            <v-col cols="12">
                                <v-text-field v-model="search" append-icon="mdi-magnify" label="Buscar" single-line
                                    hide-details class="shrink" rounded filled dense></v-text-field>
                            </v-col>
                        </v-row>
                    </v-toolbar>
                </div>
            </template>
            <template v-slot:expanded-item="{ headers, item }">
                <td :colspan="headers.length">
                    More info about {{ item.title }}
                </td>
            </template>
        </v-data-table>
        <v-pagination :length="pageCount" v-model="page" :total-visible="totalVisible" class="mt-2"></v-pagination>
    </v-container>
</template>

<script>
export default {
    name: 'Historial',
    data() {
        return {
            totalVisible: 10,
            loadingVar: true,
            itemsPerPage: 10,
            search: '',
            page: 1,
            pageCount: 0,
            expanded: [],
            headers: [
                {
                    text: 'CLIENTE',
                    align: 'start',
                    sortable: false,
                    value: 'title',
                },
                { text: 'DOMICILIO', value: 'url'},
                { text: 'FECHA', value: 'id' },
                { text: 'IMPORTE', value: 'albumId' },
                { text: '', value: 'data-table-expand' },
            ],
            desserts: [
                {
                    name: 'Panfilo',
                    address: "Cerezos #17",
                    date: "11/05/2022",
                    cost: 2300,
                },
                {
                    name: 'Chuchin la burra',
                    address: "Marfil #14",
                    date: "10/04/2022",
                    cost: 4500,
                },
            ],

            photos: []
        }
    },
    methods: {
        async getPhotos(){
            const response = await this.axios.get('https://jsonplaceholder.typicode.com/photos')
            this.photos = response.data
            this.loadingVar = false
        },

        isMobile() {
            const val = window.innerWidth <= 600 && window.innerHeight <= 1000
            if(val){
                this.itemsPerPage = 2
                this.totalVisible = 5
            }
            return val
        },
    },
    created() {
        this.getPhotos()
    },

}
</script>

<style>
</style>