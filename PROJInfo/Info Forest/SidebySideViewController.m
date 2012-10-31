//
//  SidebySideViewController.m
//  Info Forest
//
//  Created by Becky Hogan on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
// The iOS view where the low res page image is on the right and xml on the left


#import "imgcache.h"
#import "SidebySideViewController.h"
#import "ModleForImageViewer.h"
#import "ThreeDViewController.h"
#import "videoViewController.h"
#import "ViewController.h"
#import "Request.h"
#import "AFXMLRequestOperation.h"
#import "AboutViewController.h"
#import "Translation.h"
#import "gridDisplay.h"

@class Request;

@interface SidebySideViewController ()
@property (strong, nonatomic) ModleForImageViewer *model;
@property (strong, nonatomic) UIImage * thisImage;
@property (strong, nonatomic) UIImageView *thisView;
@property (strong, nonatomic) UIViewController *ViewInstance;

@property (strong, nonatomic) NSTimer *time;

@end

@implementation SidebySideViewController
@synthesize xmlUrl;
@synthesize main;
@synthesize ViewInstance= myViewInstance;
@synthesize model = _model;
@synthesize thisImage = _thisImage;
@synthesize thisView = _thisView;
@synthesize mySlider, myTextField, myxml;
@synthesize UIbar;
@synthesize UInav;
@synthesize _3D;
@synthesize popoverController;

@synthesize time = _time;



//popup 3D viewer
-(IBAction)up3D:(id)sender {
    
    if([self.popoverController isPopoverVisible])
	{
		//close the popover view if toolbar button was touched
		//again and popover is already visible
		//Thanks to @chrisonhismac
		
		[self.popoverController dismissPopoverAnimated:YES];
		return;
	}
	
	//build our custom popover view
    
    d = [[ThreeDViewController alloc] init];
    
	
	//resize the popover view shown
	//in the current view to the view's size
	
	//create a popover controller
	self.popoverController = [[[UIPopoverController alloc]
                               initWithContentViewController:d] autorelease];
    
	    popoverController.popoverContentSize = CGSizeMake(990, 740);

	//present the popover view non-modal with a
	//refrence to the toolbar button which was pressed
	/*[self.popoverController presentPopoverFromBarButtonItem:sender
								   permittedArrowDirections:UIPopoverArrowDirectionUp
												   animated:YES];
	*/
    [self.popoverController presentPopoverFromRect:CGRectMake(315, 10, 20, 20) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [d release];
    
}



//popup Video viewer
-(IBAction)Video:(id)sender {
    
    if([self.popoverController isPopoverVisible])
	{
		
		[self.popoverController dismissPopoverAnimated:YES];
		return;
	}
    
    video =[[videoViewController alloc] init];
    
    
	self.popoverController = [[UIPopoverController alloc]
                               initWithContentViewController:[video embedYouTube:@"http://youtu.be/jpN-NziGOoM" frame:CGRectMake(0,0, 950,740)]] ;
    
    popoverController.popoverContentSize = CGSizeMake(990, 740);
    
 //   [self.popoverController presentPopoverFromBarButtonItem:sender
//								   permittedArrowDirections:UIPopoverArrowDirectionUp
//												   animated:YES];

	
    [self.popoverController presentPopoverFromRect:CGRectMake(700, 10, 20, 20) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];//
}

//popup translation viewer
-(IBAction)Translation:(id)sender {
    
    if([self.popoverController isPopoverVisible])
	{
        
        
        NSDate *date = [NSDate date];
        
        
        
        double time = [date timeIntervalSinceNow] * -1000;
        NSLog(@"elaspsed time in milliseconds %f ");
        
		
		//[self.popoverController dismissPopoverAnimated:YES];
		return;
	}
    
    trans =[[Translation alloc] init];
    
	self.popoverController = [[[UIPopoverController alloc]
                               initWithContentViewController:trans] autorelease];
    
    popoverController.popoverContentSize = CGSizeMake(990, 740);
    
    [self.popoverController presentPopoverFromRect:CGRectMake(600, 10, 20, 20) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

//info button action
-(IBAction)info:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quick Info" 
                                                    message:@"Swipe through the pages, the low res images are on the left and the text is on the right.  Use the slider to slide through pages or enter a specific page into the text box.  Click on the buttons in the navigation bar to see other views of the current page."
                                                   delegate:nil 
                                          cancelButtonTitle:@"Close" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(void)contentFooViewControllerDone:(NSNotification *)notification
{
// Button in content view controller was tapped, dismiss popover...
[self.popoverController dismissPopoverAnimated:YES];
}

- (void)dealloc 
{
    //stop listening for notifications and release popoverController...
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [popoverController release];
    [super dealloc];
}

//hit "GO" button on the key pad on the ipad to set off action to go to that page
-(IBAction)done:(id)sender {
    
    [sender resignFirstResponder];
    
    NSString *textValue = [myTextField text]; 
    float value = [textValue floatValue];    
    mySlider.value = value;  
    myTextField.text = [NSString stringWithFormat:@"%.0f", value];  
    if ([myTextField canResignFirstResponder]) [myTextField resignFirstResponder];  
    _thisImage = [_model gotopage:value]; 
    _thisView.image=_thisImage;

    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //base url
       xmlUrl=@"http://furman-classics.appspot.com/CTS?withXSLT=chs-gp&request=GetPassagePlus&urn=urn:cts:greekLit:tlg0031.tlg001.lichfield001:%@&inv=inventory.xml";
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    
    //image view on the right, create an instance of the image viewer
    _model = [[ModleForImageViewer alloc] init];
    _thisView = [[UIImageView alloc] init];
    _thisView.frame = CGRectMake(screensize.size.height/2,UInav.frame.size.height,screensize.size.height/2,screensize.size.width-(UIbar.frame.size.height*5/2)+3);
    _thisImage = [_model startImage];
    _thisView.image = _thisImage;
    _time = [[NSTimer alloc ]init];

    
    

    
    [[self view ] addSubview: _thisView];
    

    //xml on the left
   
    
    //------------------------
    
    //the xml is read in by chapters, hopefully with the server we will be able to read it in by the correct page
        
        AFKissXMLRequestOperation* operation= [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://furman-classics.appspot.com/CTS?withXSLT=chs-gp&request=GetPassagePlus&urn=urn:cts:greekLit:tlg0031.tlg001.lichfield001:1&inv=inventory.xml"]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
            NSString *xmlString=[XMLDocument XMLStringWithOptions:DDXMLNodePrettyPrint];
             NSString* printString=[self parseString:xmlString];
            myxml.text=printString;
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
            NSLog(@"Failure!");
        }];
        
        [operation start]; 
        myxml.editable = NO;
      

    //------------------------
    
   
    
    //navigation bar
    UIImageView *aTabBarBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigation_TOP.jpg"]];
    aTabBarBackground.frame=(CGRect) {
        .size.width = UInav.frame.size.width,
        .size.height = UInav.frame.size.height,
    };
    
    [UInav addSubview: aTabBarBackground];
    
    
    [self.view bringSubviewToFront:UIbar];
    [self.view bringSubviewToFront:UInav];


    // gestures
    
    UISwipeGestureRecognizer *swipeRecognizer = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self action:@selector(perImage:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [[self main] addGestureRecognizer:swipeRecognizer];
    
    UISwipeGestureRecognizer *swiperecognizer2 = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self
    action:@selector(nextImage:)];
    swiperecognizer2.direction = UISwipeGestureRecognizerDirectionLeft;
    [[self main] addGestureRecognizer:swiperecognizer2];
    
    mySlider.minimumValue=1;
    mySlider.maximumValue=150;
    mySlider.value = 1;
    myTextField.text = @"1";
    
    //BUTTONS!----------------------------------------------------------
    
    
    UIButton *HomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [HomeButton setFrame:CGRectMake(5, 705, 40, 40)];
    [HomeButton setBackgroundImage:[UIImage imageNamed:@"home_button"] forState:UIControlStateNormal];
    [HomeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:HomeButton];
    [self.view bringSubviewToFront:HomeButton];
    
    UIButton *TableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [TableButton setFrame:CGRectMake(60, 705, 40, 40)];
    [TableButton setBackgroundImage:[UIImage imageNamed:@"table-of-contents_BUTTON.png"] forState:UIControlStateNormal];
    [TableButton addTarget:self action:@selector(_about) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:TableButton];
    [self.view bringSubviewToFront:TableButton];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton setFrame:CGRectMake(950, 705, 40, 40)];
    [infoButton setBackgroundImage:[UIImage imageNamed:@"info_BUTTON.png"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:infoButton];
    [self.view bringSubviewToFront:infoButton];
    
    //Navigation buttons-----------------
    UIButton *HRButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [HRButton setFrame:CGRectMake(5, 5, 110, 30)];
    //[HRButton addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:HRButton];
    [self.view bringSubviewToFront:HRButton];
    
    UIButton *MultiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [MultiButton setFrame:CGRectMake(120, 5, 140, 30)];
    //[MultiButton addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:MultiButton];
    [self.view bringSubviewToFront:MultiButton];
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [threeButton setFrame:CGRectMake(280, 5, 80, 30)];
    [threeButton addTarget:self action:@selector(up3D:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:threeButton];
    [self.view bringSubviewToFront:threeButton];
    
    
    UIButton *legacyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [legacyButton setFrame:CGRectMake(360, 5, 110, 30)];
    //[legacyButton addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:legacyButton];
    [self.view bringSubviewToFront:legacyButton];
    
    UIButton *TransButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [TransButton setFrame:CGRectMake(470, 5, 180, 30)];
    [TransButton addTarget:self action:@selector(Translation:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:TransButton];
    [self.view bringSubviewToFront:TransButton];
    
    UIButton *extraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [extraButton setFrame:CGRectMake(650, 5, 110, 30)];
    [extraButton addTarget:self action:@selector(Video:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:extraButton];
    [self.view bringSubviewToFront:extraButton];
    



}

//parse the imported xml to ignore any of the text inside < >

-(id)parseString:(NSString *)xmlString{
    NSMutableString *returnString = [[NSMutableString alloc] initWithFormat:@"" ];
    int x=0;
    for (int i=0; i < [xmlString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [xmlString characterAtIndex:i]];
        if([ichar isEqualToString: @"<"] || x==-1){
            x=-1;
        }
        if (x==1) {
            [returnString appendString:ichar];
        }
        if ([ichar isEqualToString: @">"]) {
            x=1;
        }
    }
    returnString=[NSString stringWithFormat:returnString];
    return returnString;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//---------- slider
- (IBAction) sliderValueChanged:(UISlider *)sender {  
    myTextField.text = [NSString stringWithFormat:@"%.0f", [sender value]];
    _thisImage = [_model gotopage:[sender value]]; 
    _thisView.image=_thisImage;
   
}  

- (IBAction) changeButtonPressed:(id)sender {  
    NSString *textValue = [myTextField text];
   // NSString *textValue = [textV stringByMatching:@"p.(.*)" capture:1L];
    float value = [textValue floatValue];    
    mySlider.value = value;  
    myTextField.text = [NSString stringWithFormat:@"%.0f", value];  
    if ([myTextField canResignFirstResponder]) [myTextField resignFirstResponder];  
    _thisImage = [_model gotopage:value]; 
    _thisView.image=_thisImage;
}  

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {  
    if (myTextField) {  
        if ([myTextField canResignFirstResponder]) [myTextField resignFirstResponder];  
    }  
    [super touchesBegan: touches withEvent: event];  
}  
//----------



-(IBAction)nextImage:(UISwipeGestureRecognizer *)sender
{
   
    //increase pagenumber in translation viewer
//    trans = [[Translation alloc] init];
//    [trans Increase];
    //get current page number and put together the URL

  //  int pagenum=[_model returnPage]+1;
  //  NSString* pagestring = [NSString stringWithFormat:@"%i", pagenum];
//    NSLog(@"pagestring %@", pagestring);screensize

    
   
    _thisImage = [_model nextImage]; //Changeing the image, the view is already looking 
    
    
    myTextField.text = [NSString stringWithFormat:@"%.0f", [_model returnPage]];
    mySlider.value=[_model returnPage];
    
    UIImageView *tempView = [[UIImageView alloc] init];
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    tempView.frame = CGRectMake(screensize.size.height/2,UInav.frame.size.height,screensize.size.height/2,screensize.size.width-(UIbar.frame.size.height*5/2)+3);
    [tempView setImage:_thisImage];    
    [UIView transitionFromView:_thisView
                        toView:tempView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCurlUp
                    completion:^(BOOL finished) {
                        // animation completed
                    }];
    _thisView = tempView;
    [tempView release];

    
    SEL go = @selector(timerFireMethod:);
    _time = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:go userInfo:nil  repeats:NO];

    //[_model speedTest];

    
    
}

-(IBAction)perImage:(UISwipeGestureRecognizer *)sender
{
    
    
    _thisImage = [_model pervImage];
   // _thisView.image = _thisImage;
    myTextField.text = [NSString stringWithFormat:@"%.0f", [_model returnPage]];
    mySlider.value=[_model returnPage];
    
    
    UIImageView *tempView = [[UIImageView alloc] init];
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    tempView.frame = CGRectMake(screensize.size.height/2,UInav.frame.size.height,screensize.size.height/2,screensize.size.width-(UIbar.frame.size.height*5/2)+3);
    [tempView setImage:_thisImage];    
    [UIView transitionFromView:_thisView
                        toView:tempView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCurlDown
                    completion:^(BOOL finished) {
                        // animation completed
                    }];
    _thisView = tempView;
    [tempView release];
    SEL go = @selector(timerFireMethod:);

    _time = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:go userInfo:nil  repeats:NO];
    //[_time setFireDate:[NSDate date] ];
    
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    } 
                                                                      
    else
        return NO;
    
}

-(IBAction)home {
   
    ViewController *go= [[ViewController alloc]initWithNibName:@"ViewController_iPad" bundle:nil];
    
    
    go.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:go animated:YES];
     
}



-(IBAction)_about {
    
    AboutViewController* Chad= [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    
    Chad.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:Chad animated:YES];
    
}

//-(void)betterImage:(NSTimer*)timer
-(void)timerFireMethod:(NSTimer*)theTimer
{
   // [_thisImage release];
    _thisImage = [_model currentImage:1000];
    
    _thisView.image = _thisImage;
    //NSLog(@"timer went off");
    return;
}


@end
