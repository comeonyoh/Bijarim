//
//  SoccerPlayer.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

class Team: Meta {
	@objc	dynamic	var name: String!
	@objc	dynamic	var country: String!
}

class SoccerPlayer: Meta {
	
	dynamic	var rank: Int!
	@objc	dynamic	var name: String!
	@objc	dynamic	var imagePath: String?
	@objc	dynamic	var	team:	Team!
	
	override var description: String	{
		return "Name: \(String(describing: name)), Rank: \(String(describing: rank)), path: \(String(describing: imagePath))"
	}
}

class SoccerPlayerDescriptor: Descriptor {
	
	override public	class var descriptors: [DescriptorValue]?	{
		return [
			DescriptorValue(from: "id", to: "identifier"),
			DescriptorValue(from: "name", to: "name"),
			DescriptorValue(from: "rank", to: "rank"),
			DescriptorValue(from: "imagePath", to: "imagePath"),
			DescriptorValue(from: "team_info", to: "team")
		]
	}
}

class SoccerPlayerListDescriptor: MetaListDescriptor {

	override class var classOfItemMeta: Meta.Type	{
		return SoccerPlayer.self
	}
	
	override class var descriptors: [DescriptorValue]?	{
		return SoccerPlayerDescriptor.descriptors
	}
}

