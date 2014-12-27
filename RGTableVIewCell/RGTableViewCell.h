//
//  RGTableViewCell.h
//  RGTableVIewCell
//
//  Created by ROBERA GELETA on 12/26/14.
//  Copyright (c) 2014 ROBERA GELETA. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RGTableViewCell : UITableViewCell
@property id delegate;
- (void)setTitles:(NSArray *)listOfTitles;
- (void)setTitleColor:(UIColor *)color;
- (void)setBoxColors:(NSArray *)listOfColors;
- (UIView *)customContentView;
@end

@protocol RGTableViewCellProtocol <NSObject>

- (void)cellTapped:(RGTableViewCell *)cell withIndex:(NSInteger )index;

@end
