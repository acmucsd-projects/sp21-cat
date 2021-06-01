//
//  ShopViewController.h
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/16.
//

//#ifndef ShopViewController_h
//#define ShopViewController_h

#import <UIKit/UIKit.h>

@interface ShopViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>
{
    
    IBOutlet UITableView *myTable;
    NSMutableArray *myArray;
    NSMutableArray *imagesArray;
}

@end
//#endif /* ShopViewController_h */
