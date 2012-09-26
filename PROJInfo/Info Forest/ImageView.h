//
//  ImageView.h
//  Info Forest
//
//  Created by Becky Hogan on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIViewController
-(IBAction)nextImage:(UISwipeGestureRecognizer *)sender;
//- (IBAction)swipeDetected:(UIGestureRecognizer *)sender;
-(IBAction)perImage:(UISwipeGestureRecognizer *)sender;
@end
