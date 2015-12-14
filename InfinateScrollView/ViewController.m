//
//  ViewController.m
//  InfinateScrollView
//
//  Created by fanpyi on 14/12/15.
//  Copyright © 2015 fanpyi. All rights reserved.
//

#import "ViewController.h"
#import "InfinateScrollView.h"
#import "InfinateCollectionCell.h"
static NSString *const InfinateViewCellIdentifier = @"InfinateViewCellIdentifier";
@interface ViewController ()<InfinateScrollViewDelegate>

@property (weak, nonatomic) IBOutlet InfinateScrollView *horizontalScrollView;
@property (weak, nonatomic) IBOutlet InfinateScrollView *verticalScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.horizontalScrollView.duration = 3.0;
    self.horizontalScrollView.delegate = self;
    self.horizontalScrollView.scrollDirection = InfinateHorizontal;
    [self.horizontalScrollView registerNib:[UINib nibWithNibName:@"InfinateCollectionCell" bundle:nil] forCellWithReuseIdentifier:InfinateViewCellIdentifier];
    
    self.verticalScrollView.duration = 4.0;
    self.verticalScrollView.delegate = self;
    self.verticalScrollView.scrollDirection = InfinateVertical;
    [self.verticalScrollView registerNib:[UINib nibWithNibName:@"InfinateCollectionCell" bundle:nil] forCellWithReuseIdentifier:InfinateViewCellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfPageInfinateScrollView:(InfinateScrollView *)infinateScrollView{
    return infinateScrollView == self.horizontalScrollView ? 5:10;
}
-(UICollectionViewCell*)infinateScrollView:(InfinateScrollView *)infinateScrollView cellForItemAtPageIndex:(NSInteger)index{
    if (infinateScrollView == self.horizontalScrollView) {
        InfinateCollectionCell *cell = (InfinateCollectionCell *)[self.horizontalScrollView dequeueReusableCellWithReuseIdentifier:InfinateViewCellIdentifier forPageIndex:index];
        cell.label.text = [NSString stringWithFormat:@"左右轮播图%ld,定时%.1f秒切换自动切换",index,self.horizontalScrollView.duration];
        return cell;
    }else{
        InfinateCollectionCell *cell = (InfinateCollectionCell *)[self.verticalScrollView dequeueReusableCellWithReuseIdentifier:InfinateViewCellIdentifier forPageIndex:index];
        cell.label.text = [NSString stringWithFormat:@"上下轮播图%ld,定时%.1f秒切换自动切换",index,self.verticalScrollView.duration];
        return cell;
    }
   
}
-(void)infinateScrollView:(InfinateScrollView *)infinateScrollView didSelectAtPageIndex:(NSInteger)index{
    NSLog(@"didSelectAtPageIndex = %ld",index);
}

@end
