//
//  TableViewRequestLoader.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/10.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

public	class TableViewSection: RequestSection {
	
	func numberOfRows(_ tableView: UITableView) -> Int {
		return 0
	}
	
	func invalidateCell(_ tableView: UITableView, at indexPath:	IndexPath)	->	UITableViewCell{
		return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
	}
}

public	class TableViewRequestLoader: RequestLoader {

	public	var tableView: UITableView!
	
	public	override	subscript(position: Int)	->	TableViewSection? {
		guard let section	=	activeSections[position]	as?	TableViewSection	else	{	return	nil	}
		return section
	}
}

extension	TableViewRequestLoader:	UITableViewDataSource	{
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard	let	section	=	self[section]	else	{	return 0	}
		return section.numberOfRows(tableView)
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard	let	section	=	self[indexPath.row]	else	{	return UITableViewCell()	}
		return section.invalidateCell(tableView, at: indexPath)
	}
}

extension	TableViewRequestLoader:	UITableViewDelegate	{
	
}



class	TableViewController:	UIViewController {
	
	@IBOutlet	var	dataLoader:	TableViewRequestLoader!
	
	@IBOutlet	weak	var	tableView:	UITableView!

	var forceProtocolToLoader	=	true	{
		
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		forceProtocolToLoader	=	true
		dataLoader.validateActiveSections()
		dataLoader.startRequests()
	}
	
}

