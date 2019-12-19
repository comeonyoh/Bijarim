//
//  MetaTests.swift
//  BijarimTests
//
//  Created by Clayton Kim on 2019/12/06.
//  Copyright © 2019 ODOV. All rights reserved.
//

import XCTest
@testable import Bijarim

class MetaTests: XCTestCase {

    func testMetaListParsing() {
		
		let	list	=	[
			["track_title"	:	"Empire State Of Mind (feat. Alicia Keys)"],
			["track_title"	:	"The Humpty Dance (LP Version)"],
			["track_title"	:	"Career High"]
		]

		let	track1	=	TrackMeta(list.first!)
		XCTAssertEqual(track1.title, list.first?["track_title"])
		
		let	tracks	=	TrackMetaList(list)
		XCTAssertEqual(tracks.count, list.count)
		
		if	let	track	=	tracks.first	as?	TrackMeta	{
			XCTAssertEqual(track.title, list.first?["track_title"])
		}
    }
	
	func testComplexMetaParsing() {
		
		let	rawData: [String:	Any]	=	[

			"nm"		:	"Clayton",
			"age"		:	31,
			"history"	:	[
				"Tiger",
				"Bugs"
			],
			
			"certificate"	:	[
				"level"	:	"master"
			]
		]

		let	human	=	Human(rawData)
		
		XCTAssertNil(human.from)
		XCTAssertTrue(human.history.count	==	2)
		XCTAssertEqual(human.certificate.level, "master")
	}
}



//	Test meta class for simple parsing
public	class	TrackMeta:	Meta	{
	
	@objc	dynamic	var	title:	String!

	public override var descriptors: [Descriptor]	{
		return	[
			StringDescriptor(from: "track_title", to: "title")
		]
	}
}

class TrackMetaList	<T:	TrackMeta>	:	MetaList<Meta> {
	
	override var classOfItemMeta: Meta.Type	{
		return	TrackMeta.self
	}
}



//	Test meta class for complex parsing
public	class	Certificate				:	Meta	{

	@objc	dynamic	var	level:	String!

	public	override	var descriptors:	[Descriptor]	{

		return	[
			Descriptor(from: "level", to: "level")
		]
	}
}

public	class	Human					:	Meta	{

	@objc	dynamic	var	name:			String!
	@objc	dynamic	var	from:			String?
	@objc	dynamic	var	age:			NSNumber!
	@objc	dynamic	var	history:		[String]!
	@objc	dynamic	var	certificate:	Certificate!

	public	override	var descriptors:	[Descriptor]	{

		return [
			Descriptor(from: "nm", to: "name")									,
			NumberDescriptor(from: "age", to: "age")							,
			ListDescriptor(from: "history", to: "history")						,
			CertificateDescriptor(from: "certificate", to: "certificate")
		]
	}
}

public	class	CertificateDescriptor	:	CustomDescriptor	{

	public	override	var metaClass: Meta.Type	{
		return Certificate.self
	}
}
