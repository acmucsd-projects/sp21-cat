//
//  ShopViewController.m
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/16.
//

//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import "ShopViewController.h"

@interface ShopViewController ()
@end
@interface UIImageView ()
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     myArray = [[NSMutableArray alloc]initWithObjects:
              @"Item 1",@"Item 2",@"Item 3",
               @"Item 4",@"Item 5",@"Item 6",@"Item 7",
               @"Item 8",@"Item 9",@"Item 10", nil];
    imagesArray = [[NSMutableArray alloc] init];
    [imagesArray addObject:@"image.jpg"];
//    [imagesArray addObject:imageView2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [myArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellId = @"SimpleTableId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *stringForCell= [myArray objectAtIndex:indexPath.row];
//    UIImageView *imgForCell = [imagesArray objectAtIndex:indexPath.row];

    [cell.textLabel setText:stringForCell];
//    [cell.imageView setImage:[imagesArray objectAtIndex:0]];
    cell.imageView.image = [UIImage imageNamed:@"image.jpg"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 50;

    NSString *text = [myArray objectAtIndex:indexPath.row];
//    UIFont *font = [UIFont systemFontOfSize:14];// The font should be the same as that of your textView
    UIFont *font = [UIFont fontWithName:@"Lato" size:16];

    int maxWidth = 100;
    CGSize constraintSize = CGSizeMake(maxWidth, CGFLOAT_MAX);// maxWidth = max width for the textView

    CGSize size = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

    cellHeight += size.height; //you can also add a cell padding if you want some space below textView
    return cellHeight;
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
}

@end
