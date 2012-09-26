//
//  Translation.m
//  Info Forest
//
//  Created by Becky Hogan on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Translation.h"
#import "AFXMLRequestOperation.h"
#import "SidebySideViewController.h"

@interface Translation ()


@end


@implementation Translation
@synthesize xmlUrl;
@synthesize myxml;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        xmlUrl=@"http://furman-classics.appspot.com/CTS?withXSLT=chs-gp&request=GetPassagePlus&urn=urn:cts:greekLit:tlg0031.tlg001.fu001:%@&inv=inventory.xml";
        pagenumber=1;
    }
    return self;
}

-(void)Increase{
    pagenumber++;
    NSLog(@"pagnumber increased to %i", pagenumber);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"pagenuMBERRRR %i", pagenumber);
    NSString* pagestring = [NSString stringWithFormat:@"%i", pagenumber];
    NSLog(@"yo it's a page string! %@",pagestring);
    NSString* xml=[NSString stringWithFormat:xmlUrl,pagestring];
    NSLog(@"xml string %@", xml);
    AFKissXMLRequestOperation* operation= [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:xml]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
        NSString *xmlString=[XMLDocument XMLStringWithOptions:DDXMLNodePrettyPrint];
        NSString* printString=[self parseString:xmlString];
        myxml.text=printString;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
        NSLog(@"Failure!");
    }];
    
    [operation start]; 
    myxml.editable = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(id)parseString:(NSString *)xmlString{
    NSMutableString *returnString = [[NSMutableString alloc] initWithFormat:@"" ];
    int x=0;
    for (int i=0; i < [xmlString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [xmlString characterAtIndex:i]];
        if([ichar isEqualToString: @"<"] || x==-1){
            x=-1;
        }
        if (x==1) {
            [returnString appendString:ichar];
        }
        if ([ichar isEqualToString: @">"]) {
            x=1;
        }
    }
    returnString=[NSString stringWithFormat:returnString];
    return returnString;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
