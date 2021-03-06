//
//  ViewController.m
//  RGTableVIewCell
//
//  Created by ROBERA GELETA on 12/26/14.
//  Copyright (c) 2014 ROBERA GELETA. All rights reserved.
//
#define CUSTOM_CELL @"customCell"

#import "ViewController.h"
#import "RGTableViewCell.h"
@interface ViewController () <RGTableViewCellProtocol>
@property (nonatomic) NSArray *listOfData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return self.listOfData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RGTableViewCell *cell =  (RGTableViewCell * )[tableView dequeueReusableCellWithIdentifier:CUSTOM_CELL
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(RGTableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.delegate = self;
    [cell setTitles:@[@"Build",@"Great",@"Stuff"]];
    [cell setTitleColor:[UIColor whiteColor]];
    UIView *contentView = [cell customContentView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 300, 100)];
    label.text = self.listOfData[indexPath.row];
    [contentView addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellTapped:(RGTableViewCell *)cell withIndex:(NSInteger )index
{
    
}


#pragma mark - Lazy Loading 
- (NSArray *)listOfData
{
    if(!_listOfData)
    {
        _listOfData = @[@"Dog",@"Cat"];
        
    }
    return _listOfData;
}



@end
