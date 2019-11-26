//
//  RequestQueue.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

protocol	RequestQueueStream: NSObjectProtocol {
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue)
}

public	class RequestQueue: OperationQueue {

	weak	var delegate:	RequestQueueStream?
	var operationsObservation:	NSKeyValueObservation!
	
	override init() {
		
		super.init()
		prepareInitialize(self)
	}
	
	init(_ stream: RequestQueueStream?) {
		
		super.init()
		if let stream	=	stream {
			prepareInitialize(stream)
		}
		else {
			prepareInitialize(self)
		}
	}
	
	func prepareInitialize(_ stream: RequestQueueStream?) {
		
		delegate	=	stream
		
		self.operationsObservation	=	observe(\.operations, options: [.old, .new], changeHandler: { (queue, ops) in
			self.delegate?.operationCountDidChanged(ops.newValue, by: queue)
		})
	}
}

extension	RequestQueue:	RequestQueueStream	{
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {

	}
}

class SerializeQueue: RequestQueue {
	
	override init() {
		super.init()
		self.maxConcurrentOperationCount	=	1
	}

	override init(_ stream: RequestQueueStream?) {
		super.init(stream)
		self.maxConcurrentOperationCount	=	1
	}
}
