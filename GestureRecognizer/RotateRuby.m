//
//  RotateRuby.m
//  GestureRecognizer
//
//  Created by Ngô Sỹ Trường on 5/4/16.
//  Copyright © 2016 Cuong Trinh. All rights reserved.
//

#import "RotateRuby.h"
#import "UIImageView+Photo.h"
#import <QuartzCore/QuartzCore.h>

@implementation RotateRuby
{
    UIImageView* rugby;
    NSTimer* timer;
    CGFloat angle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    rugby = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rugby.png"]];
    rugby.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    rugby.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:rugby];
    rugby.userInteractionEnabled = YES;  //Don't forget this line
    rugby.multipleTouchEnabled = YES;
     UIRotationGestureRecognizer* rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(onRotate:)];
    
    [rugby addGestureRecognizer:rotate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(rotateBall)
                                           userInfo:nil
                                            repeats:true];
    
}
- (void) onRotate: (UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        gestureRecognizer.view.transform = CGAffineTransformRotate(gestureRecognizer.view.transform, gestureRecognizer.rotation);
        angle = gestureRecognizer.rotation;
    }
}

-(void) rotateBall {
    rugby.transform = CGAffineTransformRotate(rugby.transform, angle);
    angle = angle * 0.9;

}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


@end
