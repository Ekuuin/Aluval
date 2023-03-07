<template>
    <vue-html2pdf :show-layout="false" :float-layout="true" :enable-download="true" :preview-modal="false"
        :paginate-elements-by-height="1000" :manual-pagination="false" pdf-content-width="100%" ref="html2Pdf"
        :html-to-pdf-options="options">
        <section slot="pdf-content">
            <!-- PDF Content Here -->
            <section class="pdf-item">
                <v-container fluid>
                    <v-row no-gutters style="margin-left: 10px; margin-right: 15px; margin-bottom: 10px;">
                        <v-col cols="auto">
                            <img src="@/assets/logoVb.png" width="110">
                        </v-col>
                        <v-col cols="auto" style="margin-left: 10px;">
                            <span style="font-weight: 800;"> ALUVAL PÉNJAMO S.A. de
                                C.V.
                                <br>
                            </span>
                            <span class="textS">
                                CALLE PROLONGACIÓN ALDAMA #85 <br>
                                COLONIA LA LOMA <br> PÉNJAMO, GUANAJUATO <br>
                                4691242049 &nbsp;&nbsp;&nbsp; raul.jvm90@gmail.com
                            </span>
                        </v-col>
                        <v-spacer></v-spacer>
                        <v-col cols="auto" style="text-align: right !important;">
                            <span class="textS">
                                {{ this.projectInfo[0]?.proy_fecha }} <br><br>
                                DIVISA: MXN
                            </span>
                        </v-col>
                    </v-row>
                    <v-divider></v-divider>
                    <v-divider></v-divider>
                    <v-row style="margin-left: 10px; margin-right: 10px;">
                        <v-col>
                            <span class="textS">PRESUPUESTO:&nbsp;&nbsp;{{
                                    String(this.projectInfo[0]?.proy_id).padStart(7,
                                        'AV00000')
                            }}</span>
                            <br>
                            <span class="textS">CLIENTE:&nbsp;&nbsp;{{
                                    this.projectInfo[0]?.proy_cliente
                            }}</span>
                        </v-col>
                    </v-row>
                    <v-divider></v-divider>
                    <v-divider></v-divider>
                    <v-row style="margin-left: 10px; margin-right: 10px; margin-bottom: 5px; margin-top: 0.5px;">
                        <v-col>
                            <span class="textS">Estimado(a)
                                cliente(a): <br>
                                Conforme a lo que Ud. solicitó, le presentamos el presupuesto de los productos de
                                acuerdo
                                con los datos que nos proporcionó.
                                A continuación tiene un desglose de cada uno de los conceptos:
                            </span>
                        </v-col>
                    </v-row>
                </v-container>
            </section>

            <section class="pdf-item" v-for="(products, index) in productsInfo" :key="index">
                <v-row style="border-style: solid; border-width: 2px; margin: 0px auto -2px; height: 220px;">
                    <v-col cols="3" style="justify-content: center; display: flex; align-self: center;">
                        <img v-if="products.dp_tipo == 0" src="@/assets/corrediza.jpg">
                        <img v-else-if="products.dp_tipo == 1" src="@/assets/fijo.png">
                        <img v-else src="@/assets/puerta.png" width="105px">
                    </v-col>
                    <v-col cols="7">
                        <span class="textS">MEDIDAS<br></span>
                        <span class="subText">ANCHO(H): {{ products.dp_ancho }}m</span>
                        <span class="subText">&nbsp;&nbsp;&nbsp; ALTO(V): {{ products.dp_altura }}m</span><br><br>
                        <span class="textS">PERFIL: </span>
                        <span class="subText">{{ products['p2.pro_name'].toUpperCase() }}</span><br>
                        <span class="textS">CRISTAL: </span>
                        <span v-if="products.pro_name != null" style="font-size: small;">{{
                                products.pro_name.toUpperCase()
                        }}</span>
                        <span v-else style="font-size: small;">N/A</span><br><br>
                        <span class="textS">DESCRIPCIÓN</span><br>
                        <pre class="subText" style="white-space: pre-wrap;">{{ products.dp_comentarios }}</pre>
                    </v-col>
                    <v-col cols="2">
                        <span class="textS">CANTIDAD: </span><br>
                        <span style="font-size: small;">{{ products.dp_cantidad }}</span><br>
                        <span class="textS">COSTO: </span><br>
                        <span style="font-size: small;">${{ ((Number(products.dp_costo) - Number(products.dp_extra)) /
                                products.dp_cantidad).toFixed(2)
                        }}</span><br>
                        <span class="textS">ADICIONALES</span><br>
                        <span style="font-size: small">${{ products.dp_extra }}</span>
                        <br>
                        <span class="textS">TOTAL:</span><br>
                        <span style="font-size: small;">${{ (Number(products.dp_costo)).toFixed(2) }}</span>
                    </v-col>
                </v-row>
            </section>

            <section class="pdf-item">
                <br><br>
                <v-container fluid>
                    <v-divider></v-divider>
                    <v-divider></v-divider>
                    <v-row style="margin-left: 10px; margin-right: 10px; justify-content: flex-end !important;">
                        <v-col cols="auto" style="text-align: right !important;">
                            <span style="13">
                                IMPORTE CANCELERÍA Y ADICIONALES: <br>
                                I.V.A: <br>
                                TOTAL:
                            </span>
                        </v-col>
                        <v-col cols="auto" style="text-align: right !important;">
                            <span class="textM">
                                ${{ (this.projectInfo[0]?.proy_total / 1.16).toFixed(2) }} <br>
                                ${{ (this.projectInfo[0]?.proy_total - (this.projectInfo[0]?.proy_total /
                                        1.16)).toFixed(2)
                                }} <br>
                                ${{ this.projectInfo[0]?.proy_total }}
                            </span>
                        </v-col>
                    </v-row>
                    <v-divider></v-divider>
                    <v-divider></v-divider>
                </v-container>
            </section>

            <section class="pdf-item">
                <v-container fluid>
                    <v-row>
                        <v-col style="line-height: 92%; text-align: justify;">
                            <span class="textXS">
                                CLÁUSULAS DEL PRESUPUESTO-CONTRATO <br>

                                - Precios unitarios en Pesos Mexicanos. Están sujetos a cambio sin previo aviso (excepto
                                con
                                anticipo recibido). Válidos durante 15 días y únicamente para estas medidas y
                                especificaciones. <br>
                                - El precio es puesto en planta. No se consideran fletes. <br>
                                - Si el cliente requiere que se contrate flete para entrega en su domicilio, el costo y
                                el
                                riesgo
                                por daños correrá por su cuenta. <br>
                                - El anticipo es del 60% al aceptar el presupuesto y el resto contra aviso de entrega.
                                <br>
                                - AluVal se reserva el derecho de propiedad de dominio de sus productos hasta que sean
                                pagados en su
                                totalidad. <br>
                                - Es obligación del cliente revisar que todos y cada uno de los conceptos cotizados sean
                                los
                                correctos. Una vez autorizando la producción el cliente es 100% responsable de lo que
                                solicitó. <br>
                                - La aceptación del Presupuesto-Contrato tendrá que ser notificado a través del correo
                                electrónico o
                                en las instalaciones de la Empresa con la firma de ambas partes del
                                Presupuesto-Contrato,
                                especificándose claramente el número de presupuesto y versión. <br>
                                - Si la obra tiene modificaciones después de haber comenzado la producción, éstas
                                deberán
                                solicitarse al agente de ventas para que envíe una nueva versión del presupuesto, misma
                                que
                                el
                                cliente deberá firmar de conformidad. No se admiten modificaciones a la obra que no
                                hayan
                                pasado por
                                éste procedimiento, por ejemplo notificaciones por correo electrónico o WhatsApp. <br>
                                - Los cambios de medida y/o especificaciones cambiarán los precios y/o tiempos de
                                entrega.
                                <br>
                                - Si la obra lleva materiales especiales, que AluVal no maneje de línea y que ya hayan
                                sido
                                pedidos
                                o fabricados, éstos no podrán ser cancelados. <br>
                                - El tiempo de entrega será pactado por ambas partes: iniciando una vez recibido el
                                anticipo
                                y
                                croquis con medidas de fabricación firmadas. Éstas medidas de fabricación deben tener ya
                                considerado
                                el descuento respecto al vano necesario para instalación. <br>
                                - Las tolerancias máximas en producto terminado serán de ± 2mm. de la medida de
                                fabricación.
                                <br>
                                - Todo se cotiza con vista interior, los abatimientos se cotizan con apertura interior,
                                excepto las
                                de proyección. Si el cliente necesita que alguna(s) piezas se fabriquen con apertura
                                exterior debe
                                especificarlo. El cliente también debe revisar el sentido de la apertura: derecha o
                                izquierda. <br>
                                - La empresa garantiza sólo la mano de obra y materiales suministrados por AluVal/Raul
                                Valdes
                                Melendez. Cuando los canceles excedan las dimensiones recomendadas por el fabricante, no
                                aplicará la
                                garantía. <br>
                                - El tono de los materiales pueden variar un poco de acuerdo a los lotes de producción y
                                fabricante.
                                Los herrajes, vinilos y felpas se colocarán en color gris o negro a menos de que el
                                cliente
                                escoja,
                                defina o elija otro color existente. <br>
                                - En caso de producción en serie todas las medidas deben ser exactamente iguales
                                (mediante
                                pre
                                marcos o escantillón suministrado y usado por el cliente). <br>
                                - En cristales templados cumplimos con la Norma Oficial Mexicana NOM-146-SCFI-2001 y la
                                norma de USA
                                ANSI Z 97.1Todos los cristales de Color sin templar, pueden sufrir roturas por choque
                                térmico por lo
                                que AluVal/Raul Valdes Melendez no se hace responsable de la rotura tres días después de
                                haber sido
                                colocado el cristal. <br>
                                - El cliente debe revisar el producto y tiene hasta 24 hrs para hacer cualquier
                                observación.
                                Posteriormente ya no se aceptarán reclamaciones. <br>
                                - En caso de que El Cliente solicite la fabricación en más de dos etapas, se aplicará un
                                porcentaje
                                de cargo extra (o se reducirá el descuento otorgado) debido a que la optimización ya no
                                será
                                la
                                misma con la que se realizó el presupuesto. <br>
                            </span>
                        </v-col>
                    </v-row>
                    <br>
                    <v-divider></v-divider>
                    <v-divider></v-divider>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <v-row>
                        <v-col style="text-align: center;">
                            <span class="textS">
                                ______________________________ <br>
                                {{ this.projectInfo[0]?.proy_cliente }}
                            </span>

                        </v-col>
                        <v-col style="text-align: center;">
                            <span class="textS" style="text-decoration: underline;">
                                _____RAUL VALDES MELENDEZ_____ <br>
                            </span>
                            <span class="textS">
                                ALUVAL S.A. de C.V. <br>
                            </span>
                        </v-col>
                    </v-row>
                </v-container>

            </section>

        </section>
    </vue-html2pdf>
</template>

<script>
import VueHtml2pdf from 'vue-html2pdf'

export default {
    data() {
        return {
            options: {
                margin: [1.5, 1.5],

                filename: 'Presupuesto-ID' + this.id + '.pdf',

                image: {
                    type: 'jpg',
                    quality: 2
                },

                enableLinks: false,

                html2canvas: {
                    scale: 1.5,
                },

                jsPDF: {
                    unit: 'cm',
                    format: 'a4',
                    orientation: 'portrait'
                }
            },

            projectInfo: '',
            productsInfo: ''
        }
    },

    methods: {

        async getProject() {
            const apiData = await this.axios.get('/api/pdf/obtenerProyecto/' + this.id)
            this.projectInfo = apiData.data

        },

        async getProducts() {
            const apiData = await this.axios.get('/api/pdf/obtenerProductos/' + this.id)
            this.productsInfo = apiData.data
        },

        /*
            Generate Report using refs and calling the
            refs function generatePdf()
        */
        generateReport() {
            this.$refs.html2Pdf.generatePdf()
            this.$router.go(-1)
        },
    },

    components: {
        VueHtml2pdf
    },

    created() {
        Promise.all([this.getProducts(), this.getProject()]).then(() => this.generateReport())
    },

    props: {
        id: {}
    }
}
</script>

<style scoped>
span {
    font-family: 'Roboto', sans-serif;
}

pre {
    font-family: 'Roboto', sans-serif;
}

.subText {
    font-size: 12px;
}
.textS {
    font-size: small;
    font-weight: 600;
}

.textM {
    font-size: medium;
    font-weight: 600;
}

.textXS {
    font-size: 10px;
    font-weight: 900;
}
</style>>