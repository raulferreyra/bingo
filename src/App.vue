<template>
  <div class="min-h-screen flex items-center justify-center bg-slate-950">
    <div class="w-full max-w-[1600px] px-14 py-10">

      <main class="bg-slate-900/95 rounded-3xl shadow-2xl px-14 py-10">

        <div class="flex justify-between mb-10">
          <div v-for="col in columns" :key="col.key" class="flex flex-col items-center flex-1">
            <div class="bingo-header">
              {{ col.key }}
            </div>
          </div>
        </div>

        <div class="flex justify-between gap-12">
          <div v-for="col in columns" :key="col.key + '-grid'" class="flex-1 flex flex-col items-center">
            <div class="grid grid-cols-3 gap-5">
              <div v-for="cell in (board[col.key] || [])" :key="cell.number" class="bingo-cell">
                {{ cell.number }}
              </div>
            </div>
          </div>
        </div>

        <div class="mt-14 flex justify-center gap-6">
          <button class="btn-next" disabled>
            Siguiente
          </button>

          <button class="btn-reset" disabled>
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

const board = ref({})

function initBoard() {
  const data = {}

  for (const col of columns) {
    const cells = []
    for (let n = col.start; n <= col.end; n++) {
      cells.push({ number: n, marked: false })
    }
    data[col.key] = cells
  }

  board.value = data
}

onMounted(() => {
  initBoard()
})
</script>

<style scoped>
.bingo-header {
  font-size: 2.8rem;
  font-weight: 900;
  letter-spacing: 0.35em;
  background: #1e293b;
  color: #f1f5f9;
  padding: 18px 30px;
  border-radius: 18px;
  text-align: center;
  min-width: 130px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
}

.range-label {
  margin-top: 6px;
  font-size: 1rem;
  color: #94a3b8;
  font-weight: 500;
}

.bingo-cell {
  height: 1.85em;
  width: 1.85em;
  border-radius: 16px;
  background: #1e293b;
  border: 2px solid #334155;
  color: #e2e8f0;
  font-size: 1.85rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: 0.2s ease;
}

.bingo-cell:hover {
  background: #334155;
  transform: scale(1.05);
}

.btn-next,
.btn-reset {
  padding: 16px 38px;
  font-size: 1.4rem;
  font-weight: 700;
  border-radius: 999px;
  transition: 0.2s ease;
}

.btn-next {
  background: #10b981;
  color: #0f172a;
}

.btn-reset {
  border: 2px solid #f87171;
  color: #f87171;
}

.btn-next:disabled,
.btn-reset:disabled {
  opacity: 0.3;
}
</style>
