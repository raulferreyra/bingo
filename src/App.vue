<template>
  <div class="min-h-screen flex items-center justify-center px-4 bg-slate-950">
    <div class="w-full max-w-5xl mx-auto">
      <main class="bg-slate-900/80 rounded-2xl shadow-2xl p-4 sm:p-6">
        <!-- Cabecera B I N G O -->
        <div class="overflow-x-auto">
          <table class="w-full text-center border-separate border-spacing-1">
            <thead>
              <tr class="text-lg sm:text-xl font-bold text-slate-50">
                <th
                  v-for="col in columns"
                  :key="col.key"
                  class="py-2 px-2 sm:px-4 bg-slate-800 rounded-lg tracking-[0.3em]"
                >
                  {{ col.key }}
                </th>
              </tr>
            </thead>

            <tbody>
              <!-- 15 filas x 5 columnas = 75 números -->
              <tr
                v-for="(row, rowIndex) in boardRows"
                :key="`row-${rowIndex}`"
              >
                <td
                  v-for="cell in row"
                  :key="cell.number"
                >
                  <div
                    class="h-10 sm:h-12 w-10 sm:w-12 flex items-center justify-center
                           bg-slate-800/80 rounded-xl border border-slate-700
                           text-sm sm:text-base font-semibold text-slate-100"
                  >
                    {{ cell.number }}
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Controles (aún sin lógica) -->
        <div class="mt-6 flex flex-col sm:flex-row gap-3 justify-center">
          <button
            type="button"
            class="px-6 py-2 rounded-full font-semibold
                   bg-emerald-500/80 hover:bg-emerald-400
                   text-slate-900 transition disabled:opacity-40"
            disabled
          >
            Siguiente
          </button>

          <button
            type="button"
            class="px-6 py-2 rounded-full font-semibold border
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

// Definimos las columnas con sus rangos
const columns = [
  { key: 'B', start: 1, end: 15 },
  { key: 'I', start: 16, end: 30 },
  { key: 'N', start: 31, end: 45 },
  { key: 'G', start: 46, end: 60 },
  { key: 'O', start: 61, end: 75 }
]

// boardRows será un array de 15 filas, cada fila con 5 celdas { number, marked }
const boardRows = ref([])

/**
 * Genera el tablero de 15 filas x 5 columnas con números 1–75
 * organizados por rangos B I N G O.
 */
function initBoard() {
  const rows = []

  // 15 filas
  for (let i = 0; i < 15; i++) {
    const row = []

    // Para cada columna, calculamos el número correspondiente
    for (const col of columns) {
      const number = col.start + i // 1..15, 16..30, etc
      row.push({
        number,
        marked: false
      })
    }

    rows.push(row)
  }

  boardRows.value = rows
}

onMounted(() => {
  initBoard()
})
</script>
