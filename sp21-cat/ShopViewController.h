//
//  ShopViewController.h
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/16.
//

//#ifndef ShopViewController_h
//#define ShopViewController_h

#import <UIKit/UIKit.h>

@interface ShopViewController : UIViewController  <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, NSURLConnectionDelegate>{
    NSData* responseData;
}
@property (strong, nonatomic) IBOutlet UICollectionView *shopCollection;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (nonatomic, retain) NSData* responseData;


@end

//@interface ShopViewController : UIViewController<UITableViewDataSource,
//UITableViewDelegate>
//{
//
//    IBOutlet UITableView *myTable;
//    NSMutableArray *myArray;
//    NSMutableArray *imagesArray;
//}
//
//@end
//#endif /* ShopViewController_h */
