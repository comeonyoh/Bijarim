//
//  FirebaseRequestQueue.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit
import Firebase

class FirebaseRequestQueue: SerializeQueue {

	let	store	=	Firestore.firestore()
	
	override func addOperation(_ op: Operation) {

		if let	request	=	op	as?	FirebaseRequest {
			request.store	=	store
		}
		
		super.addOperation(op)
	}
	
	override func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool) {
		
		for op in ops {
			
			if let request	=	op	as?	FirebaseRequest {
				request.store	=	store
			}
		}
		
		super.addOperations(ops, waitUntilFinished: wait)
	}
}

class FirebaseRequest: Request	{

	weak	var	store:	Firestore?
	
	override	var	requestTaskObject: AnyObject?	{
		return store
	}

	static	func request(_ collectionID: String, with completion: @escaping RequstCompletion) -> Request {
	
		return FirebaseRequest.request { (request, object) in
			
			if let store	=	object	as? Firestore {
				
				store.collection(collectionID).getDocuments { (snapshot, error) in

					if let snapshot	=	snapshot, error	==	nil	{

						var list	=	[String]()

						for document in snapshot.documents	{
							list.append(document.documentID)
						}

						request.finish()
						completion(list as AnyObject, nil)
					}
					else {
						completion(nil, error)
					}
				}
			}
		}
	}

}
