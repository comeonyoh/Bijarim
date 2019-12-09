//
//  RequestTests.swift
//  BijarimTests
//
//  Created by Clayton Kim on 2019/11/28.
//  Copyright © 2019 ODOV. All rights reserved.
//

import XCTest
@testable import Bijarim

class RequestTests: XCTestCase {
	
	enum SerialRequestEnum: String {
		case Request_1
		case Request_2
		case Serial_test
		
		var name: String	{
			return self.rawValue
		}
	}

    func testGuaranteeSequenceOfSerialQueue() {
		
		let	r1	=	Request.request { (req, _) in
			sleep(1)
			req.name	=	SerialRequestEnum.Request_1.name
			req.finish()
		}
		
		let r2	=	Request.request { (req, _) in
			sleep(2)
			req.finish()
		}

		let queue	=	SerializeQueue(self)
		queue.name	=	SerialRequestEnum.Serial_test.name

		r1.name		=	SerialRequestEnum.Request_1.name
		r2.name		=	SerialRequestEnum.Request_2.name
		
		queue.addOperation(r1)
		queue.addOperation(r2)
    }
}

extension	RequestTests:	RequestQueueStream	{

	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {

		var req:	Request?	=	nil
		
		if 	req	==	nil,	let	first	=	spare?.first	as? Request	{
			req	=	first
		}
		else if let	last	=	spare?.last	as?	Request{
			XCTAssertNotNil(req?.name, last.name!)
		}
		
	}
}
