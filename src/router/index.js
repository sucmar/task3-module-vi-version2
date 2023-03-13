import { createRouter, createWebHistory } from 'vue-router'

import HomeView from '../views/HomeView.vue'
import TeacherList from '../views/TeacherList.vue'
import CourseList from '../views/CourseList.vue'

const routes = [
    {
        path: '/',
        name: 'home',
        component: HomeView
    },
    {
        path: '/teachers',
        name: 'teachers',
        component: TeacherList
    },
    {
        path: '/courses',
        name: 'courses',
        component: CourseList
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
