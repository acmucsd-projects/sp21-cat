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
            
        num_cateBtns[selected_cate]?.backgroundColor = default_btn_color
        selected_cate = button.tag
        button.backgroundColor = selected_btn_color
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postListing(_ sender: UIButton) {
        // prepare json data
        // "image": { "data": { "type", "data" }, "filename" }
        // "seller_id": { "_id", "name" }
        let image_name = "Teddy Bear Pic"
        _ = UIImage(named: image_name)!.pngData()
        let imageData = ["data": ["type": "PNG",
                                  "data": ""],
                         "filename": "Teddy Bear Pic"] as [String : Any]
        let sellerData = ["_id": "404",
                          "name": "Not Found"]
        
        let parameters: [String: Any] = ["newListing":
                                                        ["categories": [cates[selected_cate]] as [String],
                                                        "_id": "123", // Item id
                                                        "item_name": itemName.text! as String,
                                                        "seller_id": sellerData,
                                                        "price": startingPrice.text! as String,
                                                        "highest_bid": hideBid_switch.isOn,
                                                        "description": item_description.text! as String,
                                                        "bids": [],
                                                        "__v": "",
                                                        "image": imageData] as [String : Any]
                                        ]

        let valid = JSONSerialization.isValidJSONObject(imageData)
        print("Parameter is VALID: \(valid)")
        
        // POST API call
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

        //create the url with URL
        let post_endpoint:String = "http://localhost:3000/listing"
        let url = URL(string: post_endpoint)! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                    // Clear all inputs
                    self.itemName.text = ""
                    self.startingPrice.text = ""
                    self.hideBid_switch.isOn = false
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
            }
            let responseString = String(data: data, encoding: .utf8)
            print(responseString!)
        })
        task.resume()
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
//            let json: [String: Any] = ["categories": [cates[selected_cate]] as [String],
//                                       "_id": "123",
//                                       "item_name": itemName.text! as String,
//                                        "seller_id": "404",
//                                        "price": startingPrice.text! as String,
//                                        "highest_bid": hideBid_switch.isOn,
//                                        "description": item_description.text! as String,
//                                        "bids": [],
//                                        "__v": "1"] as [String : Any]
//
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            //Make API post request
//
//        }
//    }


}
