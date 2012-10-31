//
//  AboutViewController.m
//  Info Forest
//
//  Created by Becky Hogan on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "ViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController;
@synthesize main;
@synthesize UInav;
@synthesize  myTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(IBAction)Folio:(id)sender {
    
    myTextField.text=
    @"FoLIO is a project that “develops a framework for organizing images that allows the specific types of relationships between those images to be represented, manipulated, highlighted, enhanced, and studied.” FoLIO stands for “Framework for Longitudinal Image-based Organization.” \n \n The project focuses on imaging important manuscripts so that the images can later be manipulated to highlight details that may not have been seen otherwise. \n \n This is done through imaging each page in different light spectrums to create a multispectral image of the page. This can expose parts of the manuscripts that have been lost to aging.\n \n This imaging process was used on the images of the Chad Gospels used for the InfoForest App. For more information about the project, visit http://vis.uky.edu/research/imaging/folio/."
       ; }
-(IBAction)Credits:(id)sender {
    myTextField.text=
    @"Dr. Brent Seales—Professor of Computer Science, University of Kentucky \n Dr. Christopher Blackwell—Professor of Classics, Furman University \n Julie Martinez—Technical Communication Specialist, Vis Center, University of Kentucky \n Greg Bandy—Assistant Professor of Media Communications, Asbury University \n Seth Parker—Video Editor, Vis Center, University of Kentucky \n Jon Fox—Engineer Associate, Vis Center, University of Kentucky \n Aaron Camenisch—Graphic Artist, Vis Center, University of Kentucky \n Becky Hogan—iOS, Vis Center, University of Kentucky \n Bonnie Lewis—Content, Vis Center, University of Kentucky \n Tucker Hannah—Latin XML for Matthew, Furman University \n Eric Santos—Android Devices, Vis Center, University of Kentucky \n John Broadbent—Server Development, Vis Center, University of Kentucky \n Krystel Navas—Web Application, Vis Center, University of Kentucky \n Zach Anderson—iOS, Vis Center, University of Kentucky \n Tony Brown, Furman University \n \n The Center for Hellenic Studies of Harvard University \n National Science Foundation \n University of Kentucky’s Center for Visualization and Virtual Environments \n \n http://vis.uky.edu/ ";
}

-(IBAction)About:(id)sender {
    myTextField.text=
    @"The Chad Gospels are an eighth century gospel book that currently resides at the Lichfield Cathedral in England. The book is 236 pages with 228 of them containing text and 8 illuminated. It was likely written by one scribe in the 700’s and given to the church of St. Teilo before it came to the Lichfield Cathedral between 900 and 1020.\n \nThe book was originally part of a two-volume set that contained the four gospels of the New Testament. However the second volume containing the rest of Luke and John was lost somewhere between the 1500 and 1600’s. \n \nThe Gospels’ pages are velum, which is a material made from animal skin. It is estimated that the first volume of the book required 50-60 animals to be used to make enough pages for Matthew, Mark and Luke 1-3. \n \nThe book was written in Latin in a version of St. Jerome’s Vulgate. In the script, there are 2,000 variations from the original Vulgate, something that has been of interest to scholars. \n \nThe Chad Gospels is significant not just because of its age. In its margins are notes written in Latin and also the earliest known Welsh. Page 141 of the manuscript contains some of the most interesting and informative marginal notes. \n \nPart of the draw of this book is the things that are yet to be uncovered about it. Where was it made, and by whom? Where is the missing second half? This manuscript has much still to be discovered about it and much more to be learned from it.";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UIImageView *aTabBarBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ipad_H_info-forest-TOC.jpg"]];
    aTabBarBackground.frame=(CGRect) {
        .size.width = UInav.frame.size.width,
        .size.height = UInav.frame.size.height,
    };
    
    [UInav addSubview: aTabBarBackground];
    
    [self.view bringSubviewToFront:UInav];
    myTextField.editable = NO;
    
    
    UISwipeGestureRecognizer *swiperecognizer2 = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(nextPage:)];
    swiperecognizer2.direction = UISwipeGestureRecognizerDirectionLeft;
    [[self main] addGestureRecognizer:swiperecognizer2];
    
    //buttons-------------
    
    UIButton *AboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AboutButton setFrame:CGRectMake(5, 5, 110, 30)];
    [AboutButton addTarget:self action:@selector(About:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:AboutButton];
    [self.view bringSubviewToFront:AboutButton];
    
    UIButton *CreditsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CreditsButton setFrame:CGRectMake(120, 5, 110, 30)];
    [CreditsButton addTarget:self action:@selector(Credits:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:CreditsButton];
    [self.view bringSubviewToFront:CreditsButton];
    
    UIButton *FolioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [FolioButton setFrame:CGRectMake(230, 5, 110, 30)];
    [FolioButton addTarget:self action:@selector(Folio:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:FolioButton];
    [self.view bringSubviewToFront:FolioButton];
    
    UIButton *HomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [HomeButton setFrame:CGRectMake(5, 700, 50, 50)];
    [HomeButton setBackgroundImage:[UIImage imageNamed:@"home_button"] forState:UIControlStateNormal];
    [HomeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:HomeButton];
    [self.view bringSubviewToFront:HomeButton];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton setFrame:CGRectMake(970, 700, 50, 50)];
    [infoButton setBackgroundImage:[UIImage imageNamed:@"info_BUTTON.png"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:infoButton];
    [self.view bringSubviewToFront:infoButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//go to the Chad low res image view

-(IBAction)nextPage:(UISwipeGestureRecognizer *)sender
{ 
    SidebySideViewController *goTo= [[SidebySideViewController alloc] initWithNibName:@"SidebySideViewController" bundle:nil];
    
    goTo.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    NSLog(@"I am swiped!");
    
    [self presentModalViewController:goTo animated:YES];
    
}

//home button action

-(IBAction)home {
    
    ViewController *go= [[ViewController alloc]initWithNibName:@"ViewController_iPad" bundle:nil];
    
    
    go.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:go animated:YES];
    
}

//info button action

-(IBAction)info:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quick Info" 
                                                    message:@"Swipe to go to the Chad Gospels viewer.  You can also click on the buttons in the navigation bar to find out more about the Chad Gospels and those who worked on it."
                                                   delegate:nil 
                                          cancelButtonTitle:@"Close" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 return(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
