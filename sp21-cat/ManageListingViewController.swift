//
//  ManageListingViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/11/21.
//

import UIKit

class ManageListingViewController: UIViewController {
    @IBOutlet weak var deletePic_btn: UIButton!
    @IBOutlet weak var addPic_btn: UIButton!
    
    @IBOutlet weak var cate_label: UILabel!
    @IBOutlet weak var changeCate_btn: UIButton!
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var update_btn: UIButton!
    @IBOutlet weak var delete_btn: UIButton!    
    
    var listing = [String:Any]()
    let cates = ["Fashion", "Electronics", "Furniture", "Toys/Games", "Food", "Books"]
    
    //    { "listing": [ { "categories", "_id", "item_name", "seller_id", "price", "highest_bid", "description", "bids", "__v" }, ... ] }
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Manage"
        self.navigationItem.title = "Manage"
        // Do any additional setup after loading the view.
        cate_label.text = listing["categories"] as? String
        itemName.text = listing["item_name"] as? String
        itemDescription.text = listing["description"] as? String
        itemPrice.text = listing["price"] as? String
    }
    

    @IBAction func deletePic(_ sender: Any) {
    }
    
    @IBAction func addPic(_ sender: Any) {
    }
    
    @IBAction func changeCate(_ sender: Any) {
        // Show the selection list
        let selectedCate = 1;
        cate_label.text = cates[selectedCate]
    }
    
    @IBAction func update(_ sender: Any) {
        
        // Make a PUT request to the API
        
    }
    @IBAction func del(_ sender: Any) {
        // Make a DEL request to the API
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
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
