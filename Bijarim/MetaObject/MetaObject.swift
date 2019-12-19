//
//  MetaObject.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/03.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

public	class	Descriptor {
	
	internal	var	to:	String
	internal	var from: String

	public	init(from: String, to: String) {
		self.to		=	to
		self.from	=	from
	}
	
	func setValue(meta: Meta, value: Any) {
		meta.setValue(value, forKey: to)
	}
}

public	class	StringDescriptor	:	Descriptor	{
	
}

public	class	NumberDescriptor	:	Descriptor	{
	
	override func setValue(meta: Meta, value: Any) {
		
		if	let	intValue	=	value	as?	Int	{
			super.setValue(meta: meta, value: NSNumber(value: intValue))
		}
		else	if	let	floatValue	=	value	as?	Float	{
			super.setValue(meta: meta, value: NSNumber(value: floatValue))
		}
		else	{
			super.setValue(meta: meta, value: value)
		}
	}
}

public	class	ListDescriptor		:	Descriptor	{

	override func setValue(meta: Meta, value: Any) {
		
		if	let	listValue	=	value	as?	[Any]	{
			super.setValue(meta: meta, value: listValue)
		}
		else	{
			super.setValue(meta: meta, value: value)
		}
	}
}

public	class	CustomDescriptor	:	Descriptor	{
	
	public	var	metaClass:	Meta.Type	{
		return	Meta.self
	}
	
	public	override func setValue(meta: Meta, value: Any) {
		
		if	let	map	=	value	as?	[String	:	Any]	{
			meta.setValue(metaClass.init(map), forKey: to)
		}
		else	{
			super.setValue(meta: meta, value: value)
		}
	}
}

public	class	Meta				:	NSObject	{

	@objc	dynamic	var	identifier:	String!

	private	lazy	var	dictionary: [String: Any]	=	{
		return	[String	:	Any]()
	}()

	required	public	override init() {
		super.init()
	}
	
	required	public	init(_	rawData:	Any) {
		
		super.init()
		
		for	descriptor	in	descriptors	{
			
			if	let	dict	=	rawData	as?	[String:	Any],	let	value	=	dict[descriptor.from]	{
				descriptor.setValue(meta: self, value: value)
			}
			else	if	let	value	=	rawData	as?	String	{
				descriptor.setValue(meta: self, value: value)
			}
		}
	}
	
	public override func setValue(_ value: Any?, forUndefinedKey key: String) {
		dictionary[key]	=	value
	}
	
	public override func value(forUndefinedKey key: String) -> Any? {
		return	dictionary[key]
	}
	
	public	var	descriptors:	[Descriptor]	{
		
		return	[
		
		]
	}
}

protocol SortableMeta {
	var sortKey:	Int	{	get	}
}

public	class	MetaList<T:	Meta>:	NSObject	{
	
	private	lazy	var list:	[T]?	=	{
		
		var	metaList	=	[T]()
		return metaList
	}()

	public	var classOfItemMeta:	Meta.Type	{
		return Meta.self
	}

	public	var	sortable:	Bool	{
		return	false
	}

	public	func appendItem(_ item: T) {
		list?.append(item)
	}
	
	required	public	init(_	rawData:	[Any]) {
		
		super.init()
		
		for	data	in	rawData	{
		
			if	let	meta	=	classOfItemMeta.init(data)	as?	T	{
				self.appendItem(meta)
			}
		}
		
		if	sortable	==	true	{
			internalSort()
		}
	}
	
	private	func	internalSort() {

		list	=	list?.sorted(by: { (meta1, meta2) -> Bool in
			
			if	let	sort1	=	meta1	as?	SortableMeta,	let	sort2	=	meta2	as?	SortableMeta	{
				return sort1.sortKey	<	sort2.sortKey
			}

			return false
		})
	}
}

extension	MetaList:	Collection	{
	
	public typealias Index = Int
	
	public var startIndex: Int	{
		guard let list = list else { return 0 }
		return list.startIndex
	}
	
	public var endIndex: Int	{
		guard let list = list else { return 0 }
		return	list.endIndex
	}
	
	public subscript(position: Int) -> T? {

		guard	let	list	=	list	else	{	return nil	}
		return list[position]
	}
	
	public func index(after i: Int) -> Int {

		guard	let	list	=	list	else	{	return 0	}
		return	list.index(after: i)
	}
	
}
