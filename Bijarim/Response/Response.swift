//
//  Response.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/28.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

enum ResponseCode: Int {
	case success	=	200
	case fail		=	400
}

struct ReponseResult {
	var code: ResponseCode
}

public	class Response {
	
	var error:	Error?
	var result: ReponseResult?
	
	init(_ error: Error) {
		self.error	=	error
	}
	
	init(_ code: ResponseCode) {
		self.result	=	ReponseResult(code: code)
	}	
}

public	class MetaResponse	: Response {
	
	var data:	Meta?
	var list:	MetaList<Meta>?
	
	required	init(_ code: ResponseCode, rawData:	Any?	=	nil,	descriptor	classOfResponse:	Meta.Type) {
		
		super.init(code)
		
		if	let	rawData	=	rawData	{
			self.data	=	classOfResponse.init(rawData)
		}
	}
	
	required	init (_ code: ResponseCode,	_ list: [Any]?	=	nil,	descriptor	classOfResponse:	MetaList<Meta>.Type) {

		super.init(code)

		if	let	list	=	list	{
			self.list	=	classOfResponse.init(list)
		}
	}
}
