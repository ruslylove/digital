---
# You can also start simply with 'default'
theme: seriph
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: https://cover.sli.dev
# some information about your slides (markdown enabled)
title: Welcome to 010113025 Digital Circuit & Logic Design
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# apply unocss classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
# open graph
# seoMeta:
#  ogImage: https://cover.sli.dev
# lineNumbers: true
favicon: '/img/favicon_c_new.png'

presenter: Dr. Ruslee Sutthaweekul
semester: 2/2025
subject: 010113025 Digital Circuit & Logic Design

# Digital Circuit and Logic Design
---
# {{ $slidev.configs.subject }}

Presented by {{ $slidev.configs.presenter }}

Semester {{ $slidev.configs.semester }}

<div @click="$slidev.nav.next" class="mt-12 py-1" hover:bg="white op-10">
  Press Space for next page <carbon:arrow-right />
</div>

<div class="abs-br m-6 text-xl">
  <button @click="$slidev.nav.openInEditor()" title="Open in Editor" class="slidev-icon-btn">
    <carbon:edit />
  </button>
  <a href="https://github.com/ruslylove/compro" target="_blank" class="slidev-icon-btn">
    <carbon:logo-github />
  </a>
</div>
---
hideInToc: true
---

# Contents
<Toc maxDepth='1' columns='2'/>
---
src: chapter_1.md
---