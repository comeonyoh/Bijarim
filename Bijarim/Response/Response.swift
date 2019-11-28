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
	
	var resultCode: ResponseCode
	
	var data: Any
	
	var list: [Any]?	{
		
		if let array	=	data	as?	[Any]	{
			return array
		}
		
		return nil
	}
}

class Response {
	
	var error: Error?
	
	var result: ReponseResult?
	
	init(_ error: Error) {
		self.error	=	error
		self.result	=	nil
	}
	
	init(_ code: ResponseCode, _ data: Any) {
		self.error	=	nil
		self.result	=	ReponseResult(resultCode: code, data: data)
	}
}

