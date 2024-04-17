export function onAPEXready(cb) {
  window.addEventListener("apexready", () => {
    cb();
  });
}
