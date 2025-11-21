<script setup>
import { computed } from 'vue'
import { useSlidevContext, useNav } from '@slidev/client'

const { $slidev } = useSlidevContext()
const { currentPage } = useNav()

const sourceFileName = computed(() => {
  // Get the TOC array, which includes all src: file entries
  const tocEntries = $slidev.nav.tocTree
  
  // Iterate backward to find the *most recent* starting point
  // whose page number is <= the current page number.
  for (let i = tocEntries.length - 1; i >= 0; i--) {
    const entry = tocEntries[i]

    // If the entry's starting page number (.no) is less than or equal to 
    // the current page, this entry (which is the start of a source group)
    // must be the source file we are currently in.
    if (entry.no <= $slidev.nav.currentPage) {
      // The entry.title for a src: file is the filename (e.g., 'lecture_1.md').
      // For a non-src entry (e.g., the main title slide), it's the slide title.
      // We will assume that only src: files have the '.' in their title.
      
      // We will return the title of the entry we found.
      // If the title doesn't contain a '.', we assume it's the main presentation title.
      if (entry.title.includes('.')) {
        return entry.title
      } else {
        // Fallback to the overall presentation title if the matched entry 
        // doesn't look like a filename (i.e., we are in the main slides.md file)
        return $slidev.configs.title
      }
    }
  }

  // Fallback if no entry is found (shouldn't happen)
  return 'Unknown Source'
})
</script>

<template>
  <span class="font-bold text-gray-700 dark:text-gray-300">
    {{ sourceFileName }}
  </span>
</template>