//
//  imgcache.m
//  Info Forest
// 
//  Created by Becky Hogan on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mach/mach.h" 



#import "UIImageView+AFNetworking.h"
#import "imgCache.h"
#import "ViewController.h"
#import "Request.h"
#define TMP NSTemporaryDirectory()

#define CATCH_NUM 20 //jb how many items can be cached

@class Request;

@implementation imgcache;
@synthesize ListOfCachedUrls = _ListOfCachedUrls;
@synthesize count = _count;
@synthesize broadbent = _broadbent;
@synthesize currentImage =_currentImage;
@synthesize images=_listofimages;



-(id)init
{   
    if(self = [super init])
    {
        _count = 0;
        _broadbent = [[NSFileManager alloc] init];
        _ListOfCachedUrls = [[NSMutableArray alloc] initWithArray: [_broadbent contentsOfDirectoryAtPath:TMP error:nil]];    
    }
    return self;
}


- (UIImage*) cacheImage: (NSString *) ImageURLString
{   

/*
    //if there is more than 7 images, release some so it won't crash!
    if(_count>7){
       for (int i=1; i<_count-1; i++)
    {
        [_broadbent removeItemAtPath:[TMP stringByAppendingPathComponent:[_listofimages objectAtIndex:i] ] error:NULL];
        [_listofimages removeObjectAtIndex:i];
        NSLog(@"I have cleared an object");
        _count--;
    }
    }
  
*/
    
    
    if(_count > CATCH_NUM)
        _count = 0;
    
    [_broadbent removeItemAtPath:[TMP stringByAppendingPathComponent:[_listofimages objectAtIndex:_count] ] error:NULL];
    [_listofimages removeObjectAtIndex:_count];
    
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    //generating unique name for the cached file with ImageURLString so you can retrive it back
    NSMutableString *tmpStr = [NSMutableString stringWithString:ImageURLString];
    [tmpStr replaceOccurrencesOfString:@"/" withString:@"-" options:1 range:NSMakeRange(0, [tmpStr length])];
    
    NSString *filename = [NSString stringWithFormat:@"%@",tmpStr];
    
    [_listofimages addObject:filename];
    
    
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];

    
    // Check for file existence
    //if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    
  
    

        
    
    if(![_broadbent fileExistsAtPath:uniquePath])
    {
        // The file doesn't exist, we should get a copy of it
        
        
        // Fetch image
        NSData *data = [[NSData alloc] initWithContentsOfURL:ImageURL];//
   
        UIImage *image = [[UIImage alloc] initWithData: data];
                
            
        [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
            _count++;
       
        
       // if ([[NSFileManager defaultManager] fileExistsAtPath: uniquePath]) 
          //  NSLog(@"I saved the file and then was able to find it(first Time I have seen this guy)");
       // else
          //  NSLog(@"I saved the file, but I can't find it. D'oh");
            
        
        
    }
    else  
    {
       // NSLog(@"I did not have to save the file(Loaded from cach)");
    }
  
    
    
    [_currentImage release];
    _currentImage =  ([[UIImage alloc] initWithContentsOfFile:uniquePath]);
    
  //  logMemUsage();
    return _currentImage;
}


 

vm_size_t usedMemory(void) 
{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

vm_size_t freeMemory(void) 
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

void logMemUsage(void) 
{
    // compute memory usage and log if different by >= 100k
    static long prevMemUsage = 0;
    long curMemUsage = usedMemory();
    long memUsageDiff = curMemUsage - prevMemUsage;
    
    if (memUsageDiff > 100000 || memUsageDiff < -100000) {
        prevMemUsage = curMemUsage;
        NSLog(@"Memory used %7.1f (%+5.0f), free %7.1f kb", curMemUsage/1000.0f, memUsageDiff/1000.0f, freeMemory()/1000.0f);
    }
}


@end