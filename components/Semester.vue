<!--
  Shows the current semester as "<semester>/<year>" and updates itself:
    Jul - Oct  ->  1/<this year>      (1st semester starts in July)
    Nov - Dec  ->  2/<this year>      (2nd semester starts in November)
    Jan - Jun  ->  2/<last year>      (2nd semester runs into the new year; summer is counted with it)
  To pin a fixed value, set  semester: 2/2025  in the headmatter of slides.md
  (the default is  semester: auto ).
-->
<script setup>
function currentSemester(d = new Date()) {
  const month = d.getMonth() + 1
  const year = d.getFullYear()
  if (month >= 11) return `2/${year}`
  if (month >= 7) return `1/${year}`
  return `2/${year - 1}`
}

function semesterLabel(cfg) {
  const v = String(cfg ?? 'auto').trim()
  return v && v.toLowerCase() !== 'auto' ? v : currentSemester()
}
</script>

<template>{{ semesterLabel($slidev.configs.semester) }}</template>
