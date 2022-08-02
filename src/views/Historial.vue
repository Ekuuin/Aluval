<template>
    <v-container grid-list-xs fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="projects" :search="search" :page.sync="page"
            no-results-text="No hay coincidencias" no-data-text="No hay información" :items-per-page="itemsPerPage"
            :expanded.sync="expanded" single-expand item-key="title" show-expand :loading="loadingVar"
            loading-text="Cargando información..." hide-default-footer class="elevation-10"
            @page-count="pageCount = $event"
            @click:row="(item, slot) => { slot.expand(!slot.isExpanded); if(!slot.isExpanded) getDetails(item) }">
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
            <template v-slot:expanded-item="{ headers }">
                <td :colspan="headers.length">
                    <div v-for="(detalles, index) in details" :key="index">
                        <span>{{ index + 1 }}.- {{ detalles.dp_comentarios }}</span><br>
                    </div>
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
                { text: 'ID', value: 'proy_id' },
                { text: 'CLIENTE', align: 'start', sortable: false, value: 'proy_cliente', },
                { text: 'DOMICILIO', value: 'proy_domicilio' },
                { text: 'FECHA', value: 'proy_fecha' },
                { text: 'IMPORTE', value: 'proy_total' },
                { text: '', value: 'data-table-expand' },
            ],
            projects: [],
            details: [],

        }
    },
    methods: {
        isMobile() {
            const val = window.innerWidth <= 600 && window.innerHeight <= 1000
            if (val) {
                this.itemsPerPage = 2
                this.totalVisible = 5
            }
            return val
        },

        async getProjects() {
            const api = await this.axios.get('/api/historial/obtenerProyectos')
            this.projects = api.data
            this.loadingVar = false
        },

        async getDetails(item) {
            const body = {
                id: item.proy_id
            }
            console.log("🚀 ~ file: Historial.vue ~ line 93 ~ getDetails ~ body", body)

            const api = await this.axios.post('/api/historial/obtenerDetalles', body)
            this.details = api.data
            console.log("🚀 ~ file: Historial.vue ~ line 95 ~ getDetails ~ api.data", api.data)
        }

    },
    created() {
        this.getProjects()
    },

}
</script>

<style>
</style>