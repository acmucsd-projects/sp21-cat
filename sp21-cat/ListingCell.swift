//
//  ListingCell.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/18/21.
//

import UIKit
protocol OptionButtonsDelegate{
    func closeFriendsTapped(at index:IndexPath)
}

class ListingCell: UICollectionViewCell {
    @IBOutlet weak var item_img: UIImageView!
    @IBOutlet weak var item_name: UILabel!
    @IBOutlet weak var item_price: UILabel!
    
    @IBOutlet weak var manage_btn: UIButton!
    @IBOutlet weak var viewBuyers_btn: UIButton!
    
//    var delegate: OptionButtonsDelegate!
//    var indexPath: IndexPath!
}
