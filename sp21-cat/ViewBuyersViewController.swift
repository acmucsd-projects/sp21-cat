//
//  ViewBuyersViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/11/21.
//

import UIKit

class ViewBuyersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var orderByPrice_btn: UIButton!
    @IBOutlet weak var orderByTime_btn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [[String:Any]]()
    var listing_id = ""
    var itemName = ""
    var sortedByPrice = true
    
//    { "bids": [ { "_id", "bidder_id", "listing_id", "bid_amt", "timestamp", "__v" }, ... ] }
    func requestAPI(rawURL:String) {
        let url = URL(string: rawURL)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                self.data = dataDictionary["bids"] as! [[String:Any]]
                
                // TODO: Reload your table view data
                self.tableView.reloadData()
             }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Interested Buyers"
        // Do any additional setup after loading the view.
        
        // By default, sort by PRICE (newest at th top)
        orderByPrice_btn.backgroundColor = UIColor.gray
        orderByTime_btn.backgroundColor = UIColor.white
        sortedByPrice = true
        
        // GET request to API to retrieve all (buyer, bid) in that listing
        requestAPI(rawURL: "http://localhost:3000/bid/price/" + listing_id)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        if (indexPath.row == 0) {
            // do header stuff -> leave it as configured on storyboard
            cell = tableView.dequeueReusableCell(withIdentifier: "NameBidCell", for: indexPath)
//            let indexPath = IndexPath(row: 0, section: 0)
//            cell = tableView.cellForRow(at: indexPath)!
        }else{
            let real_cell = tableView.dequeueReusableCell(withIdentifier: "ViewBuyersCell", for: indexPath) as! ViewBuyersCell
            let item = data[indexPath.row - 1]
            let itemBuyer = item["bidder_id"] as! String
            // HOW TO GET buyer's name???
            let itemBid = item["bid_amt"] as! Float
            
            real_cell.itemBuyer_label.text = itemBuyer
            real_cell.itemBid_label.text = "\(itemBid)"
            cell = real_cell
        }
        return cell
    }
    
    @IBAction func price_tap(_ sender: Any) {
        if(!sortedByPrice) {
            orderByPrice_btn.backgroundColor = UIColor.gray
            orderByTime_btn.backgroundColor = UIColor.white
            sortedByPrice = true
            // GET all bids sorted by price
            requestAPI(rawURL: "http://localhost:3000/bid/price/" + listing_id)
        }
    }
    
    @IBAction func time_tap(_ sender: Any) {
        if(sortedByPrice) {
            orderByPrice_btn.backgroundColor = UIColor.white
            orderByTime_btn.backgroundColor = UIColor.gray
            sortedByPrice = false
            // GET all bids sorted by time
            requestAPI(rawURL: "http://localhost:3000/bid/time/" + listing_id)
        }
    }
    

    @IBAction func backToListings(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        // sender: the cell that gets tapped on
        // Find the selected (buyer, bid)
        let cell = sender as! ViewBuyersCell
        let indexPath = tableView.indexPath(for: cell)
//        let movie = movies[indexPath!.row]
        
        // Pass the selected movie to the details view controller
        let notifViewController = segue.destination as! NotifyBuyerViewController
        notifViewController.buyerName = cell.itemBuyer_label.text!
        notifViewController.itemName = itemName
        
        // Deselect the tableViewCell (animated) after the tap
        tableView.deselectRow(at: indexPath!, animated: true)
    }


}
