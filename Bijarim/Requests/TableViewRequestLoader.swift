//
//  TableViewRequestLoader.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/10.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

public	class TableViewSection: RequestSection {
	
	public	func numberOfRows(_ tableView: UITableView) -> Int {
		return self.numberOfItems
	}
	
	public	func invalidateCell(_ tableView: UITableView, at indexPath:	IndexPath)	->	UITableViewCell{
		
		let	cell	=	tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text	=	self[indexPath.row]?.identifier

		return	cell
	}
}

public	class TableViewRequestLoader: RequestLoader {

	public	weak	var tableView: UITableView!
	
	public	override	subscript(position: Int)	->	TableViewSection? {
		guard let section	=	activeSections[position]	as?	TableViewSection	else	{	return	nil	}
		return section
	}
	
	override	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {
		
		if	let	spare	=	spare, spare.count	==	0	{
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}

extension	TableViewRequestLoader:	UITableViewDataSource	{
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		return activeSections.count
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard	let	section	=	self[section]	else	{	return 0	}
		return section.numberOfRows(tableView)
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard	let	section	=	self[indexPath.section]	else	{	return UITableViewCell()	}
		return section.invalidateCell(tableView, at: indexPath)
	}
}

extension	TableViewRequestLoader:	UITableViewDelegate		{
	
}



public	class	TableViewController:	UIViewController {
	
	@IBOutlet	var	dataLoader:	TableViewRequestLoader!
	
	@IBOutlet	weak	var	tableView:	UITableView!

	public	var forceProtocolToLoader	=	true	{
		
		didSet	{
			
			if forceProtocolToLoader == true {

				if tableView.dataSource	===	self	{
					tableView.dataSource =	dataLoader
				}
				
				if tableView.delegate	===	self	{
					tableView.delegate	=	dataLoader
				}
			}
		}
	}
	
	public	override func viewDidLoad() {
		super.viewDidLoad()
		forceProtocolToLoader	=	true
		dataLoader.tableView	=	tableView
		dataLoader.validateActiveSections()
		dataLoader.startRequests()
	}
	
}

