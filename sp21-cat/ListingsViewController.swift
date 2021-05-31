//
//  ListingsViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/11/21.
//

import UIKit

class ListingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var total_items: UITextView!
    @IBOutlet weak var add_listing_btn: UIButton!
    @IBOutlet weak var profile_btn: UIButton!
    
    var listings = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
                
        // Do any additional setup after loading the view.
        let url = URL(string: "http://localhost:3000/listing")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
        // This will run when the network request returns
        if let error = error {
            print(error.localizedDescription)
        } else if let data = data {
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            // TODO: Get listings
            self.listings = dataDictionary["listing"] as! [[String:Any]]
            print("Number of listings: \(self.listings.count)")
            
            // TODO: Reload your table view data
            self.collectionView.reloadData()
           }
        }
        task.resume()
        
        total_items.text = "Total: \(self.listings.count) items"
        
        // if no listings at all
        if(self.listings.count == 0) {
            let emptyListingStr:String = "Currently no listings...Add one now"
            let emptyTextPH = UILabel()
            emptyTextPH.text = emptyListingStr
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // # of rows
        return listings.count
    }
    
//    { "listing": [ { "categories", "_id", "item_name", "seller_id", "price", "highest_bid", "description", "bids", "__v" }, ... ] }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let listing = listings[indexPath.item]
        
        cell.manage_btn.tag = indexPath.item
        cell.viewBuyers_btn.tag = indexPath.item
        cell.item_name.text = listing["item_name"] as? String
        cell.item_price.text = listing["price"] as? String
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        let cell = sender as! UICollectionViewCell
//        let indexPath = collectionView.indexPath(for: cell)
        
        if segue.destination is ViewBuyersViewController {
            let btn = sender as! UIButton
            let listing = listings[btn.tag]
            
            let vc = segue.destination as? ViewBuyersViewController
            vc?.listing_id = listing["_id"] as! String
            vc?.itemName = listing["item_name"] as! String
        }else if segue.destination is ManageListingViewController {
            let btn = sender as! UIButton
            let listing = listings[btn.tag]
            
            let vc = segue.destination as? ManageListingViewController
            vc?.listing = listing
        }else if ((segue.destination as? NewListingViewController) != nil) {
            
        }
//        collectionView.deselectItem(at: indexPath!, animated: true)
    }
    

}
