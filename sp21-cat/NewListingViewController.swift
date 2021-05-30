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
    @IBOutlet weak var item_description: UITextView!
    
    @IBOutlet weak var photo1_btn: UIButton!
    @IBOutlet weak var photo2_btn: UIButton!
    @IBOutlet weak var photo3_btn: UIButton!
    
    @IBOutlet weak var cate0: UIButton!
    @IBOutlet weak var cate1: UIButton!
    @IBOutlet weak var cate2: UIButton!
    @IBOutlet weak var cate3: UIButton!
    @IBOutlet weak var cate4: UIButton!
    @IBOutlet weak var cate5: UIButton!
    
    @IBOutlet weak var postListing_btn: UIButton!
    
    let cates: [String] = ["Fashion", "Electronics", "Furniture", "Toys/Games", "Food", "Others"]
    var num_cateBtns: [Int:UIButton] = [Int:UIButton]()
    var selected_cate:Int = 5
    let selected_btn_color = UIColor(red: 137.0/255, green: 81.0/255, blue: 255.0/255, alpha: 1)
    let default_btn_color = UIColor(red: 196.0/255, green: 168.0/255, blue: 255.0/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add New Listing"
        num_cateBtns = [0: cate0, 1: cate1, 2: cate2, 3: cate3, 4: cate4, 5: cate5]
        // Do any additional setup after loading the view.
        cate5.backgroundColor = selected_btn_color
        cate5.layer.cornerRadius = 20;
        item_description.layer.borderWidth = 1
        item_description.layer.borderColor = UIColor.black.cgColor;
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    }
    
    @IBAction func changeCate(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
//        switch button.tag {
//            case 0:
//                selected_cate = 0
//            case 1:
//                selected_cate = 1
//            case 2:
//                selected_cate = 2
//            case 3:
//                selected_cate = 3
//            case 4:
//                selected_cate = 4
//            case 5:
//                selected_cate = 5
//            default:
//                print("Unknown cate selection")
//                return
//        }
        
        num_cateBtns[selected_cate]?.backgroundColor = default_btn_color
        selected_cate = button.tag
        button.backgroundColor = selected_btn_color
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is ConfirmPostViewController {
//            { "newListing": { "categories", "_id", "item_name", "seller_id", "price", "highest_bid", "description", "bids", "__v" } }
            
            // prepare json data
            let json: [String: Any] = ["categories": cates[selected_cate] as String,
                                       "_id": "",
                                       "item_name": itemName.text! as String,
                                        "seller_id": "",
                                        "price": startingPrice.text! as String,
                                        "highest_bid": hideBid_switch.isOn,
                                        "description": item_description.text! as String,
                                        "bids": [],
                                        "__v": ""] as [String : Any]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            //Make API post request
           
        }
    }


}
