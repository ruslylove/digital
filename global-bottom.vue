<!-- global-bottom.vue -->
<template>
    <footer class="absolute bottom-0 right-0 p-2 opacity-40">
      {{ $slidev.configs.subject }} {{ $slidev.configs.semester }} - Page {{$page}} / {{ $nav.total }} 
    
    </footer>
    <footer class="absolute bottom-0 left-0 p-2 opacity-40">
      <Toc mode="onlyCurrentTree" maxDepth="1" columns="1"/> 
    </footer>
      
  </template>