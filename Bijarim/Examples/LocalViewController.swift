//
//  LocalViewController.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

final	class LocalViewController: UIViewController {
	
	var data:	LocalIdentiferList!
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {

		super.viewDidLoad()

		let	request1	=	Request.request { (req, _) in

			if	let path	=	Bundle.main.path(forResource: "Info", ofType: "plist"), let info	=	NSDictionary(contentsOfFile: path)	{
				self.data	=	LocalIdentiferList(info.allKeys)
			}
			
			req.finish()
		}
		let	request2	=	Request.request { (req, _) in

			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
			req.finish()
		}

		let	queue		=	SerializeQueue(self)

		queue.addOperation(request1)
		queue.addOperation(request2)
	}
}

extension	LocalViewController:	UITableViewDataSource	{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		guard let data = self.data else { return 0 }
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		cell.textLabel?.text	=	self.data?[indexPath.row]?.identifier

		return cell
	}
}

extension	LocalViewController:	UITableViewDelegate		{	}

extension	LocalViewController:	RequestQueueStream		{
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {}
}



class LocalIdentifier: Meta {
	
	override var descriptors: [Descriptor]	{
		return	[
			Descriptor(from: "", to: "identifier")
		]
	}
}

class LocalIdentiferList: MetaList	<LocalIdentifier> {
	
	override var classOfItemMeta: Meta.Type	{
		return	LocalIdentifier.self
	}
}
