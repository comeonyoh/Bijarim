//
//  FirebaseRequestQueue.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit
import Firebase

class FirebaseRequestQueue: RequestQueue {

	let	store	=	Firestore.firestore()
	
	override func addOperation(_ op: Operation) {
		
		if let	request	=	op	as?	FirebaseRequest {
			request.store	=	store
		}
	}
}

class FirebaseRequest: Request	{

	weak	var	store:	Firestore?
	
	override	var	requestTaskObject: AnyObject?	{
		return store
	}
}
