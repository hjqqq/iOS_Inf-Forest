//
//  gridDisplay.m
//  Info Forest
//
//  Created by John B on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


/*
#import "gridDisplay.h"

@implementation gridDisplay

+(id)init:(NSString*) page
         :(UIViewController*) layout 
         :(float) screenSize_X
         :(float)screenSize_Y;
{
    
  //  if(self = [super init])
    {
        
    float boxheight = screenSize_X/16.;
    float boxwidth  = screenSize_Y/8.;
        
        
        float x1,x2,y1,y2;
        
        x1=0;
        x2 = 1/8.;
        y1 = 0;
        y2 = 1/8.;

    float heightAccum = 8*boxheight, widthAccum = 0;
    for(int i =0; i < 64; i++)
    {
        UIImageView *games =  [[UIImageView alloc] init];
        //[games setFrame: CGRectMake(widthAccum, heightAccum, boxwidth, boxheight)]; 
        [games setFrame: CGRectMake(heightAccum, widthAccum, boxheight, boxwidth)]; 
    
    
        widthAccum = widthAccum + boxwidth;
        if (!((i +1) % 8))
        {
            heightAccum = heightAccum + boxheight;
            widthAccum = 0;
        }
    
        NSLog(@" %f   %f",heightAccum, widthAccum);

  //      NSLog("outPutIN grid");
    
        
        NSString *holder = [[page stringByAppendingString:[NSString stringWithFormat:@":%f,%f,%f,%f",x1,y1,x2,y2]] stringByAppendingString:@"&w=3000"];        
        NSLog(holder);
        games.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: holder]]]; //[page stringByAppendingString :[NSString stringWithFormat:@":%f,%f,%f,%f",x1,y1,x2,y2]]]]];
        //UIImageView *temp = [_displayGrid objectAtIndex:i]; //->imageVeiw = [UIImage imageNamed:@"info_BUTTON.png"]];
        
        
        x1 = x2;
        x2 =x2 + 1/8.0;
        if(! ((i+1)%8))
        {
            y1 = y2;
            y2 = y2 + 1/8.0;
            
            x1=0;
            x2 = 1/8.0;
        }

    
        [[layout view] addSubview:games];
        [[layout view] bringSubviewToFront:games];
    
    
    }

    }
    return self;
}


@end

*/