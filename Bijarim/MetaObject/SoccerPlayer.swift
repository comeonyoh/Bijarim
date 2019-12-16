//
//  SoccerPlayer.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

class Grade: Meta {
	@objc	dynamic	var name: String!
	dynamic	var level:	NSNumber!
}

class SoccerPlayer: Meta {
	
	@objc	dynamic	var	rank: NSNumber!
	@objc	dynamic	var name: String!
	@objc	dynamic	var imagePath: String?
	@objc	dynamic	var	grade:	Grade!
	
	override var description: String	{
		return "Name: \(String(describing: name)), Rank: \(String(describing: rank)), path: \(String(describing: imagePath)), grade_name: \(String(describing: self.grade.name))"
	}
}

class GradeDescriptor: Descriptor {
	
	override class var classOfMeta: Meta.Type	{
		return Grade.self
	}
	
	override public	class var descriptors: [DescriptorValue]?	{

		return [
			DescriptorValue(from: "name", to: "name"),
			IntDescriptorValue(from: "grade", to: "grade"),
		]
	}
}

class SoccerPlayerDescriptor: Descriptor {
	
	override public	class var descriptors: [DescriptorValue]?	{

		return [
			DescriptorValue(from: "id", to: "identifier"),
			DescriptorValue(from: "name", to: "name"),
			IntDescriptorValue(from: "rank", to: "rank"),
			DescriptorValue(from: "imagePath", to: "imagePath"),
			DescriptorValue(from: "grade", to: "grade")
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

