//
//  ImageView.m
//  Info Forest
//
//  Created by Becky Hogan on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"
#import "imgcache.h"
#import "ModleForImageViewer.h"

@interface ImageView ()
@property (strong, nonatomic) ModleForImageViewer *modle;
@property (strong, nonatomic) UIImage * currentImage;
@property (strong, nonatomic) UIImageView *currentView;

@end

@implementation ImageView 
@synthesize modle = _modle;
@synthesize currentImage = _currentImage;
@synthesize currentView = _currentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        self = [super initWithNibName:@"ImageView_iPad" bundle:nil ];
                
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect const screenSize =[[UIScreen mainScreen] bounds];
    
    
    _modle = [[ModleForImageViewer alloc] init];
    _currentView = [[UIImageView alloc] init];
    _currentView.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height - 100);
    
    
    _currentImage = [_modle startImage];
    _currentView.image = _currentImage;
    NSLog(@"View Did Load");
    [[self view] addSubview: _currentView];
    
    // Do any additional setup after loading the view from its nib.
    //Changeing the image, the view is already looking at this pointer

    UISwipeGestureRecognizer *swipeRecognizer = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self action:@selector(perImage:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    UISwipeGestureRecognizer *swiperecognizer2 = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(nextImage:)];
    swiperecognizer2.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swiperecognizer2];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(IBAction)nextImage:(UISwipeGestureRecognizer *)sender
{
    _currentImage = [_modle nextImage]; //Changeing the image, the view is already looking at this pointer
    _currentView.image=_currentImage; //This should already be set


}

-(IBAction)perImage:(UISwipeGestureRecognizer *)sender
{
    _currentImage = [_modle pervImage];
    _currentView.image = _currentImage;

}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
