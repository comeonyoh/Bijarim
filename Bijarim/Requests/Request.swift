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

typealias RequestTask		=	(_ request: Request, _ object: AnyObject?)	->	Void
typealias RequstCompletion	=	(_ response: Response)						->	Void

protocol RequestComponent: NSObjectProtocol {
	
	var requestTaskObject:	AnyObject?	{	get	}
}

class	Request:	Operation,	RequestComponent	{
	
	enum State:	String {
		case executing, finished, ready
		
		var keyPath:	String	{
			return "is\(rawValue.capitalized)"
		}
	}

	var task:		RequestTask?
	var completion:	RequstCompletion?
	
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
			task?(self, requestTaskObject)
		}
	}
	
	func finish() {
		state	=	.finished
		requestDidFinished()
	}
	
	func taskObject() -> AnyObject? {
		return nil
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
	
	var requestTaskObject: AnyObject?	{
		return nil
	}

	//	Creat request API family.
	required	init(_ task: @escaping RequestTask, with completion: RequstCompletion?) {
		
		super.init()
		
		self.task		=	task
		self.completion	=	completion
	}
	
	static	func request(_ task: @escaping RequestTask) -> Self {
		return self.init(task, with: nil)
	}

	static	func request(_ task: @escaping RequestTask, with completion: @escaping RequstCompletion) -> Self {
		return self.init(task, with: completion)
	}
}

extension	Request:	RequestStream	{
	
	func requestWillBegin() -> Bool {
		return true
	}
	
	func requestDidFinished() {
		
	}
}
