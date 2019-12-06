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

		let	tracks	=	TrackListDescriptor().parseRawData(list)
			
		for (idx, _) in tracks.enumerated()	{
				
			let	originValue	=	list[idx]["track_title"]
			if	let	track	=	tracks[idx]	as?	TrackMeta	{
				XCTAssertEqual(originValue, track.title)
			}
		}
    }
}



/**
 *	Examples
 */
public	class	TrackMeta:	Meta	{
	
	@objc	dynamic	var	title:	String!

}

public	class	TrackDescriptor:	Descriptor	{

	override	public	class	var	descriptors:	[DescriptorValue]?	{
		return [
			DescriptorValue(from: "track_title", to: "title"),
			DescriptorValue(from: "artist_title", to: "artist_title"),
		]
	}
	
	override	public	var classOfMeta: Meta.Type	{
		return TrackMeta.self
	}
	
}

public	class	TrackListDescriptor:	MetaListDescriptor	{
	
	override	public	var classOfItemMeta:	Meta.Type	{
		return TrackMeta.self
	}

	public override class var descriptors: [DescriptorValue]?	{
		return TrackDescriptor.descriptors
	}
	
}
