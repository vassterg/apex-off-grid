<script>
	import { onMount } from "svelte";
	import LongopsBadge from "./LongopsBadge.svelte";
	import APEXenv from "./localAPEX/APEXenv.svelte";
	import { onAPEXready } from "./localAPEX/index.js";

	let apexLoaded = false;

	onAPEXready(() => {
		apexLoaded = true;
		console.log("Mounting LongopsBadge");
	});

	async function watiMs(ms) {
		return new Promise((resolve) => {
			setTimeout(resolve, ms);
		});
	}

	async function task1() {
		await watiMs(1500);
		window.hartenfeller_dev.plugins.longops_badge.registerTask(
			"Update storage",
		);

		for (let i = 0; i <= 30; i++) {
			await watiMs(150);
			window.hartenfeller_dev.plugins.longops_badge.updateTask(
				"Update storage",
				` ${i}/30`,
			);
		}

		window.hartenfeller_dev.plugins.longops_badge.finishTask("Update storage");
	}

	async function task2() {
		await watiMs(5000);
		window.hartenfeller_dev.plugins.longops_badge.registerTask("Xyz");

		for (let i = 0; i <= 5; i++) {
			await watiMs(1000);
			window.hartenfeller_dev.plugins.longops_badge.updateTask("Xyz", `${i}`);
		}

		window.hartenfeller_dev.plugins.longops_badge.finishTask("Xyz");
	}

	onMount(async () => {
		task1();
		task2();
	});

	function showInfo() {
		window.hartenfeller_dev.plugins.longops_badge.showInfo(
			`Time: ${new Date().getTime()}`,
		);
	}
</script>

<main style="background: beige;">
	<APEXenv />
	<button type="butoon" on:click={showInfo}>Show Info</button>
	<div style="max-width: 60ch;">
		<p>
			Ut elementum mi, a interdum diam. Phasellus egestas ligula turpis, sed
			elementum augue dapibus eu. Quisque dictum at tellus in elementum.
			Maecenas consectetur tincidunt vulputate. Duis pellentesque mauris non
			varius cursus. Orci varius natoque penatibus et magnis dis parturient
			montes, nascetur ridiculus mus. Maecenas ac dolor id augue luctus
			ullamcorper. Sed vitae tellus nibh. Cras malesuada nibh eu est viverra
			tempus. Maecenas gravida mi nisi, vitae dictum nisl vestibulum vel. Nullam
			vitae nunc malesuada, pellentesque diam in, aliquet massa.
		</p>
		<p>
			Donec ac pharetra odio, sed mattis felis. Curabitur at diam faucibus,
			finibus ante non, aliquam tortor. Nunc vel pulvinar arcu, ac vulputate
			libero. Aliquam erat volutpat. Phasellus dapibus elit vel turpis sodales,
			nec ullamcorper tortor tristique. Nam scelerisque, nisl et egestas
			iaculis, tortor nisl bibendum metus, ac molestie nisi dolor dictum arcu.
			In erat nibh, fringilla et luctus vitae, aliquet eu diam. Nam pretium eros
			non tortor iaculis, ac venenatis tortor mattis. Praesent tincidunt laoreet
			nisl eget egestas. Vestibulum id erat egestas, condimentum dolor vel,
			dignissim arcu. Curabitur ac fringilla lorem, fringilla semper nisl.
		</p>
		<p>
			Nullam varius vestibulum eleifend. Nullam accumsan massa nec nulla
			placerat ullamcorper. Vivamus a dignissim arcu. Mauris vehicula metus
			mauris, sed interdum est convallis sed. Sed a felis elit. Donec volutpat
			convallis erat, pulvinar vestibulum dolor euismod maximus. Phasellus
			efficitur eget arcu ut pulvinar. Ut sed auctor libero. Ut sapien sem,
			pharetra eget ultricies non, suscipit in mi.
		</p>
		<p>
			Nam in nisi non quam malesuada volutpat sit amet eu ipsum. Nulla vitae
			diam pretium, efficitur eros quis, malesuada lectus. Morbi at posuere
			augue, vitae finibus lacus. Nam vel iaculis magna. Cras imperdiet feugiat
			odio. Duis elementum risus et laoreet interdum. Phasellus bibendum erat at
			est efficitur lacinia.
		</p>
		<p>
			Ut nisl nisi, malesuada vitae convallis ac, vulputate sed risus. Aliquam
			id faucibus arcu, a porta eros. Nunc ac facilisis neque, in luctus lectus.
			Nullam vestibulum ac dolor eu imperdiet. Suspendisse nec quam venenatis,
			tempor urna nec, aliquam lectus. Nunc a sapien faucibus, placerat lacus
			nec, condimentum mi. Aenean dignissim mi massa, nec vehicula est
			consectetur vitae. Aliquam condimentum lorem augue, sit amet pulvinar
			dolor semper ac. Nulla ac posuere quam, eget varius massa. Pellentesque id
			nunc ut libero maximus ultrices quis vel libero. Curabitur euismod, elit
			ac rutrum condimentum, lorem nisi posuere lorem, ut vulputate magna purus
			sed nulla. Nulla vel elit nec ipsum pulvinar auctor. Fusce pulvinar mi
			leo, sit amet eleifend nibh dapibus id. Praesent feugiat interdum lorem
			rhoncus malesuada. Nullam malesuada nulla et sapien scelerisque pharetra.
		</p>
	</div>
	{#if apexLoaded}
		<LongopsBadge />
	{/if}
</main>
