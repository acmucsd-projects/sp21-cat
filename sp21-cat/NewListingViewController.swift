//
//  NewListingViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/3/21.
//

import UIKit

class NewListingViewController: UIViewController, UITextViewDelegate {

//    @IBOutlet weak var closePage_btn: UIButton!
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var startingPrice: UITextField!
    @IBOutlet weak var hideBid_switch: UISwitch!
    @IBOutlet weak var item_description: UITextView!
        
    @IBOutlet weak var cate0: UIButton!
    @IBOutlet weak var cate1: UIButton!
    @IBOutlet weak var cate2: UIButton!
    @IBOutlet weak var cate3: UIButton!
    @IBOutlet weak var cate4: UIButton!
    @IBOutlet weak var cate5: UIButton!
    
    @IBOutlet weak var photo1_btn: UIButton!
    @IBOutlet weak var photo2_btn: UIButton!
    @IBOutlet weak var photo3_btn: UIButton!
    
    @IBOutlet weak var postListing_btn: UIButton!
    
    let cates: [String] = ["Fashion", "Electronics", "Furniture", "Education", "Food", "Others"]
    var num_cateBtns: [Int:UIButton] = [Int:UIButton]()
    var selected_cate:Int = 5
    let selected_btn_color = UIColor(red: 137.0/255, green: 81.0/255, blue: 255.0/255, alpha: 1)
    let default_btn_color = UIColor(red: 196.0/255, green: 168.0/255, blue: 255.0/255, alpha: 1)
    let description_ph:String = "Tell something about your item!"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        item_description.delegate = self
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add New Listing"
        num_cateBtns = [0: cate0, 1: cate1, 2: cate2, 3: cate3, 4: cate4, 5: cate5]
        for (index, cateBtn) in num_cateBtns {
            cateBtn.layer.cornerRadius = 8;
            cateBtn.layer.borderWidth = 1;
            cateBtn.layer.borderColor = UIColor.black.cgColor
            cateBtn.setTitle(cates[index], for: .normal)
        }
        cate5.backgroundColor = selected_btn_color
        item_description.layer.borderWidth = 1
        item_description.layer.borderColor = UIColor.black.cgColor
        item_description.text = description_ph
        item_description.textColor = UIColor.lightGray
        postListing_btn.layer.borderWidth = 1
        postListing_btn.layer.cornerRadius = 5
        postListing_btn.layer.borderColor = UIColor.black.cgColor
        
        itemName.becomeFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = description_ph
            textView.textColor = UIColor.lightGray
        }
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.destination is ConfirmPostViewController {
////            { "newListing": { "categories", "_id", "item_name", "seller_id", "price", "highest_bid", "description", "bids", "__v" } }
//
//            // prepare json data
//            let json: [String: Any] = ["categories": cates[selected_cate] as String,
//                                       "_id": "",
//                                       "item_name": itemName.text! as String,
//                                        "seller_id": "",
//                                        "price": startingPrice.text! as String,
//                                        "highest_bid": hideBid_switch.isOn,
//                                        "description": item_description.text! as String,
//                                        "bids": [],
//                                        "__v": ""] as [String : Any]
//
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            //Make API post request
//
//        }
//    }


}
