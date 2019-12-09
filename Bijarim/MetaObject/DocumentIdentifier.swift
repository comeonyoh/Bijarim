//
//  DocumentIdentifier.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/09.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

class DocumentIdentifier: Meta {
}

class DocumentDescriptor: Descriptor {
	
	override public	class var descriptors: [DescriptorValue]?	{
		return [
			//	"" means the key value from remote is nil.
			DescriptorValue(from: "", to: "identifier")
		]
	}
}

class DocumentListDescriptor: MetaListDescriptor {
	
	override var classOfItemMeta: Meta.Type	{
		return DocumentIdentifier.self
	}
	
	override class var descriptors: [DescriptorValue]?	{
		return DocumentDescriptor.descriptors
	}
}
