//
//  ThreeDViewController.h
//  Info Forest
//
//  Created by Becky Hogan on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeDViewController : UIViewController <NGLViewDelegate>
{
@private
	NGLMesh *_mesh;
	NGLCamera *_camera;
    UIButton *backButton;
}
//-(void)pinch:(UIPinchGestureRecognizer* )zoom ;
@property (retain,nonatomic) IBOutlet UIButton *backButton;

-(IBAction)back;
@end


