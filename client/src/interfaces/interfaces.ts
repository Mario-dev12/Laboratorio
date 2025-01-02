export interface User {
	iduser: number;
	ci: number;
	passport: number;
	firstname: string;
	lastname: string;
	genre: string;
	age: number;
	address: string;
	createddate: any;
	modifieddate: any;
}
export interface Exam {
	idexam: number;
	name: string;
	cost_bs: number;
	cost_usd: number;
	status: string;
	iduser: number;
	createddate: any;
	modifieddate: any;
}

export interface Reactive {
	idreactive: number;
	name: string;
	createddate: any;
	modifieddate: any;
	totalQuantity: number;
}

export interface ReactiveProvider {
	idreactive: number;
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
	idunit: number;
	name: string;
	idexam: number;
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
	idalliance: number;
	quantity: number;
	cost_bs: string;
    cost_usd: string;
    pay_done: boolean;
    pay_amount: string;
	idreactive: number;
	idprovider: number;
	createddate: any;
	modifieddate: any;
}

export interface Payment {
	idpayment_method: number;
	name: string;
	amount: number;
	bank: string;
	type: string;
	idexam: number;
	createddate: any;
	modifieddate: any;
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