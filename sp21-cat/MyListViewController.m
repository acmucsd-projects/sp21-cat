//
//  MyListViewController.m
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/17.
//

#import <Foundation/Foundation.h>
#import "MyListViewController.h"

@interface MyListViewController (){
    NSArray *imgArr;
    NSArray *nameArr;
    NSArray *priceArr;
}

@end

@implementation MyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    imgArr = [[NSArray alloc] initWithObjects:@"Fake Plant Pots Pic", @"iphone 11 Pic", @"Fall Outfit Bundle Pic", @"Teddy Bear Pic",@"Fake Plant Pots Pic", @"iphone 11 Pic", @"Fall Outfit Bundle Pic", @"Teddy Bear Pic", nil];
    nameArr = [[NSArray alloc] initWithObjects:@"Fake Plant Pots", @"iphone 11", @"Fall Outfit Bundle", @"Teddy Bear",@"Fake Plant Pots", @"iphone 11", @"Fall Outfit Bundle", @"Teddy Bear", nil];
    priceArr = [[NSArray alloc] initWithObjects:@"$12.00", @"$250.00", @"$36.00", @"$4.00",@"$12.00", @"$250.00", @"$36.00", @"$4.00", nil];
    _totalItems.text = [NSString stringWithFormat:@"Total: %lu items", (unsigned long)imgArr.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(140, 177);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imgArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:102];

    imgView.image = [UIImage imageNamed:[imgArr objectAtIndex:indexPath.row]];
    nameLabel.text = [nameArr objectAtIndex:indexPath.row];
    priceLabel.text = [priceArr objectAtIndex:indexPath.row];

    cell.backgroundColor = UIColor.whiteColor;
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
