<template>
  <form @submit.prevent="onCourseAdded()">
    <input type="text" id="course_name" v-model="payload.course_name" placeholder="Course Name" />
    <input type="text" id="course_description" v-model="payload.course_description" placeholder="Course Description" />
    <input type="text" id="teacher_id" v-model="payload.teacher_id" placeholder="Teacher Id" />
    <button type="submit">Add Teacher</button>
  </form>
</template>
  
<script>

export default {
  name: 'CourseForm',
  props: ["inpayload"],
  emits: ["on-payload"],
  data() {
    return {
      payload: {
        course_name: '',
        course_description: '',
        teacher_id: '',
      }
    };
  },
  methods: {
    onCourseAdded() {
      this.$emit('on-payload', this.payload);
      this.payload = {};
    },
  },
};
</script>
