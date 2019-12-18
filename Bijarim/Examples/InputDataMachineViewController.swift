//
//  InputDataMachineViewController.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/18.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import CommonCrypto

class	InputDataMachineViewController	:	UIViewController {

	var data:	[[String:	Any]]!
	var index	=	0
	
	override func viewDidLoad() {

		super.viewDidLoad()
		
		self.data	=
		[
		
			[
				"name"	:	"Lionel Messi"		,
				"rank"	:	1					,
				"imagePath":	"rank_1.jpg"	,
				"info":	[
					"name"	:	"Barcelona"		,
					"level"	:	9.23
				]
			],
			
			[
				"name"	:	"Timo Werner"		,
				"rank"	:	2					,
				"imagePath":	"rank_2.jpg"	,
				"info":	[
					"name"	:	"Leipzig"		,
					"level"	:	8.60
				]
			],
			
			[
				"name"	:	"Dimitri Payet"		,
				"rank"	:	3					,
				"imagePath":	"rank_3.jpg"	,
				"info":	[
					"name"	:	"Marseille",
					"level"	:	8.42
				]
			],
			
			[
				"name"	:	"Angel Di Maria"	,
				"rank"	:	4					,
				"imagePath":	"rank_4.jpg"	,
				"info":	[
					"name"	:	"Paris saint germain",
					"level"	:	8.20
				]
			],
			
			[
				"name"	:	"Sebastian Andersson"	,
				"rank"	:	5						,
				"imagePath":	"rank_5.jpg"		,
				"info":	[
					"name"	:	"Union berlin",
					"level"	:	8.20
				]
			],
			
			[
				"name"	:	"Heung-Min Son"		,
				"rank"	:	6					,
				"imagePath":	"rank_6.jpg"	,
				"info":	[
					"name"	:	"Tottenham",
					"level"	:	8.17
				]
			],
			
			[
				"name"	:	"James Maddison"		,
				"rank"	:	7					,
				"imagePath":	"rank_7.jpg"	,
				"info":	[
					"name"	:	"Leicester City",
					"level"	:	8.10
				]
			],
			
			[
				"name"	:	"Radja Nainggolan"		,
				"rank"	:	8					,
				"imagePath":	"rank_8.jpeg"	,
				"info":	[
					"name"	:	"Inter Milan",
					"level"	:	8.09
				]
			],

			[
				"name"	:	"Sadio Mane"		,
				"rank"	:	9					,
				"imagePath":	"rank_8.jpeg"	,
				"info":	[
					"name"	:	"Liverpool",
					"level"	:	8.09
				]
			],
			
			[
				"name"	:	"Marcus Thuram"		,
				"rank"	:	10					,
				"imagePath":	"rank_9.jpg"	,
				"info":	[
					"name"	:	"Borussia",
					"level"	:	8.04
				]
			],
		]
		
	}
	
	@IBAction func click(_ sender: Any) {

		if	index	<	self.data.count	{
			
			Firestore.firestore().collection("soccer_players").document(self.data[index]["name"]	as!	String).setData(self.data[index])

			index	=	index	+	1
		}
	}
}

