//
//  AboutViewController.h
//  Info Forest
//
//  Created by Becky Hogan on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebySideViewController.h"

@interface AboutViewController : UIViewController
{
    UIView *main;
    IBOutlet UINavigationBar *UInav;
    IBOutlet UITextView *myTextField;
}
@property (nonatomic, retain)IBOutlet UITextView *myTextField;
@property (retain,nonatomic) IBOutlet UIView *main;
@property (retain,nonatomic) IBOutlet UINavigationBar *UInav;

-(IBAction)nextPage:(UISwipeGestureRecognizer *)sender;
-(IBAction)Folio:(id)sender ;
-(IBAction)Credits:(id)sender;
-(IBAction)About:(id)sender;
@end

