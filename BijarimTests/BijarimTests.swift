//
//  BijarimTests.swift
//  BijarimTests
//
//  Created by Clayton Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import XCTest
@testable import Bijarim

class BijarimTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGuaranteeSequenceOfSerialQueue() {
		
		let	r1	=	Request.request { (req) in
			print("R1")
			req.finish()
		}
		let r2	=	Request.request { (req) in
			print("R2")
			req.finish()
		}

		let queue	=	SerializeQueue()
		
		queue.addOperation(r1)
		queue.addOperation(r2)
    }
}

extension	BijarimTests:	RequestQueueStream	{
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue)	{
		print("spare = \(spare), queue = \(queue)")
	}
}
