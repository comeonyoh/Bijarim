//
//  SoccerPlayer.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

class SoccerPlayer: Meta {
	dynamic	var rank: Int!
	@objc	dynamic	var name: String!
	@objc	dynamic	var imagePath: String?
}

class SoccerPlayerDescriptor: Descriptor {
	
	override public	class var descriptors: [DescriptorValue]?	{
		return [
			//	"" means the key value from remote is nil.
			DescriptorValue(from: "id", to: "identifier"),
			DescriptorValue(from: "name", to: "name"),
			DescriptorValue(from: "rank", to: "rank"),
			DescriptorValue(from: "imagePath", to: "imagePath")
		]
	}
}

class SoccerPlayerListDescriptor: MetaListDescriptor {
	
	override class var classOfMeta: Meta.Type	{
		return SoccerPlayer.self
	}
	
	override class var descriptors: [DescriptorValue]?	{
		return SoccerPlayerDescriptor.descriptors
	}
}
