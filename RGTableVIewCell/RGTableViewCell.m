//
//  RGTableViewCell.m
//  RGTableVIewCell
//
//  Created by ROBERA GELETA on 12/26/14.
//  Copyright (c) 2014 ROBERA GELETA. All rights reserved.
//

#import "RGTableViewCell.h"

@implementation RGTableViewCell
{
    UIPanGestureRecognizer *panGestureRecognizer;
    UIView *firstView;
    UIView *secondView;
    UIView *thirdView;
    
    //parameters for the cell
    CGSize cellContainerViewSize;
    NSInteger pannedDistance;
}
- (void)awakeFromNib {
    // Initialization code
    [self addPanGestureRecognizer];
    [self setUpSubViews];
    [self deduceCellGeoProperties];
}


//----setting up gesture recognizer
- (void)addPanGestureRecognizer
{
    panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panning:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

//----setting up the views and adding them
- (void)setUpSubViews
{
    //--- inital panned distance = 0 (because the user hasn't panned yet)
    pannedDistance = 0;
    
    firstView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, pannedDistance, cellContainerViewSize.height)];
    secondView = [[UIView alloc]initWithFrame:CGRectMake(pannedDistance, 0, pannedDistance, cellContainerViewSize.height)];
    thirdView = [[UIView alloc]initWithFrame:CGRectMake(2 * pannedDistance, 0, pannedDistance, cellContainerViewSize.height)];
    
    [self.contentView addSubview:firstView];
    [self.contentView addSubview:secondView];
    [self.contentView addSubview:thirdView];
}


//-----deducing the cell's geometrical properities
- (void)deduceCellGeoProperties
{
    cellContainerViewSize = self.contentView.bounds.size;
}


//----- method to recomute the frames of the boxes based on the panned distance
- (void)layoutSubviews
{
    [super layoutSubviews];//    NSLog(@"%d",pannedDistance);

    firstView.frame = CGRectMake(0, 0, pannedDistance, cellContainerViewSize.height);
    firstView.backgroundColor = [UIColor redColor];
    secondView.frame = CGRectMake(pannedDistance, 0, pannedDistance, cellContainerViewSize.height);
    secondView.backgroundColor = [UIColor blueColor];
    thirdView.frame = CGRectMake(2 * pannedDistance, 0, pannedDistance, cellContainerViewSize.height);
    thirdView.backgroundColor = [UIColor greenColor];
    NSLog(@"%@",NSStringFromCGRect((firstView.frame)));
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Handling Panning
- (void)panning:(UIPanGestureRecognizer *)sender
{
    if( [sender translationInView:self.contentView].x > 0 )
    {
        pannedDistance = [sender translationInView:self.contentView].x;
    };
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        [self setNeedsLayout];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
         [self setNeedsLayout];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
         [self setNeedsLayout];
    }
}
@end
