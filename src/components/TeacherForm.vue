<template>
  <form @submit.prevent="onTeacherAdded()">
    <input type="text" id="teacher_name" v-model="payload.teacher_name" placeholder="Teacher Name" />
    <input type="text" id="teacher_email" v-model="payload.teacher_email" placeholder="Teacher Email" />
    <button type="submit">Save Teacher</button>
  </form>
</template>
  
<script>
export default {
  name: 'TeacherForm',
  props: ["inpayload"],
  emits: ["on-payload"],
  data() {
    return {
      payload: {
        teacher_name: '',
        teacher_email: '',
      }
    };
  },
  methods: {
    onTeacherAdded() {
      this.$emit('on-payload', this.payload);
      this.payload = {}
    },
  },
};
</script>
