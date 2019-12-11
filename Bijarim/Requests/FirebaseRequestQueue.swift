//
//  FirebaseRequestQueue.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit
import Firebase

enum FirebasePathType {
	case document
	case collection
}

public	struct FirebasePathItem {
	
	var path: String
	var pathType: FirebasePathType
}

public	class FirebaseRequestQueue: SerializeQueue {

	let	store	=	Firestore.firestore()
	
	public	override func addOperation(_ op: Operation) {

		if let	request	=	op	as?	FirebaseRequest {
			request.store	=	store
		}
		
		super.addOperation(op)
	}
	
	public	override func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool) {
		
		for op in ops {
			
			if let request	=	op	as?	FirebaseRequest {
				request.store	=	store
			}
		}
		
		super.addOperations(ops, waitUntilFinished: wait)
	}
}

public	class FirebaseRequest: Request	{

	typealias RequestCondition	=	(_ store: Firestore?)	->	(Bool,	[FirebasePathItem])
	
	public	weak	var	store:	Firestore?
		
	public	var paths:	[FirebasePathItem]?

	public override class var descriptor: Descriptor?	{
		return MetaListDescriptor()
	}
	
	public override		var	canStartTaskAutomatically: Bool	{
		return true
	}
	
	public	override	var	requestTaskObject: AnyObject?	{
		return store
	}
	
	public override		func	requestWillStart() {
		
		guard	let	store	=	store,	let	path	=	paths	else	{	return	}
		
		self.task	=	{	(request, object) in
			
			FirebaseRequest.convertFirebasePathItemToActiveCollectionReference(store, path: path)?.getDocuments(completion: { (snapshot, error) in
				
				if	let	snapshot	=	snapshot,	error	==	nil	{
					var list		=	[Any]()
					
					for document in snapshot.documents	{

						if document.data().count	==	0	{
							list.append(document.documentID)
						}
						else {
							list.append(document.data())
						}
					}
					
					request.finish(MetaResponse(.success, list, descriptor: type(of: self).descriptor as! MetaListDescriptor))
				}
				
				else	if	let	err	=	error{
					request.finish(Response(err))
				}
			})
		}
	}
	
	//	Short cut APIs.
	static	func	requestDocuments(_ desriptor: MetaListDescriptor,	_ condition: @escaping RequestCondition,	with completion: @escaping RequstCompletion) -> Request {

		return	FirebaseRequest.request { (request, object) in

			guard let store	=	object	as?	Firestore	else	{
				return
			}

			if condition(store).0 == true {

				FirebaseRequest.convertFirebasePathItemToActiveCollectionReference(store, path: condition(store).1)?.getDocuments(completion: { (snapshot, error) in

					if let snapshot	=	snapshot, error	==	nil	{

						var list	=	[String]()
						
						for document in snapshot.documents	{
							list.append(document.documentID)
						}

						completion(MetaResponse(.success, list, descriptor: desriptor))
						request.finish()
					}

					else if let	error	=	error	{
						completion(Response(error))
						request.finish()
					}
				})
			}
				
			else {
				request.finish()
			}
		}
	}

}

extension	FirebaseRequest	{

	public	static	func	convertFirebasePathItemToActiveDocumentReference (_ store: Firestore, path items: [FirebasePathItem]) -> DocumentReference? {
		
		var document	:	DocumentReference?		=	nil
		var collection	:	CollectionReference?	=	nil
		matchDocumentAndCollection(&document, collection: &collection, store, path: items)

		return document
	}
	
	public	static	func	convertFirebasePathItemToActiveCollectionReference (_ store: Firestore, path items: [FirebasePathItem]) -> CollectionReference? {
		
		var document	:	DocumentReference?		=	nil
		var collection	:	CollectionReference?	=	nil
		matchDocumentAndCollection(&document, collection: &collection, store, path: items)
		
		return collection
	}


	private	static	func	matchDocumentAndCollection(_ document: inout DocumentReference?, collection: inout CollectionReference?, _ store: Firestore, path items: [FirebasePathItem])	{
		
		for item in items {
			
			if item.pathType	==	.collection	{
				
				if document	==	nil	{
					collection	=	store.collection(item.path)
				}
				else	{
					collection	=	document?.collection(item.path)
				}
			}
				
			else if item.pathType	==	.document	{
				
				if collection	==	nil	{
					document	=	store.document(item.path)
				}
				else	{
					document	=	collection?.document(item.path)
				}
			}
		}
	}
}
