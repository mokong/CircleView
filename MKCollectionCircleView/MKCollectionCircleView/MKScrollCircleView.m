//
//  MKScrollCircleView.m
//  MKCollectionCircleView
//
//  Created by moyekong on 1/4/16.
//  Copyright © 2016 wiwide. All rights reserved.
//

#import "MKScrollCircleView.h"

@interface MKScrollCircleView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MKScrollCircleView

static NSInteger kImageTagBeginValue = 550;

#pragma mark - UI
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self setupScrollView];
    [self setupPageControl];
}

- (void)setupScrollView {
    if (self.dataArray) {
        // 图片的宽高和起始坐标
        CGFloat imageW = self.bounds.size.width;
        CGFloat imageH = self.bounds.size.height;
        CGFloat imageY = 0.0;
        
        // 图片数
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:_dataArray];
        [_dataArray insertObject:[tempArray objectAtIndex:tempArray.count-1] atIndex:0];
        [_dataArray addObject:tempArray[0]];
        NSInteger totalCount = _dataArray.count;
        
        // 轮播图
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(totalCount * imageW, 0); // 设置scrollView的滚动范围
        self.scrollView.contentOffset = CGPointMake(imageW, 0); // 设置scrollView的起始位置
        self.scrollView.scrollEnabled = YES;
        self.scrollView.bounces = NO;
        
        for (int i = 0; i < totalCount; i++) {
            UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * imageW, imageY, imageW, imageH)];
            tempImageView.tag = kImageTagBeginValue + i;
            tempImageView.userInteractionEnabled = YES;
            
            switch (i) {
                case 0:
                {
                    tempImageView.backgroundColor = [UIColor orangeColor];
                }
                    break;
                case 1:
                {
                    tempImageView.backgroundColor = [UIColor cyanColor];
                }
                    break;
                case 2:
                {
                    tempImageView.backgroundColor = [UIColor brownColor];
                }
                    break;
                case 3:
                {
                    tempImageView.backgroundColor = [UIColor orangeColor];
                }
                    break;
                case 4:
                {
                    tempImageView.backgroundColor = [UIColor cyanColor];
                }
                    break;
                default:
                    break;
            }
            UITapGestureRecognizer *tapOnImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [tempImageView addGestureRecognizer:tapOnImageView];
            [self.scrollView addSubview:tempImageView];
        }
        
        [self addSubview:self.scrollView];
    }
}

- (void)setupPageControl {
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    CGFloat pageControlH = 25.0;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, viewW, pageControlH)];
    self.pageControl.numberOfPages = _dataArray.count - 2;
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.pageControl];
    self.pageControl.center = CGPointMake(viewW/2.0, viewH-pageControlH/2.0);
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - update data
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self setupSubviews];
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 这个方法不管是timer还是手动滑动，都会走
    CGFloat scrollViewW = scrollView.bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 两种计算page的方式，任选一种即可
//    NSInteger page = floor((offsetX - scrollViewW / 2) / scrollViewW) + 1;
    NSInteger page2 = (int)(offsetX/scrollViewW + 0.5) % self.dataArray.count;
    NSLog(@"-=-==-=-=-%ld", page2);
    self.currentPageIndex = page2;
    self.pageControl.currentPage = page2 - 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 这个方法只有拖拽时会走
    CGFloat scrollViewW = self.bounds.size.width;
    if (self.currentPageIndex == 0) {
        [scrollView setContentOffset:CGPointMake((self.dataArray.count-2)*scrollViewW, 0)];
    } else if (self.currentPageIndex == (self.dataArray.count-1)) {
        [scrollView setContentOffset:CGPointMake(scrollViewW, 0)];
    }
}

#pragma mark - timer事件
- (void)nextImage:(id)sender {
    // 设置滚动
    CGFloat scrollViewW = self.scrollView.bounds.size.width;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    NSInteger page = floor((offsetX-scrollViewW/2)/scrollViewW) + 1;
    self.currentPageIndex = page + 1;
    
    if (self.currentPageIndex > 0 && self.currentPageIndex < self.dataArray.count) {
        // 滚动scrollView
        CGFloat x = self.currentPageIndex * self.scrollView.bounds.size.width;
        [UIView animateWithDuration:0.4 animations:^{
            [self.scrollView setContentOffset:CGPointMake(x, 0)];
        }];
        
        if (self.currentPageIndex == self.dataArray.count - 1) {
            self.currentPageIndex ++;
        }
    }
    
    if (self.currentPageIndex == self.dataArray.count) {
        [_scrollView setContentOffset:CGPointMake(scrollViewW, 0) animated:NO];
    }
    
    if (self.currentPageIndex == 0) {
        [_scrollView setContentOffset:CGPointMake((self.dataArray.count-2)*scrollViewW, 0) animated:NO];
    }
    
}

#pragma mark - 点击事件
- (void)tapImageView:(UITapGestureRecognizer *)sender {
    NSInteger viewTag = sender.view.tag - kImageTagBeginValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mkScrollCircleViewSelectImageAtIndex:)]) {
        [self.delegate mkScrollCircleViewSelectImageAtIndex:viewTag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
