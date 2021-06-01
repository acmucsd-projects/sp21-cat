//
//  MyListViewController.h
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/17.
//

//#ifndef MyListViewController_h
//#define MyListViewController_h
//
//
//#endif /* MyListViewController_h */

#import <UIKit/UIKit.h>

@interface MyListViewController : UIViewController
{
    IBOutlet UITableView *myTable;
    NSMutableArray *myArray;
    NSMutableArray *imagesArray;

}

@end
