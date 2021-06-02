//
//  DetailsViewController.h
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/17.
//

//#ifndef DetailsViewController_h
//#define DetailsViewController_h
//
//
//#endif /* DetailsViewController_h */

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property(nonatomic,retain)NSString *receivedImage;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property UIImageView* imgPassedIn;
@property NSString *namePassedIn;
@property NSString *pricePassedIn;

//@property (strong, nonatomic) IBOutlet UILabel *description;



@end
