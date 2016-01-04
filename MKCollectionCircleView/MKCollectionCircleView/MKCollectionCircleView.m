//
//  MKCollectionCircleView.m
//  MKCollectionCircleView
//
//  Created by moyekong on 12/31/15.
//  Copyright © 2015 wiwide. All rights reserved.
//

#import "MKCollectionCircleView.h"
#import "MKCollectionViewCircleCell.h"

@interface MKCollectionCircleView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *scheduledTimer;

@end

@implementation MKCollectionCircleView

#define YYMaxSections 100.0

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
    [self setupCollectionView];
    [self setupPageControl];
    [self addTimer];
}

- (void)setupCollectionView {
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self collectionViewFlowLayout]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MKCollectionViewCircleCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MKCollectionViewCircleCell class])];
    
    [self addSubview:self.collectionView];
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    return flowLayout;
}

- (void)setupPageControl {
    if (_pageControl) {
        return;
    }
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 20.0)];
    _pageControl.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height - 20.0);
    _pageControl.numberOfPages = _dataArray.count;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.backgroundColor = [UIColor redColor];
    [self addSubview:_pageControl];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    if (self.collectionView) {
        _pageControl.numberOfPages = _dataArray.count;
        [self.collectionView reloadData];
    }
}

- (void)addTimer {
    _scheduledTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_scheduledTimer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_scheduledTimer invalidate];
    _scheduledTimer = nil;
}

#pragma mark - colletionView dataSource && delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return YYMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MKCollectionViewCircleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MKCollectionViewCircleCell class]) forIndexPath:indexPath];
    NSLog(@"%@", indexPath);
    switch (indexPath.row) {
        case 0:
        {
            cell.displayImageView.backgroundColor = [UIColor orangeColor];
        }
        case 1:
        {
            cell.displayImageView.backgroundColor = [UIColor cyanColor];
        }
            break;
        case 2:
        {
            cell.displayImageView.backgroundColor = [UIColor brownColor];
        }
            break;
        default:
            break;
    }
    cell.displayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.dataArray.count;
    self.pageControl.currentPage = page;
}

#pragma mark - nextPage
- (void)nextPage:(id)sender {
    // 1. 得到当前正在显示的cell的indexPath，（只有一个）
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 2. 得到YYMaxSections/2对应的section的indexPath，显示此indexPath对应的cell
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:YYMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    // 3. 如果当前section的row未显示完全，则row+1，否则section+1，row置为0
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    // 4. 位移显示效果
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
