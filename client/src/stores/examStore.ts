import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Exam, Result } from "@/interfaces/interfaces";

export const examStore = defineStore("exam", {
	state: () => ({
		exams: [] as Exam[] | Exam,
		result: {} as Result,
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
		async createExamResults(result: Result) {
			const response = await axiosRepository.createExamResults<Result>("exam", result);
			this.result = response;
			return this.result;
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
