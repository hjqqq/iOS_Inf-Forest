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
@property (strong, nonatomic) NSMutableArray *buttonList;
@end

@implementation ViewController
@synthesize buttonList = _buttonList;
@synthesize scroll;
@synthesize textField;

//Go to the about page when button is clicked
-(IBAction)_3Dgo {
    
     AboutViewController* Chad= [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    
    Chad.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:Chad animated:YES];
    
}


- (void)buttonClicked:(UIButton*)button
{
    NSLog(@"Button %ld clicked.", (long int)[button tag]);
}



- (void)loadButtonsCode {
    // here the button is not created dynamically, scroll down to see it commented out
    UIButton *chadGospelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chadGospelButton setFrame:CGRectMake(600, 200, 300, 25)];
    [chadGospelButton setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
     [chadGospelButton setTitle:@"Chad Gospels" forState:UIControlStateNormal];
    [chadGospelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chadGospelButton addTarget:self action:@selector(_3Dgo) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:chadGospelButton];
     
    
}

- (void)viewDidLoad
{
    NSLog(@"THIS IS THE FIRST LINE OF CODE");
    [super viewDidLoad];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Info_Forest_Main_BG.jpg"]];
    self.view.backgroundColor=background;
    [background release];
    
   
     
    Request *xmlhttp=[[Request alloc]init];
    [xmlhttp xmlRequest:@"http://www.javaworld.com/jw-10-1999/servletapi/web.xml"];
    
     
    _buttonList = [[NSMutableArray alloc] init];
    
    CGRect const screenSize =[[UIScreen mainScreen] bounds];
    int const buttonWidth= (screenSize.size.width/3);
    int const buttonHeight= (screenSize.size.height/25);
    
    [self loadButtonsCode];
    
    // dynamically creating buttons, implement once there are more than one manuscripts!!!
    /*
    
    
    Request *http=[[Request alloc] init];
     //this is a random xml site used for testing
    NSMutableArray* buttoninfo=[http getXML:@"http://www.javaworld.com/jw-10-1999/servletapi/web.xml":@"servlet-name": @"//servlet"];
    int numberOfButtons= [buttoninfo count];
    
    
    int btstart=screenSize.size.width/4;
    for(int i = 1 ; i < numberOfButtons+1; i++)
    {
        UIButton *temp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage* btnImage=[UIImage imageNamed:@"button.jpg"];
        [temp setBackgroundImage:btnImage forState:UIControlStateNormal];
        NSString *title=[buttoninfo objectAtIndex:i-1];
        [temp setTitle:title forState:UIControlStateNormal];
        
        temp.frame = CGRectMake((screenSize.size.width/2)+(screenSize.size.width/4), btstart, buttonWidth, buttonHeight);
        [_buttonList addObject: temp];
        
        if ((numberOfButtons*buttonHeight*3/2)<=screenSize.size.height) {
            scroll.userInteractionEnabled = NO;
            [[self view]addSubview:temp];
        }
        
        else {
            [[self scroll]addSubview:temp];
        }
        btstart=btstart+buttonHeight*5/4;
    }
     
    
    
    
    scroll.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
    [scroll setContentSize:CGSizeMake(screenSize.size.width, numberOfButtons*buttonHeight+screenSize.size.height)];
    [[self view] addSubview:scroll];  
    
   */
    
    
    
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
