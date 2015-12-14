//
//  InfinateScrollView.h
//  VerticalScrollView
//
//  Created by fanpyi on 10/12/15.
//  Copyright © 2015 fanpyi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    InfinateHorizontal,
    InfinateVertical
}InfinateScrollDirection;
@protocol InfinateScrollViewDelegate;
@interface InfinateScrollView : UIView
@property (assign,nonatomic) float duration;
@property (assign,nonatomic) InfinateScrollDirection scrollDirection;
@property(weak,nonatomic)id <InfinateScrollViewDelegate>delegate;
-(void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
-(UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forPageIndex:(NSInteger)index;
@end

@protocol InfinateScrollViewDelegate <NSObject>

-(NSInteger)numberOfPageInfinateScrollView:(InfinateScrollView *)infinateScrollView;
-(UICollectionViewCell*)infinateScrollView:(InfinateScrollView *)infinateScrollView cellForItemAtPageIndex:(NSInteger)index;
-(void)infinateScrollView:(InfinateScrollView *)infinateScrollView didSelectAtPageIndex:(NSInteger)index;
@end