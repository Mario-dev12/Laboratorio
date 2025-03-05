import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Exam } from "@/interfaces/interfaces";

export const examStore = defineStore("exam", {
	state: () => ({
		exams: [] as Exam[] | Exam,
	}),
	actions: {
		async fecthExams() {
			const response = await axiosRepository.getAll<Exam>("exam");
			this.exams = response;
			return this.exams;
		},
		async createExam(exam: Exam) {
			const response = await axiosRepository.create<Exam>("exam", exam);
			this.exams = response;
			return this.exams;
		},
		async createExamResults(exam: Exam) {
			const response = await axiosRepository.createExamResults<Exam>("exam", exam);
			this.exams = response;
			return this.exams;
		},
		async updateExam(id: string | number, data: Exam) {
			const response = await axiosRepository.update<Exam>("exam", id, data);
			this.exams = response;
			return this.exams;
		},
		async deleteExam(id: string | number) {
			await axiosRepository.delete("exam", id);
		},
	},
});
