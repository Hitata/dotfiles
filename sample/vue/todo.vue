<script>
export default {
  data() {
    return {
      show: true,
      list: [1, 2, 3]
    }
  }
}
</script>

<template>
  <button @click="show = !show">Toggle List</button>
  <button @click="list.push(list.length + 1)">Push Number</button>
  <button @click="list.pop()">Pop Number</button>
  <button @click="list.reverse()">Reverse List</button>
  <div class="trung">trung</div>

  <ul v-if="show && list.length">
    <li v-for="item of list">{{ item }}</li>
  </ul>
  <p v-else-if="list.length">List is not empty, but hidden.</p>
  <p v-else>List is empty.</p>
</template>
