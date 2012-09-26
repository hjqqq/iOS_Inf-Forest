//
//  Translation.h
//  Info Forest
//
//  Created by Becky Hogan on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModleForImageViewer.h"
#import "TouchXML.h"
#import "AFKissXMLRequestOperation.h"

@interface Translation : UIViewController
{
    IBOutlet UITextView *myxml;
     NSString *xmlUrl;
    int pagenumber;

}

@property (retain,nonatomic) NSString *xmlUrl;
@property (nonatomic, retain)IBOutlet UITextView *myxml;

-(void)Increase;


@end
