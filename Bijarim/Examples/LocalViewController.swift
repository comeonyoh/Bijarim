//
//  LocalViewController.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

final	class LocalViewController: UIViewController {
	
	var data:	MetaList<Meta>?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {

		super.viewDidLoad()

		let	request1	=	Request.request { (req, _) in

			if	let path	=	Bundle.main.path(forResource: "Info", ofType: "plist"), let info	=	NSDictionary(contentsOfFile: path)	{
				self.data	=	LocalListDescriptor().parseRawData(info.allKeys)
			}
			
			req.finish()
		}
		let	request2	=	Request.request { (req, _) in

			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
			req.finish()
		}
		
		let	queue	=	SerializeQueue(self)

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
		
		if	let	meta	=	self.data?[indexPath.row]	as?	LocalIdentifier	{
			cell.textLabel?.text	=	meta.identifier
		}
		
		return cell
	}
}

extension	LocalViewController:	UITableViewDelegate		{	}

extension	LocalViewController:	RequestQueueStream		{
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {}
}


class LocalIdentifier: Meta {
}

class LocalDescriptor: Descriptor {
	
	override public	class var descriptors: [DescriptorValue]?	{
		return [
			//	"" means the key value from remote is nil.
			DescriptorValue(from: "", to: "identifier")
		]
	}
}

class LocalListDescriptor: MetaListDescriptor {
	
	override var classOfItemMeta: Meta.Type	{
		return LocalIdentifier.self
	}
	
	override class var descriptors: [DescriptorValue]?	{
		return LocalDescriptor.descriptors
	}
}
