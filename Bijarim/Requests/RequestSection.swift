//
//  RequestSection.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/10.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

public	class	RequestSection:	FirebaseRequest	{

	private	var list: MetaList<Meta>?
	
	public	var	numberOfItems:	Int	{
		guard	let	list	=	list	else	{ return 0 }
		return list.count
	}
	
	public	var isActiveSection: Bool	{
		return true
	}
	
	public override func requestDidFinished(response: Response) {
		
		if	let	result	=	response	as?	MetaResponse	{
			list		=	result.list
		}
	}
}

extension	RequestSection:	Collection	{
	
	public typealias Index = Int
	
	public var startIndex: Int	{
		guard let list = list else { return 0 }
		return list.startIndex
	}
	
	public var endIndex: Int	{
		guard let list = list else { return 0 }
		return	list.endIndex
	}
	
	@objc	public subscript(position: Int) -> Meta? {

		guard	let	list	=	list	else	{	return nil	}
		return list[position]
	}
	
	public func index(after i: Int) -> Int {

		guard	let	list	=	list	else	{	return 0	}
		return	list.index(after: i)
	}
}
