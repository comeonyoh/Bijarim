//
//  Request.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation


protocol	RequestStream {
	
	//	Condition for whether start tasking or not.
	func requestWillBegin() -> Bool
	
	func requestDidFinished()
}

typealias RequestTask	=	(_ request: Request)	->	Void

class	Request:	Operation	{
	
	enum State:	String {
		case executing, finished, ready
		
		var keyPath:	String	{
			return "is\(rawValue.capitalized)"
		}
	}

	var task:	RequestTask?
	
	var state:	State	=	.ready	{
		willSet	{
			willChangeValue(forKey: state.keyPath)
			willChangeValue(forKey: newValue.keyPath)
		}
		
		didSet	{
			didChangeValue(forKey: oldValue.keyPath)
			didChangeValue(forKey: state.keyPath)
		}
	}
	
	override func start() {

		if requestWillBegin() {
			main()
			state	=	.executing
			
			if let	task	=	self.task	{
				task(self)
			}
		}
	}
	
	func finish() {
		state	=	.finished
		requestDidFinished()
	}
	
	override var isReady: Bool	{
		return super.isReady	&&	state	==	.ready
	}
	
	override var isExecuting: Bool	{
		return state	==	.executing
	}
	
	override var isFinished: Bool	{
		return state	==	.finished
	}
	
	//	Creat request API family.
	static	func request(_ task: @escaping RequestTask) -> Request {
		
		let request = Request()
		request.task	=	task
		
		return request
	}

}


extension	Request:	RequestStream	{
	
	func requestWillBegin() -> Bool {
		return true
	}
	
	func requestDidFinished() {
		
	}
}
