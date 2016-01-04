//
//  MKScrollCircleView.h
//  MKCollectionCircleView
//
//  Created by moyekong on 1/4/16.
//  Copyright © 2016 wiwide. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKScrollCircleViewDelegate <NSObject>

- (void)mkScrollCircleViewSelectImageAtIndex:(NSInteger)index;

@end

@interface MKScrollCircleView : UIView

@property (nonatomic, weak) id<MKScrollCircleViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)addTimer; // 添加定时器
- (void)removeTimer; // 移除定时器

@end
