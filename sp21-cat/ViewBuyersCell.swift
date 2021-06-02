//
//  ViewBuyersCell.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/29/21.
//

import UIKit

class ViewBuyersCell: UITableViewCell {

    @IBOutlet weak var itemBuyer_label: UILabel!
    @IBOutlet weak var itemBid_label: UILabel!
    @IBOutlet weak var approve_btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
