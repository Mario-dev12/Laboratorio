<template>
	<div v-if="show" class="modal-overlay">
		<div class="modal-content">
			<p>{{ message }}</p>
			<div class="buttons">
				<button @click="cancel">Cancel</button>
				<button @click="confirm">OK</button>
			</div>
		</div>
	</div>
</template>

<script setup>
	import { ref } from "vue";

	const show = ref(false);
	const message = ref("");

	let promiseResolve;

	// Function to trigger the modal from outside
	function open(msg) {
		message.value = msg;
		show.value = true;
		return new Promise((resolve) => {
			promiseResolve = resolve;
		});
	}

	function confirm() {
		show.value = false;
		promiseResolve(true);
	}

	function cancel() {
		show.value = false;
		promiseResolve(false);
	}

	// Expose the open method for parent access
	defineExpose({ open });
</script>

<style scoped>
	.modal-overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.5);
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.modal-content {
		background: white;
		padding: 20px;
		border-radius: 8px;
		min-width: 300px;
		max-width: 400px;
	}
	.buttons {
		display: flex;
		justify-content: flex-end;
		gap: 10px;
		margin-top: 20px;
	}
</style>
