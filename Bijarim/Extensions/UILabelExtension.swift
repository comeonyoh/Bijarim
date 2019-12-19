//
//  UILabelExtension.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/19.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

class WidthExpandedLabel	:	UILabel {
	
	override var intrinsicContentSize: CGSize	{
		return	CGSize(width: super.intrinsicContentSize.width	+	15, height: super.intrinsicContentSize.height)
	}
}
