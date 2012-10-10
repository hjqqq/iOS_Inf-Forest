//
//  ModleForImageViewer.h
//  Info Forest
//
//  Created by Becky Hogan on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModleForImageViewer : NSObject
typedef struct 
{ NSString *Base;
  
}InfoForestUrl;



typedef struct
{ NSString *base;
    NSString *type;
    NSString *doc;
    NSString *crop;
    int pageNumber;
} InfoForestUrn;


//@property (strong, nonatomic) NSString *IfUrl;

-(id)init;
//-(void)setIfUrl:(NSString *)IfUrl;
-(float)returnPage;
-(UIImage*)nextImage;
-(UIImage*)pervImage;
-(UIImage*)startImage;
-(UIImage*)gotopage:(int)pageNum;
-(NSString*)setUrl;
-(NSString*)helper; 

-(BOOL)bufferFoward;
-(NSData*)nextData;
-(NSString*)nextURN;


@end
