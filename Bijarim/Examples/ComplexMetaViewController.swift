//
//  ComplexMetaViewController.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit

public	class	ComplexMetaViewController	:	CollectionViewController {
	
}

public	class	ComplexSection	:	CollectionViewSection {
	
	public	override var name: String?	{
		set	{}
		get	{
			return "Complex"
		}
	}
	
	public	override var paths: [FirebasePathItem]?	{
		set {}
		get {
			return [FirebasePathItem(path: "image_samples", pathType: .collection)]
		}
	}
	
	public	override	var classOfResponse:	MetaList<Meta>.Type?	{
		return	SoccerPlayerList<SoccerPlayer>.self
	}

	/*
		Invalidate	cell's	layout	api	family.
	*/
	public	override	class	var	cellIdentifier:	String{
		return	"ComplexCell"
	}

	public override func invalidateCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {

		let	cell	=	super.invalidateCell(collectionView, at: indexPath)	as!	ComplexCell
		
		if	let	player	=	self[indexPath.row]	as?	SoccerPlayer	{

			cell.nameLabel.text		=	player.name
			cell.rankLabel.text		=	"\(player.rank.intValue)"
			cell.gradeLabel.text	=	player.grade?.name
		}

		return	cell
	}
	
	public	override	func layout(_ collectionView: UICollectionView,	layout	collectionViewLayout:	UICollectionViewLayout,	sizeForItemAt	row:	Int) -> CGSize {
		return	CGSize(width: 100, height: 170)
	}
}

public	class	ComplexCell:	UICollectionViewCell	{
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var rankLabel: UILabel!
	@IBOutlet weak var gradeLabel: UILabel!
}
