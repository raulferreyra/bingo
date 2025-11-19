<template>
  <div class="min-h-screen flex items-center justify-center bg-slate-950">
    <div class="w-full max-w-[1600px] px-14 py-10">
      <main class="bg-slate-900/95 rounded-3xl shadow-2xl px-14 py-10 relative">

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
              <div v-for="cell in (board[col.key] || [])" :key="cell.number" :class="[
                'bingo-cell',
                {
                  'bingo-cell--marked': cell.marked,
                  'bingo-cell--active': cell.number === currentHighlightNumber
                }
              ]">
                {{ cell.number }}
              </div>
            </div>
          </div>
        </div>

        <div class="mt-14 flex justify-center gap-6">
          <button type="button" class="btn-next" :disabled="isSpinning || availableNumbers.length === 0"
            @click="handleNext">
            Siguiente
          </button>

          <button type="button" class="btn-reset" :disabled="isSpinning" @click="handleReset">
            Resetear
          </button>
        </div>

        <div v-if="showModal" class="modal-backdrop">
          <div class="modal-content">
            <div class="modal-letter">
              {{ getLetter(modalNumber) }}
            </div>
            <div class="modal-number">
              {{ modalNumber }}
            </div>
          </div>
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
const availableNumbers = ref([])
const currentHighlightNumber = ref(null)
const isSpinning = ref(false)
const showModal = ref(false)
const modalNumber = ref(null)

function buildShuffledNumbers() {
  const arr = Array.from({ length: 75 }, (_, i) => i + 1)
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
      ;[arr[i], arr[j]] = [arr[j], arr[i]]
  }
  return arr
}

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
  availableNumbers.value = buildShuffledNumbers()
  currentHighlightNumber.value = null
  showModal.value = false
  modalNumber.value = null
}

function markNumberOnBoard(num) {
  for (const col of columns) {
    const cells = board.value[col.key]
    const cell = cells.find(c => c.number === num)
    if (cell) {
      cell.marked = true
      return
    }
  }
}

function getLetter(num) {
  if (num >= 1 && num <= 15) return 'B'
  if (num >= 16 && num <= 30) return 'I'
  if (num >= 31 && num <= 45) return 'N'
  if (num >= 46 && num <= 60) return 'G'
  return 'O'
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

async function handleNext() {
  if (isSpinning.value || availableNumbers.value.length === 0) return

  isSpinning.value = true

  const pool = [...availableNumbers.value]
  const target = pool[0]

  // Faster base loops (3 full passes)
  const baseDelays = [8, 15, 20]

  for (const delay of baseDelays) {
    for (const num of pool) {
      currentHighlightNumber.value = num
      await sleep(delay)
    }
  }

  let cursorIndex = pool.indexOf(currentHighlightNumber.value)
  if (cursorIndex === -1) cursorIndex = 0

  const finalSequence = []
  const extraCycles = 2

  for (let i = 0; i < extraCycles; i++) {
    cursorIndex = (cursorIndex + 1) % pool.length
    finalSequence.push(pool[cursorIndex])
  }

  while (pool[cursorIndex] !== target) {
    cursorIndex = (cursorIndex + 1) % pool.length
    finalSequence.push(pool[cursorIndex])
  }

  // Faster but still decelerating at the end
  let stepDelay = 120
  const stepIncrement = 10

  for (const num of finalSequence) {
    currentHighlightNumber.value = num
    await sleep(stepDelay)
    stepDelay += stepIncrement
  }

  currentHighlightNumber.value = target
  modalNumber.value = target
  showModal.value = true

  markNumberOnBoard(target)

  availableNumbers.value = availableNumbers.value.slice(1)

  await sleep(6000)
  showModal.value = false
  isSpinning.value = false
}

function handleReset() {
  if (isSpinning.value) return
  initBoard()
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
  transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
}

.bingo-cell--active {
  background: #0f766e;
  box-shadow: 0 0 20px rgba(45, 212, 191, 0.8);
  transform: scale(1.1);
  color: #0f172a;
  border-color: #14b8a6;
}

.bingo-cell--marked {
  background: #22c55e;
  color: #022c22;
  border-color: #16a34a;
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

.btn-next:disabled {
  opacity: 0.35;
}

.btn-reset {
  border: 2px solid #f87171;
  color: #f87171;
  background: transparent;
}

.btn-reset:disabled {
  opacity: 0.35;
}

.modal-backdrop {
  position: absolute;
  inset: 0;
  background: rgba(15, 23, 42, 0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 20;
}

.modal-content {
  background: radial-gradient(circle at center, #0f766e 0%, #020617 95%);
  border-radius: 32px;
  padding: 40px 80px;
  box-shadow: 0 0 60px rgba(45, 212, 191, 0.9);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.modal-letter {
  font-size: 3rem;
  font-weight: 900;
  letter-spacing: 0.3em;
  color: #e0f2fe;
}

.modal-number {
  font-size: 6rem;
  font-weight: 900;
  color: #f9fafb;
}
</style>
