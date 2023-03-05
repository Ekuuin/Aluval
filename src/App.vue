<template>
  <v-app>
    <v-app-bar app color="primary" dark height="100px">
      <div class="d-flex align-center">
        <v-img alt="ALUVAL Logo" class="shrink mr-2" contain src="@/assets/logoWeb.png"
          transition="scale-transition" />
      </div>

      <v-spacer></v-spacer>

      <div>
        <router-link :to="{ name: 'cotizar' }" class="mr-5">
          <v-btn text x-large>
            <span>
              Cotizar
            </span>
          </v-btn>
        </router-link>

        <router-link :to="{ name: 'inventario' }" class="mr-5">
          <v-btn text x-large>
            <span>
              Inventario
            </span>
          </v-btn>
        </router-link>

        <router-link :to="{ name: 'historial' }">
          <v-btn text x-large>
            <span>
              Historial
            </span>
          </v-btn>
        </router-link>
      </div>

    </v-app-bar>
    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data: () => ({
  }),

  created() {
  },
};
</script>

<style lang="scss">#app{background-color:#2575B0}.swal2-container.swal2-center>.swal2-popup{font-family:'Montserrat',sans-serif;font-weight:300!important}.v-data-table>.v-data-table__wrapper>table>thead>tr>th{font-size:20px!important}.v-data-table>.v-data-table__wrapper>table>tbody>tr>td{font-size:16px!important}.v-toolbar__title.detalles{font-size:1em!important;height:auto}header.v-toolbar.detalles,header.v-toolbar.detalles>.v-toolbar__content{height:auto!important}.v-toolbar__title{font-size:1.5rem!important;font-weight:500;letter-spacing:0.17em;text-transform:uppercase;font-family:'Roboto',sans-serif}.v-toolbar__title.mobile{font-size:1.2em!important;font-weight:500;letter-spacing:0.17em;text-transform:uppercase;font-family:'Roboto',sans-serif}.v-data-table>.v-data-table__wrapper>table>tbody>tr>td>.v-data-table__mobile-row__cell{word-break:break-word;width:50%}.rowSpacing>.row+.row{margin-top:0px}.v-card__text{padding:10px!important}.v-divider{border-color:rgba(0,0,0,0.4)!important}.wtext{display:inline-block;text-decoration:none;color:white!important;font-size:large!important;font-family:"Roboto",sans-serif;text-transform:uppercase;letter-spacing:0.17em;font-weight:500}</style>
