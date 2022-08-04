<template>
    <v-container grid-list-xs fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="projects" :search="search" :page.sync="page"
            no-results-text="No hay coincidencias" no-data-text="No hay información" :items-per-page="itemsPerPage"
            :expanded.sync="expanded" :single-expand="true" item-key="proy_id" show-expand :loading="loadingVar"
            loading-text="Cargando información..." hide-default-footer class="elevation-10"
            @page-count="pageCount = $event" @item-expanded="getDetails"
            @click:row="(item, slot) => { slot.expand(!slot.isExpanded) }">
            <template v-slot:top>
                    <v-toolbar v-if="!mobile" flat color="primary" dark>
                        <v-row justify="space-between">
                            <v-col cols="auto" class="d-flex align-center">
                                <v-toolbar-title>
                                    Proyectos Activos
                                </v-toolbar-title>
                            </v-col>
                            <v-col cols="auto">
                                <v-text-field v-model="search" append-icon="mdi-magnify" label="Buscar" single-line
                                    hide-details class="shrink" rounded filled dense></v-text-field>
                            </v-col>
                        </v-row>
                    </v-toolbar>
                    <v-toolbar v-else flat height="150px" color="primary" dark>
                        <v-row justify="space-between">
                            <v-col cols="12" class="d-flex justify-center">
                                <v-toolbar-title class="mobile">
                                    Proyectos Activos
                                </v-toolbar-title>
                            </v-col>
                            <v-col cols="12">
                                <v-text-field v-model="search" append-icon="mdi-magnify" label="Buscar" single-line
                                    hide-details class="shrink" rounded filled dense></v-text-field>
                            </v-col>
                        </v-row>
                    </v-toolbar>
            </template>
            <template v-slot:expanded-item="{ headers }">
                <td v-if="!mobile" :colspan="headers.length" style="padding: 0px;">
                    <v-card tile flat>
                        <v-toolbar flat color="blue" dark class="detalles">
                            <v-toolbar-title class="detalles">
                                Detalles del proyecto
                            </v-toolbar-title>
                        </v-toolbar>
                        <v-card-text>
                            <div v-for="(detalles, index) in details" :key="index">
                                <span class="body-1">{{ index + 1 }}. {{ detalles.dp_comentarios }}</span><br>
                            </div>
                        </v-card-text>
                        <v-card-actions>
                            <v-btn color="primary">text</v-btn>
                            <v-btn color="primary">text</v-btn>
                        </v-card-actions>
                    </v-card>
                </td>

                <td v-else class="v-data-table__mobile-row" style="padding: 0px;">
                    <div class="v-data-table__mobile-row__cell" style="width: 100%; text-align: left;">
                        <v-card tile flat>
                            <v-toolbar flat color="blue" dark class="detalles">
                                <v-toolbar-title class="detalles">
                                    Detalles del proyecto
                                </v-toolbar-title>
                            </v-toolbar>
                            <v-card-text>
                                <span v-for="(detalles, index) in details" :key="index" class="body-1">
                                    {{ index + 1 }}.{{ detalles.dp_comentarios }}
                                </span>
                                <br>
                            </v-card-text>
                            <v-card-actions>
                                <v-btn color="primary">text</v-btn>
                                <v-btn color="primary">text</v-btn>
                            </v-card-actions>
                        </v-card>
                    </div>
                </td>
            </template>
        </v-data-table>
        <v-pagination :length="pageCount" v-model="page" :total-visible="totalVisible" class="mt-2"></v-pagination>
    </v-container>
</template>

<script>
export default {
    name: 'Home',
    data() {
        return {
            mobile: "",
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
            this.mobile = window.innerWidth <= 600 && window.innerHeight <= 1000
            if (this.mobile) {
                this.itemsPerPage = 2
                this.totalVisible = 5
            }
        },

        async getProjects() {
            const api = await this.axios.get('/api/inicio/obtenerProyectosActivos')
            this.projects = api.data
            this.loadingVar = false
        },

        async getDetails({ item, value }) {
            if (value) {
                const body = {
                    id: item.proy_id
                }
                const api = await this.axios.post('/api/historial/obtenerDetalles', body)
                this.details = api.data
            }
        }

    },
    created() {
        this.isMobile()
        this.getProjects()
    },

}
</script>

<style>
</style>