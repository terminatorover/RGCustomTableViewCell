RGCustomTableViewCell
=====================
///---->To set the Texts and color of the 3 cells
- (void)setTitles:(NSArray *)listOfTitles;
- (void)setTitleColor:(UIColor *)color;


///---> Delegate (this let's you know which box is being tapped 0,1,2 or if the 
content View is getting tapped 3 
- (void)cellTapped:(RGTableViewCell *)cell withIndex:(NSInteger )index;
