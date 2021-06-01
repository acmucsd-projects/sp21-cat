//
//  ShopViewController.m
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/16.

#import "ShopViewController.h"
#import "DetailsViewController.h"

@interface ShopViewController (){
    NSArray *imgArr;
    NSArray *nameArr;
    NSArray *priceArr;
    
    BOOL isFiltered;
    NSMutableArray *filteredImgs;
    NSMutableArray *filteredNames;
    NSMutableArray *filteredPrices;
    
//    NSData* responseData;
}

@end

@implementation ShopViewController
//@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    isFiltered = false;
    self.searchBar.delegate = self;
    imgArr = [[NSArray alloc] initWithObjects:@"Fake Plant Pots Pic", @"iphone 11 Pic", @"Fall Outfit Bundle Pic", @"Teddy Bear Pic",@"Fake Plant Pots Pic", @"iphone 11 Pic", @"Fall Outfit Bundle Pic", @"Teddy Bear Pic", nil];
    nameArr = [[NSArray alloc] initWithObjects:@"Fake Plant Pots", @"iphone 11", @"Fall Outfit Bundle", @"Teddy Bear",@"Fake Plant Pots", @"iphone 11", @"Fall Outfit Bundle", @"Teddy Bear", nil];
    priceArr = [[NSArray alloc] initWithObjects:@"$12.00", @"$250.00", @"$36.00", @"$4.00",@"$12.00", @"$250.00", @"$36.00", @"$4.00", nil];
    
//    responseData = [NSMutableData new];
//    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/listing"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//
//    [request setHTTPMethod:@"GET"];
//    NSURLSession *session = [NSURLSession sharedSession];
    
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
//    [connection release];
//    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"the html from google was %@", responseString);
//    [responseString release];
//}
//
//- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    [responseData setLength:0];
//}
//
//- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//  [responseData appendData:data];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(140, 177);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        isFiltered = false;
    } else {
        isFiltered = true;
        filteredImgs = [[NSMutableArray alloc] init];
        filteredNames = [[NSMutableArray alloc] init];
        filteredPrices = [[NSMutableArray alloc] init];
        
        int i;
        for (i = 0; i < nameArr.count; i++) {
            NSString *name = [nameArr objectAtIndex:i];
            NSRange nameRange = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound){
                [filteredImgs addObject:[imgArr objectAtIndex:i]];
                [filteredNames addObject:[nameArr objectAtIndex:i]];
                [filteredPrices addObject:[priceArr objectAtIndex:i]];
            }
        }
    }
    [self.shopCollection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(isFiltered){
        return filteredNames.count;
    }
    return imgArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:102];

    if(isFiltered){
        imgView.image = [UIImage imageNamed:[filteredImgs objectAtIndex:indexPath.row]];
        nameLabel.text = [filteredNames objectAtIndex:indexPath.row];
        priceLabel.text = [filteredPrices objectAtIndex:indexPath.row];
    } else {
        imgView.image = [UIImage imageNamed:[imgArr objectAtIndex:indexPath.row]];
        nameLabel.text = [nameArr objectAtIndex:indexPath.row];
        priceLabel.text = [priceArr objectAtIndex:indexPath.row];
    }

    cell.backgroundColor = UIColor.whiteColor;
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *details  = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    [self.navigationController pushViewController:details animated:NO];
    details.imgPassedIn.image = [UIImage imageNamed:[filteredImgs objectAtIndex:indexPath.row]];
    details.namePassedIn = [nameArr objectAtIndex:indexPath.row];
    details.pricePassedIn = [priceArr objectAtIndex:indexPath.row];
}

@end
