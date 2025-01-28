export interface User {
	id?: number;
	idUser: number;
	ci: string;
	passport: number | null;
	firstName: string;
	lastName: string;
	genre: string;
	age: number;
	address: string;
	createdDate?: any;
	modifiedDate?: any;
}

export interface Profile {
	id?: number;
	idProfile: number;
	name: string;
	cost_bs: string;
	cost_usd: string;
	status: string;
	createddate?: any;
	modifieddate?: any;
}

export interface Exam {
	id?: number;
	idExam?: number;
	idUser: number;
	total_cost_bs: string;
	total_cost_usd: string;
	createddate?: any;
	modifieddate?: any;
}

export interface Order {
	id?: number;
	idOrder?: number;
	idExam: number;
	idProfile: number;
	createddate?: any;
	modifieddate?: any;
}

export interface Reactive {
	idReactive: number;
	name: string;
	createddate: any;
	modifieddate: any;
	total: number;
}

export interface ReactiveProvider {
	idReactive: number;
	name: string;
	createddate: any;
	modifieddate: any;
	providerName: string;
	providerQuantity: number;
	cost_bs: string;
	cost_usd: string;
	pay_done: boolean;
	pay_amount: string;
	idProvider: number;
	idAlliance: number;
}

export interface Unit {
	idUnit: number;
	name: string;
	idProfile: number;
	createddate: any;
	modifieddate: any;
}

export interface Provider {
	idprovider: number;
	name: string;
	createddate: any;
	modifieddate: any;
}

export interface Alliance {
	idAlliance: number;
	quantity: number;
	cost_bs: string;
	cost_usd: string;
	pay_done: boolean;
	pay_amount: string;
	idReactive: number;
	idProvider: number;
	createddate: any;
	modifieddate: any;
}

export interface Payment_Method {
	idPayment_method: number;
	name: string;
	createddate: any;
	modifieddate: any;
}

export interface Payment {
	idPayment?: number;
	idPayment_method: number;
	idExam: number;
	amount_bs: string;
    amount_usd: string;
    bank: string;
    phone: string;
    type: string;
	createddate?: any;
	modifieddate?: any;
}

export interface Income {
	idExam: number;
	examName: string;
	cost_bs: string;
	cost_usd: string
	createdDate: any;
	idUser: number;
	ci: string;
	passport: string;
	firstName: string;
	lastName: string;
	genre: string;
	age: number;
	idPaymentMethod: number;
	PaymentMethodName: string;
	amount: string;
	bank: string;
	type: string;
}

export interface Bill {
	idAlliance: number;
	quantity: number;
	cost_bs: string;
	cost_usd: string;
	pay_done: boolean;
	pay_amount: string;
	createdDate: any;
	idProvider: number;
	providerName: string;
	idReactive: number;
	reactiveName: string;
}