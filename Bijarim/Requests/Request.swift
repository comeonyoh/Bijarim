//
//  Request.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

typealias RequestTask		=	(_ request: Request, _ object: AnyObject?)	->	Void
typealias RequstCompletion	=	(_ response: Response)						->	Void

protocol RequestComponent: NSObjectProtocol {
	
	var requestTaskObject:	AnyObject?	{	get	}
}

public	class	Request:	Operation,	RequestComponent	{
	
	public	enum State:	String {
		case executing, finished, ready
		
		var keyPath:	String	{
			return "is\(rawValue.capitalized)"
		}
	}

	var task:		RequestTask?
	var completion:	RequstCompletion?

	public	class	var descriptor:	Descriptor?	{
		return	nil
	}

	public	var state:	State	=	.ready	{
		willSet	{
			willChangeValue(forKey: state.keyPath)
			willChangeValue(forKey: newValue.keyPath)
		}
		
		didSet	{
			didChangeValue(forKey: oldValue.keyPath)
			didChangeValue(forKey: state.keyPath)
		}
	}
	
	public	override func start() {

		if	canStartTaskAutomatically	{
			requestWillStart()
			main()
			state	=	.executing
			task?(self, requestTaskObject)
		}
		else	{
			finish(Response(.fail))
		}
	}
	
	func finish() {
		finish(Response(.success))
	}
	
	func finish(_ response: Response) {
		state	=	.finished
		requestDidFinished(response: response)
	}
	
	public	var	canStartTaskAutomatically:	Bool	{
		return true
	}
	
	public	func requestWillStart() {
		
	}
	
	public	func requestDidFinished(response: Response) {
		completion?(response)
	}

	//	State related API family.
	public	override var isReady: Bool	{
		return super.isReady	&&	state	==	.ready
	}
	
	public	override var isExecuting: Bool	{
		return state	==	.executing
	}
	
	public	override var isFinished: Bool	{
		return state	==	.finished
	}
	
	public	var requestTaskObject: AnyObject?	{
		return nil
	}

	
	
	//	Creat request API family.
	override init() {
		super.init()
	}
	
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
