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
    NSInteger pannedDistance;
    
    //+ means the last move was to the right and negative means left means
    NSInteger lastMovement;
}
- (void)awakeFromNib {
    // Initialization code
    [self addPanGestureRecognizer];
    

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
         [self setUpSubViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self =  [super initWithCoder:aDecoder];
    if(self)
    {
        [self setUpSubViews];
    }
    return self;
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
    
    firstView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, pannedDistance, self.contentView.bounds.size.height)];
    secondView = [[UIView alloc]initWithFrame:CGRectMake(pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height)];
    thirdView = [[UIView alloc]initWithFrame:CGRectMake(2 * pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height)];
    
    [self.contentView addSubview:firstView];
    [self.contentView addSubview:secondView];
    [self.contentView addSubview:thirdView];
    
    
    //----setting up subviews
    UITapGestureRecognizer *firstTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstTap)];
    [firstView addGestureRecognizer:firstTapGesture];
    
    UITapGestureRecognizer *secondTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondTap)];
    [secondView addGestureRecognizer:secondTapGesture];
    
    UITapGestureRecognizer *thirdTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdTap)];
    [thirdView addGestureRecognizer:thirdTapGesture];
}

#pragma mark - Tapped 
- (void)firstTap
{
    if(_delegate || [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
    {
        [_delegate cellTapped:self withIndex:0];
    }
    [self animateToTheLeft];
}

- (void)secondTap
{
    if(_delegate || [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
    {
        [_delegate cellTapped:self withIndex:1];
    }
    [self animateToTheLeft];
}

- (void)thirdTap
{
    if(_delegate || [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
    {
        [_delegate cellTapped:self withIndex:2];
    }
     [self animateToTheLeft];
}

//----- method to recomute the frames of the boxes based on the panned distance
- (void)layoutSubviews
{
    [super layoutSubviews];//    NSLog(@"%d",pannedDistance);

    firstView.frame = CGRectMake(0, 0, pannedDistance, self.contentView.bounds.size.height);
    firstView.backgroundColor = [UIColor redColor];
    secondView.frame = CGRectMake(pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    secondView.backgroundColor = [UIColor blueColor];
    thirdView.frame = CGRectMake(2 * pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    thirdView.backgroundColor = [UIColor greenColor];
    
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
        pannedDistance += ([sender translationInView:self.contentView].x / 3);
        [self setNeedsLayout];
    }
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged )
    {
        
        pannedDistance += ([sender translationInView:self.contentView].x / 3);//do what the user expects regardless of the swipe direction
        lastMovement = ([sender translationInView:self.contentView].x );
        [self setNeedsLayout];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSInteger seventyFiveWidthOfCell = (3 * self.contentView.bounds.size.width) / 4;
        NSInteger rightMostPoint = thirdView.bounds.size.width + thirdView.frame.origin.x;
        if (rightMostPoint > seventyFiveWidthOfCell )
        {
            [self animateToTheCenter];
        }
        else
        {
            [self animateToTheLeft];
        }
    }
    [sender setTranslation:CGPointZero inView:self.contentView];
}


#pragma mark - Convnience Methods
//moves all the views to the far left
- (void)setViewsToTheLeft
{
    pannedDistance = 0 ;
    firstView.frame = CGRectMake(0, 0, pannedDistance, self.contentView.bounds.size.height);
    secondView.frame = CGRectMake(pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    thirdView.frame = CGRectMake(2 * pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
}

//
- (void)setViewsToCenter
{
    pannedDistance = self.contentView.bounds.size.width / 4 ;
    firstView.frame = CGRectMake(0, 0, pannedDistance, self.contentView.bounds.size.height);
    secondView.frame = CGRectMake(pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    thirdView.frame = CGRectMake(2 * pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
}

- (void)animateToTheLeft
{
    [UIView animateWithDuration:.4
                     animations:^{
                         [UIView animateWithDuration:.4
                                          animations:^{
                                              [self setViewsToTheLeft];
                                          }];
                     } completion:^(BOOL finished) {
                         [self setNeedsLayout];
                     }];

}

- (void)animateToTheCenter
{
    [UIView animateWithDuration:.4
                     animations:^{
                         [UIView animateWithDuration:.4
                                          animations:^{
                                              [self setViewsToCenter];
                                          }];
                     } completion:^(BOOL finished) {
                         [self setNeedsLayout];
                     }];
}



@end
