//
//  InfinateScrollView.m
//  VerticalScrollView
//
//  Created by fanpyi on 10/12/15.
//  Copyright © 2015 fanpyi. All rights reserved.
//

#import "InfinateScrollView.h"
#import "InfinateCollectionCell.h"

@interface InfinateScrollView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end
@implementation InfinateScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupCollectionView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
        [self setupCollectionView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView setFrame:self.bounds];
    self.flowLayout.itemSize = self.bounds.size;
}
-(void)initialization{
    self.backgroundColor =[UIColor orangeColor];
    self.duration = 1.0;
    self.scrollDirection = InfinateHorizontal;
}
-(void)setScrollDirection:(InfinateScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    self.flowLayout.scrollDirection = _scrollDirection == InfinateHorizontal ?UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
}
-(void)setupCollectionView{
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = self.frame.size;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = self.scrollDirection == InfinateHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView= [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
}
-(UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forPageIndex:(NSInteger)index{
    return[self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}
-(void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier{
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}
-(void)setDuration:(float)duration{
    _duration = duration;
    [self setupTimer];
}
- (void)setupTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    __weak __typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:weakSelf.duration target:weakSelf selector:@selector(automaticScroll) userInfo:nil repeats:YES];
}
- (void)automaticScroll
{
    CGFloat offset= self.scrollDirection == InfinateHorizontal ? _collectionView.contentOffset.x : _collectionView.contentOffset.y;
    CGFloat dSzie = self.scrollDirection == InfinateHorizontal ? self.frame.size.width :self.frame.size.height;
    int currentIndex = (int)(offset / dSzie + 0.5);
    int targetIndex = currentIndex + 1 ;
    @try {
        NSInteger count = [self.delegate numberOfPageInfinateScrollView:self];
        targetIndex = targetIndex == count ? 0:targetIndex;
        UICollectionViewScrollPosition position = self.scrollDirection == InfinateHorizontal ? UICollectionViewScrollPositionNone : UICollectionViewScrollPositionBottom;
        BOOL animated = targetIndex == 0 ? NO :YES;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:position animated:animated];
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfPageInfinateScrollView:)]) {
       return  [self.delegate numberOfPageInfinateScrollView:self];
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(infinateScrollView:cellForItemAtPageIndex:)]) {
        return [self.delegate infinateScrollView:self cellForItemAtPageIndex:indexPath.row];
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(infinateScrollView:didSelectAtPageIndex:)]) {
        [self.delegate infinateScrollView:self didSelectAtPageIndex:indexPath.row];
    }
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
@end
