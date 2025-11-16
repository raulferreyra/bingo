<template>
  <div class="min-h-screen flex items-center justify-center px-4">
    <div class="w-full max-w-5xl mx-auto">
      <header class="text-center mb-6">
        <h1 class="text-3xl font-extrabold tracking-[0.3em] mb-2">
          B I N G O
        </h1>
      </header>

      <main class="bg-slate-800/70 rounded-2xl shadow-xl p-4 sm:p-6">
        <!-- Principal Board -->
        <div class="overflow-x-auto">
          <table class="w-full text-center border-separate border-spacing-1">
            <thead>
              <tr class="text-lg sm:text-xl font-bold">
                <th class="py-2 px-2 sm:px-4 bg-slate-700 rounded-lg">B</th>
                <th class="py-2 px-2 sm:px-4 bg-slate-700 rounded-lg">I</th>
                <th class="py-2 px-2 sm:px-4 bg-slate-700 rounded-lg">N</th>
                <th class="py-2 px-2 sm:px-4 bg-slate-700 rounded-lg">G</th>
                <th class="py-2 px-2 sm:px-4 bg-slate-700 rounded-lg">O</th>
              </tr>
              <tr class="text-xs sm:text-sm text-slate-300">
                <th class="pb-2">
                  1 – 15
                </th>
                <th class="pb-2">
                  16 – 30
                </th>
                <th class="pb-2">
                  31 – 45
                </th>
                <th class="pb-2">
                  46 – 60
                </th>
                <th class="pb-2">
                  61 – 75
                </th>
              </tr>
            </thead>
            <tbody>
              <!-- Next steps the grids -->
              <tr v-for="row in 5" :key="row">
                <td v-for="col in 5" :key="col">
                  <div class="h-12 sm:h-14 w-12 sm:w-14 flex items-center justify-center
                           bg-slate-700/60 rounded-xl border border-slate-600
                           text-lg sm:text-xl font-semibold">
                    <!-- Placeholder, later is full with content -->
                    -
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Controles -->
        <div class="mt-6 flex flex-col sm:flex-row gap-3 justify-center">
          <button type="button" class="px-6 py-2 rounded-full font-semibold
                   bg-emerald-500 hover:bg-emerald-400
                   text-slate-900 transition">
            Siguiente
          </button>
          <button type="button" class="px-6 py-2 rounded-full font-semibold border
                   border-red-400 text-red-300 hover:bg-red-500/10
                   transition">
            Resetear
          </button>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
// Without logic, only template and styles for now
</script>
