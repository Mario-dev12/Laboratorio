<template>
	<ion-page>
		<ion-content>
			<div class="container">
				<div class="perfiles mt-3">
					<h4>Perfiles</h4>
					<div class="row w-100 m-auto gap-2">
						<div class="col btn btn-light" v-for="(profile, index) in profileNames" :key="index" @click="handleSection(index)">
							{{ profile }}
						</div>
					</div>
				</div>

				<div class="Secciones mt-3">
					<h4>Secciones</h4>
					<div class="row w-100 m-auto gap-2">
						<div class="col btn btn-light" v-for="(seccion, index) in sectionNames" :key="index" @click="changeTable(seccion)">
							{{ seccion }}
						</div>
					</div>
				</div>

				<div class="section-table mt-4">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">Nombre</th>
								<th scope="col">Valor</th>
								<th scope="col">Unidad</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(item, index) in tableInfo" :key="index">
								<td>{{ item.nombre }}</td>
								<td><input type="text" /></td>
								<td>{{ item.unidad }}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent } from "@ionic/vue";
	import { profileStore } from "@/stores/profileStore";
	import { ref, onMounted } from "vue";
	import html2pdf from "html2pdf.js";
	import { useRoute } from "vue-router";

	const profilesStore = profileStore();
	const route = useRoute();
	let profiles: string[] = [];
	let profileNames: any = "";
	const profilesData = ref<any[]>([]);
	const sectionNames = ref();
	const sectionData = ref();
	const tableInfo = ref();

	profiles = ["Perfil 20", "Uroanalisis", "Perfil Tiroideo"];

	onMounted(async () => {
		profileNames = route.query.profileNames;
		profileNames = JSON.parse(profileNames);
		console.log(profileNames);
		for (const profile of profiles) {
			const profileSection = await profilesStore.fetchProfileByInputsName(profile);
			profilesData.value.push(profileSection);
		}
		sectionData.value = profilesData.value[0];
		sectionNames.value = Object.keys(profilesData.value[0]);
		console.log(profilesData.value);
	});

	const generatePDF = () => {
		const element = document.getElementById("contentToPDF");
		const options = {
			margin: 1,
			filename: "perfil_laboratorio.pdf",
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "in", format: "letter", orientation: "portrait" },
		};

		html2pdf().from(element).set(options).save();
	};

	function handleSection(index: number) {
		sectionData.value = profilesData.value[index];
		sectionNames.value = Object.keys(profilesData.value[index]);
		tableInfo.value = "";
	}

	const changeTable = (section: string) => {
		console.log(section);
		console.log(sectionData.value[section]);
		tableInfo.value = sectionData.value[section]["resultado"];
		console.log(tableInfo.value);
	};
</script>

<style scoped>
	.button {
		--background-activated: #2819ff;
	}

	#content {
		height: 100%;
	}
</style>
