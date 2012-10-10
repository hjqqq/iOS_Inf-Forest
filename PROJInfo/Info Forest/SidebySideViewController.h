//
//  SidebySideViewController.h
//  Info Forest
//
//  Created by Becky Hogan on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreeDViewController.h"
#import "videoViewController.h"
#import "TouchXML.h"
#import "AFKissXMLRequestOperation.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Translation.h"


@protocol MyPopoverDelegate <NSObject> 
-(void)didClickCancelButton;
@end


@interface SidebySideViewController : UIViewController {
    
    UIView *main;
    IBOutlet UISlider *mySlider;
    IBOutlet UITextField *myTextField;
    IBOutlet UIToolbar *UIbar;
    IBOutlet UINavigationBar *UInav;
    IBOutlet UIBarButtonItem *_3D;
    IBOutlet UITextView *myxml;
    NSString *xmlUrl;
    UIPopoverController *popoverController;
    ThreeDViewController *d;
    videoViewController *video;
    Translation *trans;
    
}

@property (retain,nonatomic) NSString *xmlUrl;
@property (retain,nonatomic) IBOutlet UIView *main;
@property (nonatomic, retain)IBOutlet UISlider *mySlider;
@property (nonatomic, retain)IBOutlet UITextField *myTextField;
@property (nonatomic, retain)IBOutlet UITextView *myxml;
@property (retain,nonatomic) IBOutlet UIToolbar *UIbar;
@property (retain,nonatomic) IBOutlet UINavigationBar *UInav;
@property (retain,nonatomic) IBOutlet UIBarButtonItem *_3D;
@property (retain,nonatomic) UIPopoverController *popoverController;




-(IBAction)nextImage:(UISwipeGestureRecognizer *)sender;
-(IBAction)perImage:(UISwipeGestureRecognizer *)sender;
-(IBAction)sliderValueChanged:(id)sender;
-(IBAction)changeButtonPressed:(id)sender;
-(IBAction)done:(id)sender;
-(id)parseString:(NSString *)xmlString;
-(IBAction)up3D:(id)sender;
-(IBAction)home;
-(IBAction)_about;


@end
