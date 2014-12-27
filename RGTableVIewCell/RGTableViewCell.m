//
//  RGTableViewCell.m
//  RGTableVIewCell
//
//  Created by ROBERA GELETA on 12/26/14.
//  Copyright (c) 2014 ROBERA GELETA. All rights reserved.
//

#define CELL_BLUE [UIColor colorWithRed:70.0/255.0 green:99/255.0 blue:127.0/255.0 alpha:1]
#define BURNT_ORANGE [UIColor colorWithRed:211.0/255.0 green:84/255.0 blue:0.0/255.0 alpha:1]
#define GREEN  [UIColor colorWithRed:120/255.0f green:212/255.0f blue:140/255.0f alpha:1.0f]
#define MARRON [UIColor colorWithRed:127/255.0f green:70/255.0f blue:77/255.0f alpha:1.0f]
#define PUMPKIN [UIColor colorWithRed:211/255.0f green:84/255.0f blue:0/255.0f alpha:1.0f]
#define CLOUD [UIColor colorWithRed:236/255.0f green:240/255.0f blue:241/255.0f alpha:1.0f]
#define SILVER [UIColor colorWithRed:189/255.0f green:195/255.0f blue:199/255.0f alpha:1.0f]
#define ALIZARIN [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0f]
#define POMEGRANATE [UIColor colorWithRed:192/255.0f green:57/255.0f blue:43/255.0f alpha:1.0f]

#import "RGTableViewCell.h"

@implementation RGTableViewCell
{
    
    UIPanGestureRecognizer *panGestureRecognizer;
    //views/labels
    UIView *firstView;
    UIView *secondView;
    UIView *thirdView;
    UIView *rgContentView;
    
    UILabel *firstLabel;
    UILabel *secondLabel;
    UILabel *thirdLabel;
    
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

    //setting up labels
    firstLabel = [[UILabel alloc]initWithFrame:[self containedBox]];
    firstLabel.text = @"Archive";
    [firstView addSubview:firstLabel];
    
    secondLabel = [[UILabel alloc]initWithFrame:[self containedBox]];
    secondLabel.text = @"Flag";
    [secondView addSubview:secondLabel];
    
    thirdLabel = [[UILabel alloc]initWithFrame:[self containedBox]];
    thirdLabel.text = @"More";
    [thirdView addSubview:thirdLabel];
    
    
    
    firstView.backgroundColor = GREEN;
    secondView.backgroundColor = POMEGRANATE;
    thirdView.backgroundColor = CELL_BLUE;

    [self.contentView addSubview:firstView];
    [self.contentView addSubview:secondView];
    [self.contentView addSubview:thirdView];
    
    
    //----setti ng up subviews
    UITapGestureRecognizer *firstTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstTap)];
    [firstView addGestureRecognizer:firstTapGesture];
    
    UITapGestureRecognizer *secondTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondTap)];
    [secondView addGestureRecognizer:secondTapGesture];
    
    UITapGestureRecognizer *thirdTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdTap)];
    [thirdView addGestureRecognizer:thirdTapGesture];
    
    
    //---------The 'Real' Content View for this cell
    rgContentView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    rgContentView.backgroundColor = CLOUD;
    [self.contentView addSubview:rgContentView];
    
}

#pragma mark - Tapped 
- (void)firstTap
{
    if(_delegate && [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
    {
        [_delegate cellTapped:self withIndex:0];
    }
    [self animateToTheLeft];
}

- (void)secondTap
{
    if(_delegate && [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
    {
        [_delegate cellTapped:self withIndex:1];
    }
    [self animateToTheLeft];
}

- (void)thirdTap
{
    if(_delegate && [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
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
    secondView.frame = CGRectMake(pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    thirdView.frame = CGRectMake(2 * pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    rgContentView.frame = CGRectMake(3 * pannedDistance, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    
}

//----setting the texts of the labels for the 3 views
- (void)setTitles:(NSArray *)listOfTitles
{
    
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
    rgContentView.frame = CGRectMake(0, 0,self.contentView.bounds.size.width, self.contentView.bounds.size.height);
}

//
- (void)setViewsToCenter
{
    pannedDistance = self.contentView.bounds.size.width / 4 ;
    firstView.frame = CGRectMake(0, 0, pannedDistance, self.contentView.bounds.size.height);
    secondView.frame = CGRectMake(pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    thirdView.frame = CGRectMake(2 * pannedDistance, 0, pannedDistance, self.contentView.bounds.size.height);
    rgContentView.frame = CGRectMake(3 * pannedDistance, 0,self.contentView.bounds.size.width, self.contentView.bounds.size.height);
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


- (CGRect)containedBox
{
    NSInteger boxWidth = self.contentView.bounds.size.width ;
    NSInteger boxHeight = self.contentView.bounds.size.height ;
    
    NSInteger smallerWidth = boxWidth / 8;
    NSInteger smallerHeight = boxHeight / 3 ;

    return CGRectMake(smallerWidth/4, smallerHeight, boxWidth /2 , boxHeight);
    
    
}



@end
