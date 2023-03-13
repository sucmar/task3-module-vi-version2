<template>
  <CourseForm @on-payload="addCourse($event)">
  </CourseForm>
  <div class="courseContainer">

    <h3 class="titleCourse">List of Courses</h3>
    <input class="courseSearcher" type="text" id="course_searcher" v-model="searchCourseText"
      placeholder="Search by description..." />
    <select class="selectCourseFilter" id="select-option" v-model="selectedCourseOption">
      <option v-for="option in options" :value="option.value" :key="option.id">{{ option.label }}</option>
    </select>

    <table class="table" title="List of Courses">
      <thead>
        <tr>
          <th>ID</th>
          <th>Course Name</th>
          <th>Description</th>
          <th>Teacher Id</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="course in filteredCoursesItems" :key="course.id" @click="editCourse = course">
          <td>{{ course.id }}</td>

          <td v-if="editCourse !== course">{{ course.course_name }}</td>
          <td v-else><input type="text" v-model="editCourse.course_name"></td>

          <td v-if="editCourse !== course">{{ course.course_description }}</td>
          <td v-else><input type="text" v-model="editCourse.course_description"></td>

          <td v-if="editCourse !== course">{{ course.teacher_id }}</td>
          <td v-else><input type="text" v-model="editCourse.teacher_id"></td>

          <td>
            <button v-if="editCourse === course" @click.stop="onCourseEditCanceled">Cancel</button>
            <button v-else @click.stop="onCourseDeleted(course)">Delete</button>

            <button v-if="editCourse === course" @click.stop="onCourseUpdated(course)">Save</button>
            <button v-else>Edit</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
  
<script>

import CourseForm from '@/components/CourseForm.vue';

export default {
  name: 'CourseList',
  components: {
    CourseForm,
  },
  data() {
    return {
      courses: [],
      payload: {
        course_name: '',
        course_description: '',
        teacher_id: '',
      },
      editCourse: null,
      searchCourseText: '',
      selectedCourseOption: '',
      options: [
        { id: 1, label: '*** Filter by Course ***', value: '' },
        { id: 2, label: 'Course A', value: 'A' },
        { id: 3, label: 'Course B', value: 'B' },
        { id: 4, label: 'Course C', value: 'C' }
      ]
    }
  },
  methods: {
    async getCourses() {
      try {
        const response = await this.axios.get('http://localhost:3000/courses');
        this.courses = response.data;
      } catch (error) {
        console.log(error);
      }
    },
    async addCourse(course) {
      try {
        const response = await this.axios.post('http://localhost:3000/courses', course)
        this.courses.push(response.data);
      } catch (error) {
        console.log(error);
      }
    },
    async onCourseDeleted(course) {
      const id = course.id
      try {
        this.axios.delete(`http://localhost:3000/courses/${id}`)
        this.courses = this.courses.filter(course => course.id !== id)
      } catch (error) {
        console.log(error)
      }
    },
    async onCourseUpdated(course) {
      try {
        const response = await this.axios.put(`http://localhost:3000/courses/${course.id}`, course)
        const index = this.courses.findIndex(u => u.id === course.id)
        this.courses.splice(index, 1, response.data)
      } catch (error) {
        console.log(error)
      }
    },
    onCourseEditCanceled() {
      this.editCourse = null;
    },
  },
  computed: {
    filteredCoursesItems() {
      if (this.searchCourseText === '' && this.selectedCourseOption === '') {
        return this.courses;
      } else if (this.selectedCourseOption !== '') {
        return this.courses.filter(course => {
          return course.course_name.toLowerCase().includes(this.selectedCourseOption.toLowerCase())
        })
      } else {
        return this.courses.filter(course => {
          return course.course_description.toLowerCase().includes(this.searchCourseText.toLowerCase())
        })
      }
    }
  },
  mounted() {
    this.getCourses();
  }
}
</script>

<style>
.courseContainer {
  margin: auto;
  width: 80%;
}

.courseSearcher {
  width: 40%;
  margin: 0px 0px 5px 0px;
}

.titleCourse {
  margin: 50px 0px 5px 0px;
}

.selectCourseFilter {
  margin: 2px 5px 2px 5px;
  padding: 8px;
  border: 2px solid #ccc;
  border-radius: 5px;
  color: #555;
  background-color: #fff;
  box-shadow: none;
  outline: none;
  transition: border-color 0.2s ease-in-out;
}

.selectCourseFilter:focus {
  border-color: #4db6ac;
}
</style>
  