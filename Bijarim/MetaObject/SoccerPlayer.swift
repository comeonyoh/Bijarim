//
//  SoccerPlayer.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

public	class Grade: Meta {
	@objc	dynamic	var name: String!
	dynamic	var level:	NSNumber!
	
	public override var descriptors: [Descriptor]	{
		return	[
			StringDescriptor(from: "name", to: "name")	,
			IntDescriptor(from: "level", to: "level")
		]
	}
}

public	class	GradeDescriptor:	CustomDescriptor	{
	
	public override var metaClass: Meta.Type	{
		return	Grade.self
	}
}

public	class	SoccerPlayer: Meta {
	
	@objc	dynamic	var	rank: NSNumber!
	@objc	dynamic	var name: String!
	@objc	dynamic	var imagePath: String?
	@objc	dynamic	var	grade:	Grade?

	public override var descriptors: [Descriptor]	{
		return	[
			StringDescriptor(from: "id", to: "identifier")			,
			IntDescriptor(from: "rank", to: "rank")					,
			StringDescriptor(from: "imagePath", to: "imagePath")	,
			StringDescriptor(from: "name", to: "name")				,
			GradeDescriptor(from: "grade", to: "grade")
		]
	}
}

class SoccerPlayerList	<T:	SoccerPlayer>	:	MetaList	<Meta> {
	
	override var classOfItemMeta: Meta.Type	{
		return	SoccerPlayer.self
	}
}
