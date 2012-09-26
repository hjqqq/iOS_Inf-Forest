//
//  videoViewController.h
//  Info Forest
//
//  Created by Becky Hogan on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>




@interface videoViewController : UIViewController
{
    MPMoviePlayerController *movieController;
}

-(void)embedYouTube:(NSString *)urlString frame:(CGRect)frame;
@end
