<template>
  <nav>
    | <router-link to="/">Home</router-link> |
    <router-link to="/teachers">Teachers</router-link> |
    <router-link to="/courses">Courses</router-link> |
  </nav>
  <router-view />
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
}

a {
  font-weight: bold;
  color: #2c3e50;
}

button {
  margin: 0px 5px 0px 5px;
  display: inline-block;
  padding: 5px 10px;
  font-size: 15px;
  color: #fff;
  text-decoration: none;
  text-align: center;
  background: linear-gradient(to bottom, #4db6ac, #26a69a);
  border-radius: 5px;
  border: none;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
  cursor: pointer;
}

button:hover {
  background: linear-gradient(to bottom, #26a69a, #4db6ac);
}

input {
  margin: 2px 5px 2px 5px;
  padding: 6px;
  border: 2px solid #ccc;
  border-radius: 5px;
  color: #555;
  background-color: #fff;
  box-shadow: none;
  outline: none;
  transition: border-color 0.2s ease-in-out;
}

input:focus {
  border-color: #4db6ac;
}
</style>