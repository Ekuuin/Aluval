<template>
    <v-container grid-list-xs fluid style="height: 100%;">
        <v-data-table :headers="headers" :items="projects" :search="search" :page.sync="page"
            no-results-text="No hay coincidencias" no-data-text="No hay información" :items-per-page="itemsPerPage"
            :expanded.sync="expanded" :single-expand="true" item-key="proy_id" show-expand :loading="loadingVar"
            loading-text="Cargando información..." hide-default-footer class="elevation-10" @page-count="pageCount = $event"
            @item-expanded="getDetails" @click:row="(item, slot) => { slot.expand(!slot.isExpanded) }">
            <template v-slot:top>
                <v-toolbar flat color="primary" dark>
                    <v-row justify="space-between">
                        <v-col cols="auto" class="d-flex align-center">
                            <v-toolbar-title>
                                HISTORIAL DE PROYECTOS
                            </v-toolbar-title>
                        </v-col>
                        <v-col cols="auto">
                            <v-text-field v-model="search" append-icon="mdi-magnify" label="Buscar" single-line hide-details
                                class="shrink" rounded filled dense></v-text-field>
                        </v-col>
                    </v-row>
                </v-toolbar>
            </template>

            <template v-slot:item.actions="{ item }">
                <router-link style="text-decoration: none !important;" :to="{ name: 'editar', params: { id: item.proy_id } }">
                    <v-btn color="blue" depressed fab x-small dark>
                        <font-awesome-icon icon="fa-solid fa-pencil" class="fa-xl" />
                    </v-btn>
                </router-link>
                <router-link style="text-decoration: none !important;" :to="{ name: 'pdf', params: { id: item.proy_id } }"
                    class="ml-3">
                    <v-btn color="orange" depressed fab x-small dark>PDF</v-btn>
                </router-link>
                <v-btn class="ml-3" color="error" depressed fab x-small @click="id = item.proy_id, showDeleteAlert()">
                    <font-awesome-icon icon="fa-trash" class="fa-xl" />
                </v-btn>


            </template>

            <template v-slot:expanded-item="{ headers, item }">
                <td :colspan="headers.length" style="padding: 0px 25px; background-color: #EAEAEA;">
                    <v-card flat>
                        <v-toolbar flat color="blue" dark class="detalles">
                            <v-toolbar-title class="detalles">
                                Detalles del proyecto #{{ item.proy_id }}
                            </v-toolbar-title>
                        </v-toolbar>
                        <v-card-text>
                            <v-container fluid>
                                <v-row no-gutters>
                                    <v-col :cols="cols[index]" v-for="(item, index) in textoDetalles" :key="index">
                                        <v-card outlined tile class="pl-1">
                                            <span class="title font-weight-black">{{ item }}</span>
                                        </v-card>
                                    </v-col>
                                </v-row>

                                <v-row v-for="(detalles, index) in details" :key="index" no-gutters>
                                    <v-col cols="1" class="d-flex flex-column">
                                        <v-card outlined tile class="flex pl-1">
                                            <span class="subtitle-1"> {{ index + 1 }}
                                            </span>
                                        </v-card>
                                    </v-col>
                                    <v-col cols="2" class="d-flex flex-column">
                                        <v-card tile outlined class="flex pl-1">
                                            <span class="subtitle-1">{{ types[detalles.dp_tipo] }}</span>
                                        </v-card>
                                    </v-col>
                                    <v-col cols="2" class="d-flex flex-column">
                                        <v-card tile outlined class="flex pl-1">
                                            <span class="subtitle-1">Altura: {{ detalles.dp_altura }}
                                                Ancho: {{ detalles.dp_ancho }}</span>
                                        </v-card>
                                    </v-col>
                                    <v-col cols="7" class="d-flex flex-column">
                                        <v-card tile outlined class="flex pl-1">
                                            <span class="subtitle-1">
                                                {{ detalles.dp_comentarios }}
                                            </span>
                                        </v-card>
                                    </v-col>
                                </v-row>

                            </v-container>
                        </v-card-text>
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
            id: "",
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
                { text: 'ACCIONES', value: 'actions', sortable: false },
                { text: '', value: 'data-table-expand' },
            ],
            projects: [],
            details: [],
            types: ['Ventana Corrediza', 'Ventana Fija', 'Puerta Económica', 'Puerta Línea Española'],
            textoDetalles: ['#', 'Tipo', 'Medidas', 'Descripción'],
            cols: ['1', '2', '2', '7']

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

        async deleteProject() {
            const body = {
                id: this.id
            }
            await this.axios.post('/api/historial/borrarProyecto', body)
            this.getProjects()
            this.showAlertSuccess()
        },

        async updateStatus(status, id) {
            const body = {
                status: status,
                id: id
            }
            await this.axios.post('/api/historial/actualizarEstatus', body)
            this.getProjects()
        },

        showDeleteAlert() {
            // Use sweetalert2
            this.$swal({
                title: '¿Quieres eliminar este proyecto?',
                icon: 'warning',
                confirmButtonText: 'Sí',
                cancelButtonText: 'No',
                confirmButtonColor: '#4caf50',
                cancelButtonColor: '#ff6060',
                showLoaderOnConfirm: true,
                showCancelButton: true
            }).then((result) => {
                if (result.isConfirmed) {
                    this.deleteProject()
                }
            })
        },

        showAlertSuccess() {
            // Use sweetalert2
            this.$swal({
                title: 'El proyecto fue eliminado correctamente.',
                icon: 'success',
                confirmButtonText: 'OK',
                confirmButtonColor: '#4caf50',
                showLoaderOnConfirm: true
            }).then((result) => {
            })
        }
    },
    created() {
        this.getProjects()
    },

}
</script>

<style></style>