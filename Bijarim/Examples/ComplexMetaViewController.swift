//
//  ComplexMetaViewController.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

public	class	ComplexMetaViewController	:	CollectionViewController {
	
}

public	class ComplexSection:	CollectionViewSection {
	
	public	override var name: String?	{
		set	{}
		get	{
			return "Complex"
		}
	}
	
	public	override var paths: [FirebasePathItem]?	{
		set {}
		get {
			return [FirebasePathItem(path: "image_samples", pathType: .collection)]
		}
	}
	
	public	override class var descriptor: Descriptor?	{
		return SoccerPlayerListDescriptor()
	}

	public override func requestDidFinished(response: Response) {
		super.requestDidFinished(response: response)
		
		if	let	res	=	response	as?	MetaResponse,	let	list	=	res.list	{
			print(list[0])
		}
	}
}
