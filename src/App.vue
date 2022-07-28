<template>
  <v-app>
    <v-app-bar app color="primary" dark height="100">
      <div class="d-flex align-center">
        <v-img alt="ALUVAL Logo" class="shrink mr-2" contain width="160" src="@/assets/logoH.png"
          transition="scale-transition" />
      </div>

      <v-spacer></v-spacer>

      <div v-if="!isMobile()">
        <router-link :to="{ name: 'home' }" class="mr-5">
          <v-btn text x-large>
            <span>
              Inicio
            </span>
          </v-btn>
        </router-link>

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

      <div v-else>
        <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      </div>
    </v-app-bar>

    <v-navigation-drawer hide-overlay v-model="drawer" absolute temporary dark color="primary">
      <br>
      <v-row>
        <v-col class="d-flex justify-center">
          <v-img alt="ALUVAL Logo2" class="shrink" contain width="160" src="@/assets/logoV.png"
            transition="scale-transition" />
        </v-col>
      </v-row>
      <br>
      <v-list nav>
        <v-list-item-group v-model="group">
          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-home</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              <router-link class="wtext overline" :to="{ name: 'home' }">
                INICIO
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-currency-usd</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              <router-link class="wtext overline" :to="{ name: 'cotizar' }">
                COTIZAR
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-bag-personal</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              <router-link class="wtext overline" :to="{ name: 'inventario' }">
                INVENTARIO
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-history</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              <router-link class="wtext overline" :to="{ name: 'historial' }">
                HISTORIAL
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>

    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data: () => ({
    drawer: false,
    group: null
  }),

  methods: {
    isMobile() {
      return ((window.innerWidth <= 600) && (window.innerHeight <= 1000))
    }
  },

  created() {
  },
};
</script>

<style lang="scss">
#app {
  background-color: #2575B0;
}

.v-data-table>.v-data-table__wrapper>table>thead>tr>th {
  font-size: 20px !important;
}

.v-data-table>.v-data-table__wrapper>table>tbody>tr>td {
  font-size: 16px !important;
}

.v-toolbar__title {
  font-size: 1.5rem !important;
  font-weight: 500;
  letter-spacing: 0.17em;
  text-transform: uppercase;
  font-family: 'Roboto', sans-serif;

}

.v-toolbar__title.mobile{
  font-size: 1.2em !important;
  font-weight: 500;
  letter-spacing: 0.17em;
  text-transform: uppercase;
  font-family: 'Roboto', sans-serif;
}

.v-data-table>.v-data-table__wrapper>table>tbody>tr>td>.v-data-table__mobile-row__cell{
  word-break: break-all;
  width: 50%;
}

</style>

<style lang="scss" scoped>
.wtext {
  display: inline-block;
  width: 100%;
  text-decoration: none;
  color: white;
  font-size: large !important;
}
</style>