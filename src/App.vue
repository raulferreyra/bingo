<template>
  <div class="min-h-screen flex items-center justify-center bg-slate-950">
    <div class="w-full max-w-6xl px-10 py-8">
      <main class="bg-slate-900/90 rounded-3xl shadow-2xl px-10 py-8">
        <!-- Cabecera B I N G O -->
        <div class="flex justify-between mb-6">
          <div
            v-for="col in columns"
            :key="col.key"
            class="flex flex-col items-center flex-1"
          >
            <div
              class="text-2xl font-extrabold tracking-[0.35em]
                     bg-slate-800 text-slate-50 rounded-xl px-4 py-2
                     w-20 text-center"
            >
              {{ col.key }}
            </div>
          </div>
        </div>

        <!-- Tablero en columnas, cada una con grilla 3x5 -->
        <div class="flex justify-between gap-8">
          <div
            v-for="col in columns"
            :key="col.key + '-grid'"
            class="flex-1 flex flex-col items-center"
          >
            <div
              class="grid grid-cols-3 gap-3 mt-3"
            >
              <div
                v-for="cell in (board[col.key] || [])"
                :key="cell.number"
                class="h-12 w-12 flex items-center justify-center
                       rounded-xl border border-slate-700
                       bg-slate-800/80 text-slate-100
                       text-base font-semibold"
              >
                {{ cell.number }}
              </div>
            </div>
          </div>
        </div>

        <div class="mt-10 flex justify-center gap-6">
          <button
            type="button"
            class="px-8 py-2 rounded-full font-semibold
                   bg-emerald-500/80 hover:bg-emerald-400
                   text-slate-900 transition disabled:opacity-40"
            disabled
          >
            Siguiente
          </button>

          <button
            type="button"
            class="px-8 py-2 rounded-full font-semibold border
                   border-red-400 text-red-300 hover:bg-red-500/10
                   transition disabled:opacity-40"
            disabled
          >
            Resetear
          </button>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const columns = [
  { key: 'B', start: 1, end: 15 },
  { key: 'I', start: 16, end: 30 },
  { key: 'N', start: 31, end: 45 },
  { key: 'G', start: 46, end: 60 },
  { key: 'O', start: 61, end: 75 }
]

// board será { B: [{number, marked}], I: [...], ... }
const board = ref({})

function initBoard () {
  const data = {}

  for (const col of columns) {
    const cells = []
    for (let n = col.start; n <= col.end; n++) {
      cells.push({
        number: n,
        marked: false
      })
    }
    data[col.key] = cells
  }

  board.value = data
}

onMounted(() => {
  initBoard()
})
</script>
