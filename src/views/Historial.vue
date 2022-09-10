<template>
    <v-container grid-list-xs fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="projects" :search="search" :page.sync="page"
            no-results-text="No hay coincidencias" no-data-text="No hay información" :items-per-page="itemsPerPage"
            :expanded.sync="expanded" :single-expand="true" item-key="proy_id" show-expand :loading="loadingVar"
            loading-text="Cargando información..." hide-default-footer class="elevation-10"
            @page-count="pageCount = $event" @item-expanded="getDetails"
            @click:row="(item, slot) => { slot.expand(!slot.isExpanded) }">
            <template v-slot:top>
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
            </template>

            <template v-slot:item.estado="{ item }">
                <v-chip :color="getColor(item.proy_estado)" text-color="white">{{ item.proy_estado }}</v-chip>
            </template>

            <template v-slot:expanded-item="{ headers, item }">
                <td :colspan="headers.length" style="padding: 0px;">
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
                            <v-btn v-if="!(item.proy_estado === 'FINALIZADO' || item.proy_estado === 'CANCELADO')"
                                @click="updateStatus('CANCELADO', item.proy_id)" color="error">Cancelar</v-btn>
                            <v-btn v-if="item.proy_estado === 'PENDIENTE'" color="success"
                                @click="updateStatus('ACTIVO', item.proy_id)">Aceptar</v-btn>
                            <v-btn v-if="item.proy_estado === 'ACTIVO'"
                                @click="updateStatus('FINALIZADO', item.proy_id)" color="success">Finalizar</v-btn>
                            <router-link :to="{name: 'pdf', params: {id: item.proy_id}}" class="ml-2">
                                <v-btn color="blue" dark>PDF</v-btn>
                            </router-link>
                        </v-card-actions>
                    </v-card>
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
                { text: 'ESTADO', value: 'estado', sortable: false },
                { text: '', value: 'data-table-expand' },
            ],
            projects: [],
            details: [],

        }
    },
    methods: {
        async getProjects() {
            const api = await this.axios.get('/api/historial/obtenerProyectos')
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
        },

        async updateStatus(status, id) {
            const body = {
                status: status,
                id: id
            }
            await this.axios.post('/api/historial/actualizarEstatus', body)
            this.getProjects()
        }
        ,

        getColor(status) {
            if (status === 'ACTIVO')
                return 'warning'
            else if (status === 'CANCELADO')
                return 'error'
            else if (status === 'PENDIENTE')
                return 'grey'
            else
                return 'green'
        }

    },
    created() {
        this.getProjects()
    },

}
</script>

<style>

</style>