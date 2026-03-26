import { createRouter, createWebHistory } from 'vue-router'
import { useAuth } from "@/stores/auth.js"

const isNumeric = (value) => /^\d+$/.test(value)

const PublicLayout = () => import('@/layouts/PublicLayout.vue')
const AuthLayout = () => import('@/layouts/AuthLayout.vue')
const AdminLayout = () => import('@/layouts/AdminLayout.vue')

const routes = [

    {
        path: '/',
        component: PublicLayout,
        children: [
            {
                path: '',
                name: 'home',
                component: () => import('@/views/HomeView.vue'),
                meta: { title: 'Kezdőlap' }
            },
            {
                path: 'termekek',
                children: [
                    {
                        path: '',
                        name: 'products',
                        component: () => import('@/views/ProductsView.vue'),
                        meta: { title: 'Termékek' }
                    },
                    {
                        path: ':id',
                        name: 'product-details',
                        component: () => import('@/views/ProductDetailView.vue'),
                        meta: { title: 'Termék Adatlap' },
                        beforeEnter: (to) => {
                            if (!isNumeric(to.params.id)) return { name: 'not-found' }
                            return true
                        }
                    }
                ]
            },
            {
                path: 'kosar',
                name: 'cart',
                component: () => import('@/views/CartView.vue'),
                meta: { title: 'Kosár' }
            }
        ]
    },



    {
        path: '/auth',
        component: AuthLayout,
        children: [
            {
                path: 'login',
                name: 'login',
                component: () => import('@/views/auth/LoginView.vue'),
                meta: { title: 'Bejelentkezés' }
            },
            {
                path: 'register',
                name: 'register',
                component: () => import('@/views/auth/RegisterView.vue'),
                meta: { title: 'Regisztráció' }
            }
        ]
    },


    {
        path: '/admin',
        component: AdminLayout,
        meta: { requiresAuth: true, roles: ['admin'] },
        children: [
            {
                path: '',
                redirect: { name: 'admin-dashboard' },
            },
            {
                path: 'vezerlopult',
                name: 'admin-dashboard',
                component: () => import('@/views/admin/DashboardView.vue'),
                meta: { title: 'Vezérlőpult', requiresAuth: true, roles: ['admin'] }
            }
        ]
    },


    {
        path: '/403',
        name: 'not-authorized',
        component: () => import('@/views/errors/NotAuthorizedView.vue'),
        meta: { title: 'Nincs Jogosultság' }
    },
    {
        path: '/:pathMatch(.*)*',
        name: 'not-found',
        component: () => import('@/views/errors/NotFoundView.vue'),
        meta: { title: 'A keresett oldal nem található' }
    }
]

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) return savedPosition
        if (to.hash) return { el: to.hash, behavior: 'smooth' }
        return { top: 0 }
    }
})

router.beforeEach((to) => {
    const { isAuthenticated, user } = useAuth()

    document.title = to.meta?.title ? `${to.meta.title} - Kézműves Webshop` : 'Kézműves Webshop'

    if (to.name === 'login' && isAuthenticated) {
        return { name: 'home' }
    }

    if (to.meta?.requiresAuth && !isAuthenticated) {
        return { name: 'login', query: { redirect: to.fullPath } }
    }

    const roles = to.meta?.roles
    if (roles?.length) {
        const role = user?.role // A felhasználó role-ja (admin vagy customer)
        if (!role || !roles.includes(role)) return { name: 'not-authorized' }
    }

    return true
})

export default router