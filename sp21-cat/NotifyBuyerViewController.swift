//
//  NotifyBuyerViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/11/21.
//

import UIKit

class NotifyBuyerViewController: UIViewController {

    @IBOutlet weak var approve_label: UILabel!
    @IBOutlet weak var notifSent_label: UILabel!
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var buyerName:String = "Somebody"
    var itemName:String = "someItem"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        approve_label.text = "Approve " + buyerName + "'s bid for \"" + itemName + "\"?"
        notifSent_label.text = "A notification will be sent to " + buyerName + "! Reach out to " + buyerName + " to complete the sale!"
    }
    

    @IBAction func confirmApproval(_ sender: Any) {
        // Notify the buyer???
        
        // Go back to myListings
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
