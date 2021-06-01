//
//  DetailsViewController.m
//  sp21-cat
//
//  Created by Emma Yuan on 2021/5/17.
//

#import <Foundation/Foundation.h>
#import "DetailsViewController.h"

@interface DetailsViewController (){
}

@end

@implementation DetailsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    _img = _imgPassedIn;
    _name.text = _namePassedIn;
    _price.text = _pricePassedIn;
}
@end
