//
//  MultipleSectionViewController.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/10.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

class MultipleSectionViewController: TableViewController {
	
}

class FirebaseSection1: TableViewSection {
	
	override var name: String?	{
		set	{}
		get	{
			return "Firebase1"
		}
	}
	
	override var paths: [FirebasePathItem]?	{
		set {}
		get {
			return [FirebasePathItem(path: "address_samples", pathType: .collection)]
		}
	}
	
	override class var descriptor: Descriptor?	{
		return DocumentListDescriptor()
	}
}

class FirebaseSection2: TableViewSection {
	
	override var name: String?	{
		set	{}
		get	{
			return "Firebase2"
		}
	}

	override var paths: [FirebasePathItem]?	{
		set {}
		get {
			return [FirebasePathItem(path: "example_accounts", pathType: .collection)]
		}
	}
	
	override class var descriptor: Descriptor?	{
		return DocumentListDescriptor()
	}
}
