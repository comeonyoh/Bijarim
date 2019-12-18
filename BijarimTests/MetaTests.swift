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
}



/**
 *	Examples
 */
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
