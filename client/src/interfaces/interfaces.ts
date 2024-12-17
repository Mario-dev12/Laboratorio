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
	quantity: number;
	idexam: number;
	createddate: any;
	modifieddate: any;
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
	idreactive: number;
	idprovider: number;
	createddate: any;
	modifieddate: any;
}
