export interface User {
	idUser: number;
	ci: number;
	passport: number;
	firstName: string;
	lastName: string;
	genre: string;
	age: number;
	address: string;
	createdDate: any;
	modifiedDate: any;
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
