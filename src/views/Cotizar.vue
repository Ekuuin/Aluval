<template>
    <v-container fluid style="height:100%">
        <v-card height="100%">
            <v-toolbar flat color="primary" dark>
                <v-spacer></v-spacer>
                <v-toolbar-title>
                    COTIZACIÓN
                </v-toolbar-title>
                <v-spacer></v-spacer>
            </v-toolbar>
            <v-card-text>
                <v-container fluid class="rowSpacing">
                    <br>
                    <v-row justify="center"
                        style="background-color: #2196f3; height: 38px; margin-left: 0; margin-right: 0;">
                        <v-col cols="auto" class="d-flex align-center" style="padding: 0;">
                            <span class="overline" style="font-size: 20px !important; color: white;">
                                Información del cliente
                            </span>
                        </v-col>
                    </v-row>
                    <br>
                    <v-row justify="center">
                        <v-col cols="3">
                            <v-text-field v-model="newProject.customer" name="customer" label="Nombre del cliente"
                                prepend-inner-icon="mdi-account" outlined hide-details></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row justify="center">
                        <v-col cols="3">
                            <v-text-field v-model="newProject.address" name="address" label="Dirección del cliente"
                                prepend-inner-icon="mdi-map-marker" outlined hide-details>
                            </v-text-field>
                        </v-col>
                    </v-row>
                    <br>
                    <v-data-table :headers="headers" :items="newProject.product" :page.sync="page"
                        no-results-text="No hay coincidencias" no-data-text="No hay información" :items-per-page=3
                        class="elevation-1" hide-default-footer @page-count="pageCount = $event">
                        <template v-slot:top>
                            <v-toolbar class="detalles" flat color="blue" dark>
                                <v-spacer></v-spacer>
                                <v-toolbar-title class="ml-16" style="font-size: 20px !important;">
                                    Información de los productos
                                </v-toolbar-title>
                                <v-spacer></v-spacer>
                                <v-btn color="success" @click="addRow()">+</v-btn>
                            </v-toolbar>
                        </template>

                        <template v-slot:item="{ item }">
                            <tr>
                                <td>
                                    <v-autocomplete label="Tipo de trabajo" :items="items" v-model="item.type"
                                        @change="getCost()">
                                    </v-autocomplete>
                                </td>
                                <td>
                                    <v-autocomplete :items='cristales' item-value="pro_id" item-text="pro_name"
                                        clearable return-object v-model="item.cristal" @change="getCost()">
                                    </v-autocomplete>
                                </td>
                                <td>
                                    <v-autocomplete :items='perfiles' item-value="pro_id" item-text="pro_name"
                                        return-object v-model="item.perfil" @change="getCost()">
                                    </v-autocomplete>
                                </td>
                                <td>
                                    <v-checkbox v-show="item.type === 0" v-model="item.mosq" @change="getCost()">
                                    </v-checkbox>
                                </td>
                                <td>
                                    <v-text-field v-model="item.quantity" min="0" type="number" @change="getCost()"
                                        @click="getCost()">
                                    </v-text-field>
                                </td>
                                <td>
                                    <v-text-field name="Ancho" v-model="item.width" label="metros" @change="getCost()"
                                        @click="item.width = ''">
                                    </v-text-field>
                                </td>
                                <td>
                                    <v-text-field name="Altura" v-model="item.height" label="metros"
                                        @click="item.height = ''" @change="getCost()"></v-text-field>
                                </td>
                                <td>
                                    <v-text-field name="Cost" v-model="item.cost" @change="getTotal()">
                                    </v-text-field>
                                </td>
                                <td>
                                    <v-textarea auto-grow v-model="item.comments" placeholder="Descripción del trabajo"
                                        rows="1" solo hide-details></v-textarea>
                                </td>
                            </tr>
                        </template>
                    </v-data-table>
                    <v-pagination :length="pageCount" v-model="page" :total-visible=5 class="mt-2">
                    </v-pagination>
                </v-container>
            </v-card-text>
            <v-card-actions>
                <v-container fluid>
                    <v-row no-gutters>
                        <v-col class="d-flex align-center" cols="2" offset="5">
                            <v-btn color="success" block @click="createProject()">Crear orden</v-btn>
                        </v-col>
                        <v-col cols="3" align-self="auto" class="text-right" offset="1">
                            <span class="title" style="color: #666666;">
                                COSTOS ADICIONALES:&nbsp;<br>
                                SUBTOTAL:&nbsp;<br>
                                I.V.A:&nbsp;<br>
                                TOTAL:&nbsp;
                            </span>
                        </v-col>
                        <v-col cols="1" align-self="auto">
                            <v-text-field v-model="extra" @change="getTotal()" single-line dense hide-details
                                label="Ingrese costos">
                            </v-text-field>
                            <v-text-field v-model="subtotal" readonly single-line dense hide-details></v-text-field>
                            <v-text-field v-model="iva" readonly single-line dense hide-details></v-text-field>
                            <v-text-field v-model="newProject.total" readonly single-line dense hide-details>
                            </v-text-field>
                        </v-col>
                    </v-row>
                </v-container>
            </v-card-actions>
        </v-card>
    </v-container>
</template>

<script>

export default {
    name: 'Cotizar',
    data() {
        return {
            page: 1,
            pageCount: 0,
            newProject: {
                customer: null,
                address: null,
                product: [{
                    cristal: null,
                    perfil: "",
                    type: "",
                    quantity: 0,
                    width: 0,
                    height: 0,
                    cost: 0,
                    mosq: false,
                    comments: ""
                }],
                total: 0
            },

            iva: 0,
            extra: 0,
            subtotal: 0,
            cristales: [],
            perfiles: [],

            headers: [
                { text: 'TIPO', width: 'auto', sortable: false },
                { text: 'CRISTAL', width: 'auto', sortable: false },
                { text: 'PERFIL', width: 'auto', sortable: false },
                { text: 'MOSQ', width: '1', sortable: false },
                { text: 'CANTIDAD', width: '1', sortable: false },
                { text: 'ANCHO', width: '1', sortable: false },
                { text: 'ALTURA', width: '1', sortable: false },
                { text: 'COSTO', width: '1', sortable: false },
                { text: 'COMENTARIO', width: '25%', sortable: false }
            ],

            items: [
                { text: 'Corrediza', value: 0 },
                { text: 'Fija', value: 1 },
                { text: 'Puerta económica', value: 2 },
                { text: 'Puerta línea española', value: 3 }
            ]
        }
    },

    created() {
        this.getCristales()
        this.getPerfiles()
    },

    methods: {
        async createProject() {
            const response = await this.axios.post('/api/cotizacion/nuevoProyecto', this.newProject)
            this.showAlert()
        },

        async getCristales() {
            const apiData = await this.axios.get('/api/cotizacion/obtenerCristales')
            this.cristales = apiData.data
        },

        async getPerfiles() {
            const apiData = await this.axios.get('/api/cotizacion/obtenerPerfiles')
            this.perfiles = apiData.data
        },

        getCost() {
            for (let product of this.newProject.product) {
                if (product.width != 0 && product.height != 0) {
                    product.cost = 0
                    if (product.cristal != null) {
                        product.cost += Number(product.cristal?.pro_cost) * Number(product.width) * Number(product.height)
                    }
                    product.cost += this.calculateAddons(product.type, product.perfil, Number(product.width), Number(product.height), product.mosq)
                    product.cost *= product.quantity
                }
            }
            this.getTotal()
        },

        calculateAddons(type, perfil, width, height, mosq) {
            switch (type) {
                /**
                 * *Calculo para corrediza
                 */
                case 0:
                    var jamba, mosquitero, riel, adaptador, cerco, traslape, zoclo, zoclito;
                    jamba = perfil.jambaC * (width + 2 * height)
                    mosquitero = perfil.mosquiteroC * (width + 2 * height)
                    if (!mosq) {
                        mosquitero = 0
                    }
                    riel = perfil.rielC * width
                    adaptador = perfil.adaptadorC * width
                    cerco = traslape = perfil.traslapeC * 2 * height
                    zoclo = zoclito = perfil.zocloC * width
                    return jamba + mosquitero + riel + adaptador + cerco + traslape + zoclo + zoclito

                case 1:
                    /**
                     * *Calculo para fija
                     */
                    var bolsa, escalonado, junquillo
                    bolsa = perfil.bolsaF * 2 * height
                    escalonado = perfil.escalonadoF * 2 * width
                    junquillo = perfil.junquilloF * 2 * width
                    return bolsa + escalonado + junquillo

                case 2:
                    /**
                     * *Calculo para puerta económica
                     */
                    var marco, cerco, zoclo
                    marco = perfil.marcoPE * (2 * height + width)
                    cerco = perfil.cercoPE * 2 * height
                    zoclo = perfil.zocloPE * 2 * width
                    return marco + cerco + zoclo

                case 3:
                    /**
                     * *Calculo para puerta línea española
                     */
                    var fijoTubular, hoja, zoclo, junquillo
                    fijoTubular = perfil.tubularPEsp * (2 * height + width)
                    hoja = perfil.hojaPEsp * 2 * height
                    zoclo = perfil.zocloPEsp * 2 * width
                    junquillo = perfil.junquilloPEsp * 2 * width
                    return fijoTubular + hoja + zoclo + junquillo

                default:
                    break;
            }
        },

        addRow() {
            this.newProject.product.push({
                productId: "",
                perfil: "",
                cristal: "",
                type: "",
                special: '',
                quantity: 0,
                width: 0,
                height: 0,
                cost: 0,
                comments: ""
            })
        },

        showAlert(value) {
            // Use sweetalert2
            this.$swal({
                title: 'Proyecto generado correctamente!',
                icon: 'success',
                confirmButtonText: 'OK',
                showLoaderOnConfirm: true
            }).then((result) => {
                if (result.isConfirmed || result.isDismissed) {
                    this.$router.go()
                }
            })
        },

        getTotal() {
            this.subtotal = 0
            for (let prod of this.newProject.product) {
                this.subtotal += Number(prod.cost)
            }
            this.subtotal += Number(this.extra)
            this.subtotal = Number(this.subtotal.toFixed(2))
            this.iva = Number((this.subtotal * 0.16).toFixed(2))
            this.newProject.total = this.iva + this.subtotal
        }
    }
}

</script>

<style>
.v-input__slot {
    align-items: center;
    justify-content: center;
}
</style>