//
//  ViewController.m
//  MKCollectionCircleView
//
//  Created by moyekong on 12/31/15.
//  Copyright © 2015 wiwide. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCircleViewController.h"
#import "MKScrollCircleViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)gotoCollectionCircleView:(id)sender {
    CollectionCircleViewController *collectionCircleVC = [[CollectionCircleViewController alloc] init];
    [self.navigationController pushViewController:collectionCircleVC animated:YES];
}

- (IBAction)gotoScrollCircleView:(id)sender {
    MKScrollCircleViewController *scrollCircleVC = [[MKScrollCircleViewController alloc] init];
    [self.navigationController pushViewController:scrollCircleVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
