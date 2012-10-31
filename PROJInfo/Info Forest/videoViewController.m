//
//  videoViewController.m
//  Info Forest
//
//  Created by Becky Hogan on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "videoViewController.h"



@interface videoViewController ()

@end
@implementation videoViewController
@synthesize videoView = _videoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //   [self embedYouTube:@"http://youtu.be/jpN-NziGOoM" frame:CGRectMake(0,0, 950,650)];
        
}
/*
- (id)embedYouTube:(NSString *)urlString frame:(CGRect)frame {
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head>body style =\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\"\
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    
    NSString *html = [NSString stringWithFormat:embedHTML, urlString, frame.size.width, frame.size.height];
    
    NSLog(html);
    _videoView = [[UIWebView alloc] initWithFrame:frame];
    [_videoView loadHTMLString:html baseURL:nil];
    [self.view addSubview:_videoView];
    return self;
    
}
*/
- (id)embedYouTube:(NSString *)urlString frame:(CGRect)frame {
/*    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    <h1>Hello Bro</h1>\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString *html = [NSString stringWithFormat:embedHTML, urlString, frame.size.width, frame.size.height];
    */
    
    /*NSString *html = @"<html>\
    <iframe width=\"950\" height=\"534\" src=\"http://www.youtube.com/embed/jpN-NziGOoM?rel=0\"\
    frameborder=\"0\" allowfullscreen></iframe>\
    </html>";
    */
    NSString *html = @"<html><head>    <style type=\"text/css\">     body {\
        background-color: transparent;    color: white;    }    \
    </style>    </head>\
    <iframe width=\"500\" height=\"250\" src=\"http://www.youtube.com/embed/jpN-NziGOoM?rel=0\"\
    frameborder=\"0\" allowfullscreen></iframe>\
    </body></html>";

    
     _videoView = [[UIWebView alloc] initWithFrame:frame];
    [_videoView setAllowsInlineMediaPlayback:YES];
    [_videoView setMediaPlaybackRequiresUserAction:NO];
    [_videoView loadHTMLString:html baseURL:nil];
    [self.view addSubview:_videoView];
   
//    NSLog(html);
    return self;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
     //[_videoView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
