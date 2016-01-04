//
//  CollectionCircleViewController.m
//  MKCollectionCircleView
//
//  Created by moyekong on 12/31/15.
//  Copyright © 2015 wiwide. All rights reserved.
//

#import "CollectionCircleViewController.h"
#import "MKCollectionCircleView.h"

@interface CollectionCircleViewController ()

@property (nonatomic, strong) MKCollectionCircleView *collectionCircleView;

@end

@implementation CollectionCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.collectionCircleView = [[MKCollectionCircleView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200.0)];
    [self.view addSubview:self.collectionCircleView];
    
    self.collectionCircleView.dataArray = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
