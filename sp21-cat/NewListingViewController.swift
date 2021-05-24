//
//  NewListingViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/3/21.
//

import UIKit

class NewListingViewController: UIViewController {

    @IBOutlet weak var closePage_btn: UIButton!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var startingPrice: UITextField!
    @IBOutlet weak var hideBid_switch: UISwitch!
    @IBOutlet weak var item_descriptions: UITextView!
    @IBOutlet weak var photo1_btn: UIButton!
    @IBOutlet weak var photo2_btn: UIButton!
    @IBOutlet weak var photo3_btn: UIButton!
    @IBOutlet weak var postListing_btn: UIButton!
    
    @IBOutlet weak var cate1: UIButton!
    @IBOutlet weak var cate2: UIButton!
    @IBOutlet weak var cate3: UIButton!
    @IBOutlet weak var cate4: UIButton!
    @IBOutlet weak var cate5: UIButton!
    @IBOutlet weak var cate6: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
