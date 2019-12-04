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
	
	var data:	Meta?
	var error:	Error?
	var result: ReponseResult?
	
	init(_ error: Error) {
		self.error	=	error
	}
	
	init(_ code: ResponseCode, _ data: Any) {
		self.result	=	ReponseResult(code: code)
	}
}

