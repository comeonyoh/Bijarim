//
//  FirebaseViewController.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit
import Firebase

class FirebaseViewController: UIViewController, RequestQueueStream {

	enum Section: Int {
		case address
		case document
	}

	var addressSamples:			MetaList<Meta>?
	var documentIdentifiers:	MetaList<Meta>?

	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
		
        super.viewDidLoad()

        let	queue		=	FirebaseRequestQueue(self)
		
		let	request1	=	FirebaseRequest.requestDocuments({ (store) -> (Bool, [FirebasePathItem]) in

			return (true, [FirebasePathItem(path: "address_samples", pathType: .collection)])

		}) { (response) in

			if let metaResponse	=	response	as?	MetaResponse	{
				self.addressSamples	=	metaResponse.list
			}
		}
		
		let	request2		=	FirebaseRequest()

		request2.task		=	{	(request, object) in
			
			if	let	firebase	=	request	as?	FirebaseRequest,	let	store	=	firebase.store	{
				
				let	path		=	[FirebasePathItem(path: "example_accounts", pathType: .collection)]
				
				FirebaseRequest.convertFirebasePathItemToActiveCollectionReference(store, path: path)?.getDocuments(completion: { (snapshot, error) in
			
					if let snapshot	=	snapshot, error	==	nil	{

						var list	=	[String]()
						
						for document in snapshot.documents	{
							list.append(document.documentID)
						}
						
						request.completion?(MetaResponse(.success, list, descriptor: DocumentListDescriptor()))
						request.finish()
					}
					
					else {
						request.finish()
					}
				})
			}
		}
		
		request2.completion	=	{	response in
			
			if let metaResponse	=	response	as?	MetaResponse	{
				self.documentIdentifiers	=	metaResponse.list
			}
		}
		
		queue.addOperation(request1)
		queue.addOperation(request2)
    }
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {

		if	spare?.count	==	0	{
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}

extension	FirebaseViewController:	UITableViewDataSource	{

	func numberOfSections(in tableView: UITableView) -> Int {
		
		var count	=	0
		
		if	let	address	=	addressSamples	{
			count	=	count	+	address.count
		}
		
		if	let	documents	=	documentIdentifiers	{
			count	=	count	+	documents.count
		}
		
		return count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		switch section {
			
		case Section.address.rawValue:
			guard let addresses = addressSamples else { return 0 }
			return addresses.count
			
		case Section.document.rawValue:
			guard let identifers = documentIdentifiers else { return 0 }
			return identifers.count
			
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let	cell	=	tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		switch indexPath.section {
			
		case Section.address.rawValue:
			cell.textLabel?.text	=	addressSamples?[indexPath.row]?.identifier
			
		case Section.document.rawValue:
			cell.textLabel?.text	=	documentIdentifiers?[indexPath.row]?.identifier

		default:
			break
		}
		
		return cell
	}
}

extension	FirebaseViewController:	UITableViewDelegate		{	}

