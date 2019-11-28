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

    func testGuaranteeSequenceOfSerialQueue() {
		
		let	r1	=	Request.request { (req, _) in
			sleep(1)
			req.finish()
		}
		let r2	=	Request.request { (req, _) in
			sleep(2)
			req.finish()
		}

		let queue	=	SerializeQueue()
		
		queue.addOperation(r1)
		queue.addOperation(r2)
    }

}
