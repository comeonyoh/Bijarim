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
}

struct ReponseResult {
	var code: ResponseCode
}

class Response {
	
	var error:	Error?
	var result: ReponseResult?
	
	init(_ error: Error) {
		self.error	=	error
	}
	
	init(_ code: ResponseCode) {
		self.result	=	ReponseResult(code: code)
	}
	
}

class MetaResponse	: Response {
	
	var data:	Meta?
	var list:	MetaList<Meta>?
	
	required	init (_ code: ResponseCode, _ list: [Any]?, descriptor creator:	MetaListDescriptor) {

		super.init(code)

		if	let	list		=	list	{
			self.list		=	creator.parseRawData(list)
		}
	}
}
