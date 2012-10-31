//
//  ViewController.m
//  Info Forest
//
//  Created by Becky Hogan on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Request.h"
#import "ViewController.h"
#import "imgcache.h"
#import "ImageView.h"
#import "ThreeDViewController.h"
#import "SidebySideViewController.h"


#import "AFXMLRequestOperation.h"
#import "AFKissXMLRequestOperation.h"
#import "AboutViewController.h"


@class imgcache;
@class Request;
@interface ViewController ()
@end

@implementation ViewController
@synthesize textField;

//Go to the about page when button is clicked
-(IBAction)aboutChad {
    
     AboutViewController* Chad= [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    Chad.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:Chad animated:YES];
    
}




- (void)loadButtonsCode {
    UIButton *chadGospelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chadGospelButton setFrame:CGRectMake(600, 200, 300, 25)];
    [chadGospelButton setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
     [chadGospelButton setTitle:@"Chad Gospels" forState:UIControlStateNormal];
    [chadGospelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chadGospelButton addTarget:self action:@selector(aboutChad) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:chadGospelButton];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Info_Forest_Main_BG.jpg"]];
    self.view.backgroundColor=background;
    [background release];
    [self loadButtonsCode];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
