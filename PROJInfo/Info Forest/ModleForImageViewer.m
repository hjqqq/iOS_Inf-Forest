//
//  ModleForImageViewer.m
//  Info Forest
//
//  Created by Becky Hogan on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModleForImageViewer.h"
#import "imgcache.h"



@interface ModleForImageViewer ()
@property (strong, nonatomic) imgcache *cache;
//@property InfoForestUrl currentUrl;
//@property NSString *URL;
@property InfoForestUrn currentUrn;

@end

@implementation ModleForImageViewer;
@synthesize cache = _cache;
//@synthesize currentUrl = _currentUrl;
//@synthesize URL = _URL;
@synthesize currentUrn=_currentUrn;



-(id)init
{
    if(self = [super init])
    {
        //_currentUrl.Base = @"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=%@&w=";
        //      _URL = @"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=%@&w=";
        _currentUrn.machine = @"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=";
        _currentUrn.size = @"500";
        _currentUrn.base=@"urn:cite:fufolioimg:";
        _currentUrn.type=@"ChadRGB.";
        _currentUrn.doc=@"Chad";
        _currentUrn.crop = @":0.07,0.08,0.8.8,0.79&w=";
                

        _cache = [[imgcache alloc] init];
        
        
        
    }
    
    return self;
}

-(UIImage*)startImage {
    _currentUrn.pageNumber = 001;
    //NSLog(@"Loaded Up Page 1");
    return [_cache cacheImage:[self helper] ];
}

-(float)returnPage
{
    return _currentUrn.pageNumber;
}

-(NSString*)setUrl
{
    NSLog(@"NOT written yet");
return (@"sorry");
}

-(UIImage*)nextImage
{
    _currentUrn.pageNumber++;
    UIImage* currentpage=[_cache cacheImage:[self helper]];
    return currentpage;
}

-(UIImage*)currentImage:(int)newSize
{
    NSString *temp =  _currentUrn.size;
    NSString * tempString = [NSString stringWithFormat:@"%d",newSize];
    _currentUrn.size = tempString;
    UIImage* currentpage=[_cache cacheImage:[self helper]];
    _currentUrn.size = temp;
    return currentpage;
}

//previous image

-(UIImage*)pervImage
{
    if (_currentUrn.pageNumber-1 <1){
        return [_cache cacheImage:[self helper]];
    }
    _currentUrn.pageNumber--;
    UIImage* currentpage=[_cache cacheImage:[self helper]];
    return currentpage;
}

-(UIImage*)gotopage: (int) pageNum
{
    _currentUrn.pageNumber=pageNum;
    UIImage* currentpage=[_cache cacheImage:[self helper]];
    return currentpage;
}




//concatenates the URL and URN together

-(NSString*)helper
{
    
    
    InfoForestUrn dataurn=_currentUrn;
    NSString * pageString = [NSString stringWithFormat:@"%03d",dataurn.pageNumber];
    
   /* 
    NSString *newString = [[NSString alloc] init]; 
    [newString stringByAppendingFormat:@"daslfkasd;lfka; %@", _currentUrl.Base,_currentUrn.base, _currentUrn.type, _currentUrn.doc, pageString, _currentUrn.crop];
    */


    
    NSMutableString *tmpString = [[NSMutableString alloc] initWithFormat:dataurn.machine ];
    [tmpString appendString:dataurn.base];
    [tmpString appendString:dataurn.type];
    [tmpString appendString:dataurn.doc];
    [tmpString appendString:pageString];
    [tmpString appendString:dataurn.crop];
   // [tmpString appendString:dataurn.size];
   // [tmpString appendString:dataurn.machine];
    [tmpString appendString:dataurn.size];
  
    
//    tmpString=[NSString stringWithFormat:_currentUrl.Base,tmpString];

 //   NSLog(tmpString);
    

    
 //   NSLog(newString);
    
    return tmpString;
    
}

-(BOOL)bufferFoward
{
    NSLog(@"Requesting the next page NOW");
//caching the next image before that
    _currentUrn.pageNumber++;
    [_cache cacheImage:[self helper]];
    _currentUrn.pageNumber--;
    return YES;
}

-(NSData*) nextData
{
    _currentUrn.pageNumber++;
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString: [self helper]]];
 
    return data;
}

-(NSString*) nextURN
{
     _currentUrn.pageNumber++;
    return [self helper];

}

-(void)speedTest
{
    
    //_currentUrn.size = @"25";
    for( int i = 0; i < 200; i++)
    {
        NSTimeInterval total;
        _currentUrn.pageNumber = 4;
        for( int avgTime = 0; avgTime < 10; avgTime++)
        {
            _currentUrn.size = [NSString stringWithFormat:@"%d", (i*10)];
            NSDate *start = [NSDate date]; 
            NSURL *ImageURL = [NSURL URLWithString: [self helper]];
            NSData *data = [[NSData alloc] initWithContentsOfURL:ImageURL];//
            UIImage *image = [[UIImage alloc] initWithData: data];
            NSDate *now = [NSDate date];
            NSTimeInterval interval = [now timeIntervalSinceDate:start];
            total = total + interval;
            [start release];
            [ImageURL release];
            [data release];
            [image release];
            [now release];
            
            
        }
        
        //NSTimeInterval timeInterval = [start timeIntervalSinceNow];
        NSLog(@",TIME, %f , %d, %@",total /10.0, (i*10), [self helper]);
     //   NSLog([NSString stringWithFormat:@"%d", (i*100)]);
        

        

    }
    return;
}

@end
