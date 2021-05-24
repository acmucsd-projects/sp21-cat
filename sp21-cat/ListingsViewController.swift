//
//  ListingsViewController.swift
//  sp21-cat
//
//  Created by Steven Liu on 5/11/21.
//

import UIKit

class ListingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var listing_CollectionView: UICollectionView!
    
    @IBOutlet weak var total_items: UITextView!
    @IBOutlet weak var add_listing_btn: UIButton!
    @IBOutlet weak var profile_btn: UIButton!
    
    var listings = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listing_CollectionView.dataSource = self
        listing_CollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // # of rows
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listing_cell = UICollectionViewCell()
        
        return listing_cell
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
