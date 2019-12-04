//
//  MetaObject.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/03.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation


public	struct	DescriptorValue {
	
	var from:	String
	var to:		String
}

public	class	Descriptor {
	
	public	var name:	String?	{
		return nil
	}
	
	public	var descriptors:	[DescriptorValue]?	{
		return []
	}
	
	public	var classOfMeta:	Meta.Type	{
		return Meta.self
	}

	//	help parsing raw-data with descriptors and creating new one.
	public	func parseRawData(_ dictionary: [String: Any])	->	Meta {

		let	meta	=	classOfMeta.init()
		
		guard let descriptors = descriptors else { return meta }

		for descriptor in descriptors	{
			if	let	value	=	dictionary[descriptor.from]	{
				meta.setValue(value, forKey: descriptor.to)
			}
		}
		
		return meta
	}
	
}

public	class	Meta:	NSObject	{

	lazy	var	dictionary: [String: Any]	=	{
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
	
}

public	class	MetaListDescriptor:	Descriptor	{
	
	public	var classOfItemMeta:	Meta.Type	{
		return Meta.self
	}
	
	public override var classOfMeta: Meta.Type	{
		return MetaList.self
	}
}



/**
 *	Examples
 */
public	class	TrackMeta:	Meta	{
	
	@objc	dynamic	var	title:	String!

}

public	class	TrackDescriptor:	Descriptor	{
	
	override	public	var descriptors: [DescriptorValue]?	{
		return [
			DescriptorValue(from: "track_title", to: "title"),
			DescriptorValue(from: "artist_title", to: "artist_title"),
		]
	}
	
	override	public	var classOfMeta: Meta.Type	{
		return TrackMeta.self
	}
	
}
