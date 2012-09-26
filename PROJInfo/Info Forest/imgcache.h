//
//  imgcache.h
//  Info Forest
//
//  Created by Becky Hogan on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imgcache : NSObject {
}


@property (strong, nonatomic) NSMutableArray *ListOfCachedUrls;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSFileManager *broadbent;
@property int count;

-(id)init;
- (UIImage*)cacheImage: (NSString *) ImageURLString;  


//
//- (NSString*)saveFile:(NSString *) urlName;      //Mostly the helper function
//- (id) getImage: (NSString *) ImageURLString: (const float *)width: (const float *)height;

@end


