<template>
  <v-container fluid style="height: 100%;">
    <v-card height="100%">
      <v-toolbar flat color="primary" dark>
        <v-spacer></v-spacer>
        <div v-if="!isMobile()">
          <v-toolbar-title>
            PROYECTOS PENDIENTES
          </v-toolbar-title>
        </div>
        <div v-else>
          <v-toolbar-title class="mobile">
            PROYECTOS PENDIENTES
          </v-toolbar-title>
        </div>
        <v-spacer></v-spacer>
      </v-toolbar>
      <v-card-text>

      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: "Home",
  data() {
    return {
    }
  },

  methods: {
    isMobile() {
      const val = window.innerWidth <= 600 && window.innerHeight <= 1000
      return val
    }
  },

  created() {

  },
}
</script>

