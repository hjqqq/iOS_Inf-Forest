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
@property InfoForestUrl currentUrl;
@property InfoForestUrn currentUrn;

@end

@implementation ModleForImageViewer
@synthesize cache = _cache;
@synthesize currentUrl = _currentUrl;
@synthesize currentUrn=_currentUrn;



-(id)init
{
    if(self = [super init])
    {
        _currentUrl.Base = @"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=%@&w=3000";
        
        _currentUrn.base=@"urn:cite:fufolioimg:";
        _currentUrn.type=@"ChadRGB.";
        _currentUrn.doc=@"Chad";
        _currentUrn.crop = @":0.07,0.08,0.8.8,0.79";
                

        _cache = [[imgcache alloc] init];
        
        
        
    }
    
    return self;
}

-(UIImage*)startImage {
    _currentUrn.pageNumber = 001;
    NSLog(@"Loaded Up Page 1");
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
    NSLog(@"NEXT");
    UIImage* currentpage=[_cache cacheImage:[self helper]];
    //caching the next image after that
    _currentUrn.pageNumber++;
    [_cache cacheImage:[self helper]];
    _currentUrn.pageNumber--;
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
    //caching the next image before that
    _currentUrn.pageNumber--;
    [_cache cacheImage:[self helper]];
    _currentUrn.pageNumber++;
    return currentpage;
}

-(UIImage*)gotopage: (int) pageNum
{
    _currentUrn.pageNumber=pageNum;
    UIImage* currentpage=[_cache cacheImage:[self helper]];
    //caching the images around it
    _currentUrn.pageNumber++;
    [_cache cacheImage:[self helper]];
    _currentUrn.pageNumber--;
    _currentUrn.pageNumber--;
    [_cache cacheImage:[self helper]];
    _currentUrn.pageNumber++;
    return currentpage;
}


//concatenates the URL and URN together

-(NSString*)helper
{
    InfoForestUrn dataurn=_currentUrn;
    
    NSString * pageString = [NSString stringWithFormat:@"%03d",dataurn.pageNumber];
        
    NSMutableString *tmpString = [[NSMutableString alloc] initWithFormat:dataurn.base ];
    [tmpString appendString:dataurn.type];
    [tmpString appendString:dataurn.doc];
    [tmpString appendString:pageString];
    [tmpString appendString:dataurn.crop];
    //NSLog(tmpString);
    tmpString=[NSString stringWithFormat:_currentUrl.Base,tmpString];
    return tmpString;
    
}

@end
