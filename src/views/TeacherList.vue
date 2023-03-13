<template>
  <TeacherForm @on-payload="addTeacher($event)">
  </TeacherForm>
  <div class="teacherContainer">

    <h3 class="titleCourse">List of Teachers</h3>
    <input class="teacherSearcher" type="text" id="teacher_searcher" v-model="searchTeacherText"
      placeholder="Search by Teacher Name..." />
    <select class="selectTeacherFilter" id="select-option" v-model="selectedTeacherOption">
      <option v-for="option in options" :value="option.value" :key="option.id">{{ option.label }}</option>
    </select>

    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Teacher Name</th>
          <th>Teacher Email</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="teacher in filteredTeachersItems" :key="teacher.id" @click="editTeacher = teacher">
          <td>{{ teacher.id }}</td>

          <td v-if="editTeacher !== teacher">{{ teacher.teacher_name }}</td>
          <td v-else><input type="text" v-model="editTeacher.teacher_name"></td>

          <td v-if="editTeacher !== teacher">{{ teacher.teacher_email }}</td>
          <td v-else><input type="text" v-model="editTeacher.teacher_email"></td>

          <td>
            <button v-if="editTeacher === teacher" @click.stop="onTeacherEditCanceled()">Cancel</button>
            <button v-else @click.stop="onTeacherDeleted(teacher)">Delete</button>

            <button v-if="editTeacher === teacher" @click.stop="onTeacherUpdated(teacher)">Save</button>
            <button v-else>Edit</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
  
<script>

import TeacherForm from '@/components/TeacherForm.vue';

export default {
  name: 'TeacherList',
  components: {
    TeacherForm,
  },
  data() {
    return {
      teachers: [],
      payload: {
        teacher_name: '',
        teacher_email: '',
      },
      editTeacher: null,
      searchTeacherText: '',
      selectedTeacherOption: '',
      options: [
        { id: 1, label: '*** Filter by Email ***', value: '' },
        { id: 2, label: 'gmail', value: 'gmail' },
        { id: 3, label: 'hotmail', value: 'hotmail' },
      ]
    }
  },
  methods: {
    async getTeachers() {
      try {
        const response = await this.axios.get('http://localhost:3000/teachers');
        this.teachers = response.data;
      } catch (error) {
        console.log(error);
      }
    },
    async addTeacher(teacher) {
      try {
        const response = await this.axios.post('http://localhost:3000/teachers', teacher);
        this.teachers.push(response.data);
      } catch (error) {
        console.log(error);
      }
    },
    async onTeacherDeleted(teacher) {
      const id = teacher.id
      try {
        this.axios.delete(`http://localhost:3000/teachers/${id}`)
        this.teachers = this.teachers.filter(teacher => teacher.id !== id)
      } catch (error) {
        console.log(error)
      }
    },
    async onTeacherUpdated(teacher) {
      try {
        const response = await this.axios.put(`http://localhost:3000/teachers/${teacher.id}`, teacher)
        const index = this.teachers.findIndex(u => u.id === teacher.id)
        this.teachers.splice(index, 1, response.data)
      } catch (error) {
        console.log(error)
      }
    },
    onTeacherEditCanceled() {
      this.editTeacher = null;
    },
  },
  computed: {
    filteredTeachersItems() {
      if (this.searchTeacherText === '' && this.selectedTeacherOption === '') {
        return this.teachers;
      } else if (this.selectedTeacherOption !== '') {
        return this.teachers.filter(course => {
          return course.teacher_email.toLowerCase().includes(this.selectedTeacherOption.toLowerCase())
        })
      } else {
        return this.teachers.filter(course => {
          return course.teacher_name.toLowerCase().includes(this.searchTeacherText.toLowerCase())
        })
      }
    }
  },
  mounted() {
    this.getTeachers();
  }
}
</script>

<style>
.teacherContainer {
  margin: auto;
  width: 80%;
}

.teacherSearcher {
  width: 40%;
  margin: 0px 0px 5px 0px;
}

.titleTeacher {
  margin: 50px 0px 5px 0px;
}

.selectTeacherFilter {
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

.selectTeacherFilter:focus {
  border-color: #4db6ac;
}
</style>
