//
//  RGTableViewCell.m
//  RGTableVIewCell
//
//  Created by ROBERA GELETA on 12/26/14.
//  Copyright (c) 2014 ROBERA GELETA. All rights reserved.
//
#define TORTO [UIColor colorWithRed:26/255.0f green:188/255.0f blue:156/255.0f alpha:1.0f]
#define BLUE  [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0f]
#define REDISH [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0f]


#define CLOUD [UIColor colorWithRed:236/255.0f green:240/255.0f blue:241/255.0f alpha:1.0f]

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
    [firstView addSubview:firstLabel];
    
    secondLabel = [[UILabel alloc]initWithFrame:[self containedBox]];
    [secondView addSubview:secondLabel];
    
    thirdLabel = [[UILabel alloc]initWithFrame:[self containedBox]];
    [thirdView addSubview:thirdLabel];

    
    firstView.backgroundColor = TORTO;
    secondView.backgroundColor = REDISH;
    thirdView.backgroundColor = BLUE;

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
    
    
    //---------The 'Real' Content View for this cell
    rgContentView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    rgContentView.backgroundColor = CLOUD;
    [self.contentView addSubview:rgContentView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentTap)];
    [rgContentView addGestureRecognizer:tapGesture];
    
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

- (void)contentTap
{
    if(_delegate && [_delegate respondsToSelector:@selector(cellTapped:withIndex:)])
    {
        [_delegate cellTapped:self withIndex:3];
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
    
    [firstView setNeedsLayout];
    [secondView setNeedsLayout];
    [thirdView setNeedsLayout];
    
}

//----setting the texts of the labels for the 3 views
- (void)setTitles:(NSArray *)listOfTitles
{
    firstLabel.text = listOfTitles[0];
    secondLabel.text = listOfTitles[1];
    thirdLabel.text = listOfTitles[2];
}

- (void)setTitleColor:(UIColor *)color
{
    firstLabel.textColor = color;
    secondLabel.textColor = color;
    thirdLabel.textColor = color;
}
- (void)setBoxColors:(NSArray *)listOfColors
{
    firstLabel.backgroundColor = listOfColors[0];
    secondLabel.backgroundColor = listOfColors[1];
    thirdLabel.backgroundColor = listOfColors[2];
}

- (UIView *)customContentView
{
    return rgContentView;
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
