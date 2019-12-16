//
//  MetaObject.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/03.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

public	class	DescriptorValue {
	
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

public	class	StringDescriptorValue:	DescriptorValue {}

public	class	IntDescriptorValue:	DescriptorValue {
	
	override func setValue(meta: Meta, value: Any) {

		if	let	intValue	=	value	as?	Int	{
			meta.setValue(NSNumber(value: intValue), forKey: to)
		}
	}
}



public	class	Descriptor {
	
	public	var name:	String?	{
		return nil
	}
	
	public	class	var	descriptors:	[DescriptorValue]?	{
		return []
	}
	
	public	class	var classOfMeta:	Meta.Type	{
		return Meta.self
	}

	//	help parsing raw-data with descriptors and creating new one.
	public	func parseRawData(_ rawData: [String: Any])	->	Meta {

		let	meta	=	type(of: self).classOfMeta.init()
		
		guard let descriptors = type(of: self).descriptors else { return meta }

		for descriptor in descriptors	{
			if	let	value	=	rawData[descriptor.from]	{
				meta.setValue(value, forKey: descriptor.to)
			}
		}

		return meta
	}
	
}

public	class	Meta:	NSObject	{

	@objc	dynamic	var	identifier:	String!

	private	lazy	var	dictionary: [String: Any]	=	{
		return	[String	:	Any]()
	}()
	
	required	override	public	init() {
		super.init()
	}
	
	public override func setValue(_ value: Any?, forUndefinedKey key: String) {
		dictionary[key]	=	value
	}
	
	public override func value(forUndefinedKey key: String) -> Any? {
		return	dictionary[key]
	}
	
}


public	class	MetaList<T:	Meta>:	Meta	{
	
	private	lazy	var list:	[T]?	=	{
		
		var	metaList	=	[T]()
		return metaList
	}()
	
	public	func appendItem(_ item: T) {
		list?.append(item)
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

public	class	MetaListDescriptor:	Descriptor	{
	
	public	class	var classOfItemMeta:	Meta.Type	{
		return Meta.self
	}
	
	public override class var classOfMeta: Meta.Type	{
		return MetaList.self
	}
	
	public func parseRawData(_ rawData: [Any])	->	MetaList<Meta> {
		
		guard	let	list	=	type(of: self).classOfMeta.init()	as?	MetaList	<Meta>	else { return MetaList() }
		
		for	data	in	rawData	{

			let	meta	=	type(of: self).classOfItemMeta.init()
			guard	let	descriptors	=	type(of: self).descriptors	else { return MetaList() }

			for descriptor in descriptors	{

				if	let	value	=	data	as? String	{
					descriptor.setValue(meta: meta, value: value)
				}
				else if	let	dict	=	data	as?	[String:	Any],	let	value	=	dict[descriptor.from]	{
					descriptor.setValue(meta: meta, value: value)
				}
			}

			list.appendItem(meta)
		}
		
		return list
	}
}

