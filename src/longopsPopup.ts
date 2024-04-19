export default function initLongopsPopup() {
	const flowForm = document.querySelector("#wwvFlowForm");
	const form = flowForm ?? document.querySelector("body");
	const el = document.createElement("p-longops-badge");
	form.appendChild(el);
	window.apex.debug.trace("Longops popup initialized");
}

export function registerLongops(taskId: string) {
	window.hartenfeller_dev.plugins.longops_badge.registerTask(taskId);
}

export function updateLongops(taskId: string, progress: string | number) {
	window.hartenfeller_dev.plugins.longops_badge.updateTask(taskId, progress);
}

export function finishLongops(taskId: string) {
	window.hartenfeller_dev.plugins.longops_badge.finishTask(taskId);
}

export function longopsInfo(message: string) {
	window.hartenfeller_dev.plugins.longops_badge.showInfo(message);
}
