//
//  MKScrollCircleViewController.m
//  MKCollectionCircleView
//
//  Created by moyekong on 1/4/16.
//  Copyright © 2016 wiwide. All rights reserved.
//

#import "MKScrollCircleViewController.h"
#import "MKScrollCircleView.h"

@interface MKScrollCircleViewController ()<MKScrollCircleViewDelegate>

@property (nonatomic, strong) MKScrollCircleView *scrollCircleView;

@end

@implementation MKScrollCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.scrollCircleView = [[MKScrollCircleView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200.0)];
    self.scrollCircleView.delegate = self;
    [self.view addSubview:self.scrollCircleView];
    
    self.scrollCircleView.dataArray = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scrollCircleView addTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scrollCircleView removeTimer];
}

- (void)dealloc {
    [self.scrollCircleView removeTimer];
}

#pragma mark - scrollCircleViewDelegate
- (void)mkScrollCircleViewSelectImageAtIndex:(NSInteger)index {
    NSLog(@"select Index: %ld", index);
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
