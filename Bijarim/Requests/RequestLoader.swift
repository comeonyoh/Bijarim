//
//  RequestLoader.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/10.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

public	class	RequestLoader: FirebaseRequestQueue {
	
	@IBOutlet	var sections: [RequestSection]!

	internal	var	activeSections:	[RequestSection]!

	func validateActiveSections() {

		activeSections	=	sections.filter({ (section) -> Bool in
			return section.isActiveSection
		})
	}
	
	func startRequests() {
		for section in activeSections {
			self.addOperation(section)
		}
	}
}

extension	RequestLoader:	Collection	{
	
	public typealias Index = Int
	
	public var startIndex: Int	{
		guard let list = activeSections else { return 0 }
		return list.startIndex
	}
	
	public var endIndex: Int	{
		guard let list = activeSections else { return 0 }
		return	list.endIndex
	}
	
	@objc	public subscript(position: Int) -> RequestSection? {

		guard	let	list	=	activeSections	else	{	return nil	}
		return list[position]
	}
	
	public func index(after i: Int) -> Int {

		guard	let	list	=	activeSections	else	{	return 0	}
		return	list.index(after: i)
	}
}

