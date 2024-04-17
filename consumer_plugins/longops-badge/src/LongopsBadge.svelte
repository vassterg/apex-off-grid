<svelte:options customElement={{ tag: "p-longops-badge", shadow: "none" }} />

<script>
  import { onMount } from "svelte";

  let visible = false;
  let currTasks = [];

  onMount(() => {
    window.hartenfeller_dev = window.hartenfeller_dev || {};
    window.hartenfeller_dev.plugins = window.hartenfeller_dev.plugins || {};
    window.hartenfeller_dev.plugins.longops_badge =
      window.hartenfeller_dev.plugins.longops_badge || {};
    window.hartenfeller_dev.plugins.longops_badge.status = "loaded";

    window.hartenfeller_dev.plugins.longops_badge.registerTask = (...args) =>
      registerTask(...args);
    window.hartenfeller_dev.plugins.longops_badge.updateTask = (...args) =>
      updateTask(...args);
    window.hartenfeller_dev.plugins.longops_badge.finishTask = (...args) =>
      finishTask(...args);
  });

  function logTrace(...args) {
    if (!window?.apex) {
      return;
    }
    apex.debug.trace("p-longops-badge", ...args);
  }

  function removeOldTasks() {
    // filter tasks that finished 10 seconds ago
    currTasks = currTasks.filter(
      (task) => task.finishedAt < Date.now() - 10000,
    );

    if (currTasks.length === 0) {
      visible = false;
    }
  }

  export function registerTask(displayName) {
    currTasks = [...currTasks, { displayName, progress: "", finishedAt: null }];
    visible = true;
  }

  export function updateTask(displayName, progress) {
    let found = false;

    currTasks = currTasks.map((task) => {
      if (task.displayName === displayName) {
        found = true;
        return { ...task, progress };
      }
      return task;
    });

    if (!found) {
      logTrace(`Task ${displayName} not found`);
      registerTask(displayName);
    }
  }

  export function finishTask(displayName) {
    currTasks = currTasks.map((task) => {
      if (task.displayName === displayName) {
        return { ...task, progress: "Done", finishedAt: Date.now() };
      }
      return task;
    });
    setTimeout(removeOldTasks, 5000);
  }
</script>

{#if visible}
  <div class="p-badge">
    <ul class="">
      {#each currTasks as task}
        <li class="u-flex u-align-items-center">
          {#if task.finishedAt}
            <span
              aria-hidden="true"
              class="fa fa-check margin-right-sm u-success-text"
            ></span>
          {:else}
            <span
              aria-hidden="true"
              class="fa fa-refresh fa-anim-spin margin-right-sm"
            ></span>
          {/if}
          <span>{task.displayName} {task.progress}</span>
        </li>
      {/each}
    </ul>
  </div>
{/if}

<style>
  .p-badge {
    padding: 8px;
    border-radius: 32px;
    border: 1px solid var(--ut-component-border-color);
    box-shadow: var(--ut-shadow-md);
    font-size: 1rem;
    background: var(--ut-component-background-color);

    position: fixed;
    bottom: 2rem;
    right: 2rem;
  }
</style>
