//
//  ComplexMetaViewController.swift
//  Bijarim
//
//  Created by Clayton Kim on 2019/12/11.
//  Copyright © 2019 ODOV. All rights reserved.
//

import UIKit
import FirebaseUI

public	class	ComplexMetaViewController	:	CollectionViewController {}

public	class	ComplexSection	:	CollectionViewSection {
	
	public	override	var name: String?	{
		set	{}
		get	{
			return "Complex"
		}
	}
	
	public	override	var paths: [FirebasePathItem]?	{
		set {}
		get {
			return [FirebasePathItem(path: "soccer_players", pathType: .collection)]
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

	public	override	func invalidateCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {

		let	cell	=	super.invalidateCell(collectionView, at: indexPath)	as!	ComplexCell
		
		if	let	player	=	self[indexPath.row]	as?	SoccerPlayer	{

			cell.nameLabel.text		=	player.name
			cell.rankLabel.text		=	"\(player.rank.intValue)"

			if	let	path	=	player.imagePath	{
				cell.imageView.sd_setImage(with: Storage.storage().reference(withPath: "sample_images").child(path))
			}
			else	{
				cell.imageView.image	=	nil
			}
		}

		return	cell
	}
	
	public	override	func layout(_ collectionView: UICollectionView,	layout	collectionViewLayout:	UICollectionViewLayout,	sizeForItemAt	row:	Int) -> CGSize {
		let	width	=	collectionView.bounds.size.width	-	collectionView.contentInset.left	-	collectionView.contentInset.right
		return	CGSize(width: width, height: 200)
	}
}



public	class	ComplexCell:	UICollectionViewCell	{
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var rankLabel: UILabel!
	@IBOutlet weak var gradeLabel: UILabel!
}



public	class	UserInfo	:	Meta {
	
	@objc	dynamic	var name: String?
	dynamic	var level:	NSNumber?
	
	public override var descriptors: [Descriptor]	{
		return	[
			StringDescriptor(from: "name", to: "name")	,
			NumberDescriptor(from: "level", to: "level")
		]
	}
}

public	class	UserInfoDescriptor	:	CustomDescriptor	{
	
	public override var metaClass: Meta.Type	{
		return	UserInfo.self
	}
}

public	class	SoccerPlayer	:	Meta,	SortableMeta {
	
	@objc	dynamic	var	rank: NSNumber!
	@objc	dynamic	var name: String!
	@objc	dynamic	var imagePath: String?
	@objc	dynamic	var	info:	UserInfo?

	public override var descriptors: [Descriptor]	{
		return	[
			StringDescriptor(from: "id", to: "identifier")			,
			NumberDescriptor(from: "rank", to: "rank")				,
			StringDescriptor(from: "imagePath", to: "imagePath")	,
			StringDescriptor(from: "name", to: "name")				,
			UserInfoDescriptor(from: "info", to: "info")
		]
	}
	
	var sortKey: Int	{
		return rank.intValue
	}
}

public	class	SoccerPlayerList	<T:	SoccerPlayer>	:	MetaList	<Meta> {
	
	public	override	var	classOfItemMeta: Meta.Type	{
		return	SoccerPlayer.self
	}
	
	public	override	var	sortable:	Bool	{
		return	true
	}

}
