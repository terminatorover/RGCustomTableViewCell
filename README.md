RGCustomTableViewCell
=====================
///---->To set the Texts and text color for the 3 cells(UIColor)
- (void)setTitles:(NSArray *)listOfTitles;
- (void)setTitleColor:(UIColor *)color;

//----> to set the colors for the cells themeselves(UIColor)
- (void)setBoxColors:(NSArray *)listOfColors;
//----> 
to get access to the subview to which you'll add your content 
- (UIView *)customContentView;


///---> Delegate (this let's you know which box is being tapped 0,1,2 or if the 
content View is getting tapped 3 
- (void)cellTapped:(RGTableViewCell *)cell withIndex:(NSInteger )index;
