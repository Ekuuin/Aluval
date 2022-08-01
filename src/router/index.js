import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '@/views/Inicio.vue'
import Cotizar from '@/views/Cotizar.vue'
import Inventario from '@/views/Inventario.vue'
import Historial from '@/views/Historial.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/Cotizar',
    name: 'cotizar',
    component: Cotizar
  },
  {
    path: '/Historial',
    name: 'historial',
    component: Historial
  },
  {
    path: '/Inventario',
    name: 'inventario',
    component: Inventario
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
