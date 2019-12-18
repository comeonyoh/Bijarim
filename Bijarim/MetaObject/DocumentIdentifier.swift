//
//  DocumentIdentifier.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/09.
//  Copyright © 2019 ODOV. All rights reserved.
//

import Foundation

class DocumentIdentifier: Meta {
	
	override var descriptors: [Descriptor]	{
		return	[
			Descriptor(from: "", to: "identifier")
		]
	}
}

class DocumentList	<T:	DocumentIdentifier>	:	MetaList<Meta> {
	
	override var classOfItemMeta: Meta.Type	{
		return	DocumentIdentifier.self
	}
}
