//
//  Request.m
//  Info Forest
//
//  Created by Becky Hogan on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.


//  This page was mostly for testing requests before implementing them

#import "Request.h"
#import "ViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "UIImageView+AFNetworking.h"




@implementation Request
@synthesize xmlDocument=_xmlDocument;



- (id)httpRequest:(NSString *)httpurl
{
    NSURL *url = [NSURL URLWithString:httpurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request]autorelease];


    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
        NSLog(@"response string: %@ ", operation.responseString);
    
    }
 
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"error: %@", operation.responseString);   
                                 }];
    [operation start];
    return operation;

    
}



 -(id)xmlRequest:(NSString *)xmlurl
{
    AFKissXMLRequestOperation* operation= [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:xmlurl]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
        self.xmlDocument=XMLDocument;
        NSLog(@"kiss operation %@", [self.xmlDocument XMLStringWithOptions:DDXMLNodePrettyPrint]);
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
        NSLog(@"Failure!");
    }];
    
    [operation start]; 
    NSLog(@"self!%@", [self.xmlDocument XMLStringWithOptions:DDXMLNodePrettyPrint]);
    return self.xmlDocument; 
}


-(id)imageRequest:(NSString *)imageurl :(const float *)width :(const float *)height
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, *width, *height)];
    [imageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"abc.jpg"]];
    return imageView;
}

/*
-(void)getXML:(NSString *)xmlurl 
{
    NSLog(@"Entered XML get function...\n\n");
    if([xmlData count] == 0) {
        // Create the feed string, in this case I have used dBlog
        NSString *url = xmlurl;
        NSLog(@"Size of xmlData: %d", [xmlData count]);
        // Call the grabRSSFeed function with the above
        // string as a parameter
        [self loadXML:url];
        
    }
    for (int i = 0; i < [xmlData count]; i++) {
        NSLog(@"Title of video number %d: %@", i +1, [[xmlData objectAtIndex: i] objectForKey: @"title"]);
        NSLog(@"Description of video number %d: %@", i +1, [[xmlData objectAtIndex: i] objectForKey: @"description"]);
        NSLog(@"Publication Date of video number %d: %@", i +1, [[xmlData objectAtIndex: i] objectForKey: @"puDate"]);
        NSLog(@"Link of video number %d: %@\n\n", i +1, [[xmlData objectAtIndex: i] objectForKey: @"link"]);
    }

}

-(void)loadXML:(NSString *)xmlURL {
    NSLog(@"Entered XML load function...\n\n");
    
    // Initialize the blogEntries MutableArray that we declared in the header
    xmlData = [[NSMutableArray alloc] init];	
    
    // Convert the supplied URL string into a usable URL object
    NSURL *url = [NSURL URLWithString: @"http://gdata.youtube.com/feeds/api/users/coalinkentucky/uploads?alt=rss"];

    // Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
    // object that actually grabs and processes the RSS data
    CXMLDocument *xmlParser = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
    
    
    ///////////////////////USE FOR READING FROM A LOCAL XML FILE//////////////////////////////////////////////
    //NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sitemap.xml"];
    //NSData *XMLData   = [NSData dataWithContentsOfFile:XMLPath];
    //CXMLDocument *xmlParser = [[CXMLDocument alloc] initWithData:XMLData options:0 error:nil];
    //////////////////////USE FOR READING FROM A LOCAL XML FILE///////////////////////////////////////////////
    
    
    NSLog(@"# of childNodes: %d", [xmlParser childCount]);
    
    // Create a new Array object to be used with the looping of the results from the rssParser
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    NSArray *resultNodes = [xmlParser nodesForXPath:@"//item" error:nil];
    
    NSLog(@"# of resultNodes: %d", [resultNodes count]);

    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
        NSLog(@"Entered XML data tree building sequence...\n\n");
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
        
        // Create a counter variable as type "int"
        int counter;
        
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
            
            // Add each field to the blogItem Dictionary with the node name as key and node value as the value
            [blogItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
        
        // Add the blogItem to the global blogEntries Array so that the view can access it.
        [xmlData addObject:[blogItem copy]];
    }
}
 */
-(id)getXML:(NSString *)xmlurl : (NSString *)objectforkey:(NSString *)node
{
    NSLog(@"Entered XML get function...\n\n");
    if([xmlData count] == 0) {              //Lazy instancation?
        // Create the feed string, in this case I have used dBlog
        //NSString *url = [NSURL URLWithString: xmlurl];
        NSLog(@"Size of xmlData: %d", [xmlData count]);
        // Call the grabRSSFeed function with the above
        // string as a parameter
        [self loadXML:xmlurl:node];
        
    }
    NSMutableArray *results=[[NSMutableArray alloc]init];
    for (int i = 0; i < [xmlData count]; i++) {
        NSLog(@"Title of video number %d: %@", i +1, [[xmlData objectAtIndex: i] objectForKey: objectforkey]);
        [results addObject:[[xmlData objectAtIndex: i] objectForKey: objectforkey]];
    }
    return results;
}

-(void)loadXML:(NSString *)xmlURL : (NSString *)node{
    NSLog(@"Entered XML load function...\n\n");
    
    // Initialize the blogEntries MutableArray that we declared in the header
    xmlData = [[NSMutableArray alloc] init];	
    
    // Convert the supplied URL string into a usable URL object
    NSURL *url = [NSURL URLWithString: xmlURL];
    
    // Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
    // object that actually grabs and processes the RSS data
    CXMLDocument *xmlParser = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
    
    
    ///////////////////////USE FOR READING FROM A LOCAL XML FILE//////////////////////////////////////////////
    //NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sitemap.xml"];
    //NSData *XMLData   = [NSData dataWithContentsOfFile:XMLPath];
    //CXMLDocument *xmlParser = [[CXMLDocument alloc] initWithData:XMLData options:0 error:nil];
    //////////////////////USE FOR READING FROM A LOCAL XML FILE///////////////////////////////////////////////
    
    
    NSLog(@"# of childNodes: %d", [xmlParser childCount]);
    
    // Create a new Array object to be used with the looping of the results from the rssParser
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    NSArray *resultNodes = [xmlParser nodesForXPath:node error:nil];
    
    NSLog(@"# of resultNodes: %d", [resultNodes count]);
    
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
        NSLog(@"Entered XML data tree building sequence...\n\n");
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
        
        // Create a counter variable as type "int"
        int counter;
        
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
            
            // Add each field to the blogItem Dictionary with the node name as key and node value as the value
            [blogItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
        
        // Add the blogItem to the global blogEntries Array so that the view can access it.
        [xmlData addObject:[blogItem copy]];
    }
}




@end