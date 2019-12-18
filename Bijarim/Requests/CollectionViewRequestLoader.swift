//
//  CollectionViewRequestLoader.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

public	class CollectionViewSection: RequestSection {
	
	public	class	var	cellIdentifier:	String{
		return	"Cell"
	}
	
	public	func numberOfRows(_ collectionView: UICollectionView) -> Int {
		return self.numberOfItems
	}
	
	public	func invalidateCell(_ collectionView: UICollectionView, at indexPath:	IndexPath)	->	UICollectionViewCell{
		
		return	collectionView.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath)
	}

	public	func layout(_ collectionView: UICollectionView,	layout	collectionViewLayout:	UICollectionViewLayout,	sizeForItemAt	row:	Int) -> CGSize {
		return	.zero
	}
}

public	class CollectionViewRequestLoader: RequestLoader {

	public	weak	var collectionView: UICollectionView!
	
	public	override	subscript(position: Int)	->	CollectionViewSection? {
		guard let section	=	activeSections[position]	as?	CollectionViewSection	else	{	return	nil	}
		return section
	}
	
	override	func operationCountDidChanged(_ spare: [Operation]?, by queue: OperationQueue) {
		
		if	let	spare	=	spare, spare.count	==	0	{
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
}

extension	CollectionViewRequestLoader:	UICollectionViewDataSource	{
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return activeSections.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard	let	section	=	self[section]	else	{	return 0	}
		return section.numberOfRows(collectionView)
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard	let	section	=	self[indexPath.section]	else	{	return UICollectionViewCell()	}
		return section.invalidateCell(collectionView, at: indexPath)
	}
	
}

extension	CollectionViewRequestLoader:	UICollectionViewDelegate	{
	
}

extension	CollectionViewRequestLoader:	UICollectionViewDelegateFlowLayout	{
	
	public	func	collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets					{	return	.zero	}

	public	func	collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat			{	return	5	}

    public	func	collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat	{	return	5	}

	public	func	collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		guard	let	section	=	self[indexPath.section]	else	{	return .zero	}
		return	section.layout(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath.row)
	}
}

public	class	CollectionViewController:	UIViewController {
	
	@IBOutlet	var	dataLoader:	CollectionViewRequestLoader!
	
	@IBOutlet	weak	var	collectionView:	UICollectionView!

	public	var forceProtocolToLoader	=	true	{
		
		didSet	{
			
			if forceProtocolToLoader == true {

				if collectionView.dataSource	===	self	{
					collectionView.dataSource =	dataLoader
				}
				
				if collectionView.delegate	===	self	{
					collectionView.delegate	=	dataLoader
				}
			}
		}
	}
	
	public	override func viewDidLoad() {
		super.viewDidLoad()
		forceProtocolToLoader		=	true
		dataLoader.collectionView	=	collectionView
		dataLoader.validateActiveSections()
		dataLoader.startRequests()
	}
	
}

