<svelte:options customElement={{ tag: "p-longops-badge", shadow: "none" }} />

<script>
  import { onMount } from "svelte";

  const HIDE_AFTER = 5000;

  let visible = false;
  /**
   * @type {{displayName: string, progress: string, icon: string, hideAt: number}[]}
   */
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
    window.hartenfeller_dev.plugins.longops_badge.showInfo = (...args) =>
      showInfo(...args);
  });

  function getHideAt() {
    return Date.now() + HIDE_AFTER - 100;
  }

  function logTrace(...args) {
    if (!window?.apex) {
      return;
    }
    apex.debug.trace("p-longops-badge", ...args);
  }

  function removeOldTasks() {
    // filter tasks that finished 10 seconds ago
    currTasks = currTasks.filter((task) => task.hideAt > Date.now());

    if (currTasks.length === 0) {
      visible = false;
    }
  }

  function deferRemoveOldTasks() {
    setTimeout(removeOldTasks, HIDE_AFTER);
  }

  export function registerTask(displayName) {
    currTasks = [
      ...currTasks,
      {
        displayName,
        progress: "",
        finishedAt: null,
        icon: "fa-refresh fa-anim-spin",
      },
    ];
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
        return {
          ...task,
          progress: "Done",
          hideAt: getHideAt(),
          icon: "fa-check u-success-text",
        };
      }
      return task;
    });
    deferRemoveOldTasks();
  }

  export function showInfo(info) {
    currTasks = [
      ...currTasks,
      {
        displayName: info,
        progress: "",
        hideAt: getHideAt(),
        icon: "fa-info-circle-o u-info-text",
      },
    ];
    visible = true;
    deferRemoveOldTasks();
  }
</script>

{#if visible}
  <div class="p-badge">
    <ul class="">
      {#each currTasks as task}
        <li class="u-flex u-align-items-center">
          <span aria-hidden="true" class={`fa margin-right-sm ${task.icon}`}
          ></span>
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
