//
//  LocalViewController.swift
//  Bijarim
//
//  Created by JungSu Kim on 2019/11/26.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController {
	
	var data: [String]?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		let	request1	=	Request.request { (req, _) in

			self.data	=	[String]()
			
			if	let path	=	Bundle.main.path(forResource: "Info", ofType: "plist"), let info	=	NSDictionary(contentsOfFile: path)	{
				
				for key in info.allKeys {
					
					if let	string	=	key as? String {
						self.data?.append(string)
					}
				}
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
		cell.textLabel?.text	=	self.data?[indexPath.row]
		
		return cell
	}
}

extension	LocalViewController:	UITableViewDelegate		{
	
}

extension	LocalViewController:	RequestQueueStream		{
	
	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {
	}
}
