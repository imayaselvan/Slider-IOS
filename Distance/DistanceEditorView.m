//
//  DistanceEditorView.m
//  Distance
//
//  Created by Administrator on 27/05/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "DistanceEditorView.h"

#ifdef __IPHONE_6_0 // iOS6 and later
#   define kLabelAlignmentCenter    NSTextAlignmentCenter
#   define kLabelAlignmentLeft      NSTextAlignmentLeft
#   define kLabelAlignmentRight     NSTextAlignmentRight
#   define kLabelTruncationTail     NSLineBreakByTruncatingTail
#   define kLabelTruncationMiddle   NSLineBreakByTruncatingMiddle
#else // older versions
#   define kLabelAlignmentCenter    UITextAlignmentCenter
#   define kLabelAlignmentLeft      UITextAlignmentLeft
#   define kLabelAlignmentRight     UITextAlignmentRight
#   define kLabelTruncationTail     UILineBreakModeTailTruncation
#   define kLabelTruncationMiddle   UILineBreakModeMiddleTruncation
#endif

@implementation DistanceEditorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void) createUI
{
    float gap = 5;
    
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(gap, gap, (self.frame.size.width-gap*2)-50, self.frame.size.height-(gap*2))];
    bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    bgView.layer.cornerRadius = bgView.frame.size.height/2;
    [self addSubview:bgView];
    
    float barGap = 16;
    float barHeight = 3;
    barView = [[UIView alloc] initWithFrame:CGRectMake(barGap, 35, bgView.frame.size.width-(barGap*2), barHeight)];
    barView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.08];
    barView.layer.cornerRadius = barView.frame.size.height/2;
    barView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5].CGColor;
    barView.layer.borderWidth = .1;
    [bgView addSubview:barView];
    
    barViewFill = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, barHeight)];
    barViewFill.backgroundColor = [UIColor blackColor];
    barViewFill.layer.cornerRadius = barView.frame.size.height/2;
    [barView addSubview:barViewFill];
    
    dragBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 5, 32, 32)];
    dragBtn.backgroundColor = [UIColor clearColor];
    [dragBtn setImage:[UIImage imageNamed:@"nearbylocation.png"] forState:UIControlStateNormal];
    [dragBtn addTarget:self action:@selector(touchBegan:withEvent:) forControlEvents: UIControlEventTouchDown];
    [dragBtn addTarget:self action:@selector(touchMoving:withEvent:) forControlEvents: UIControlEventTouchDragInside | UIControlEventTouchDragOutside];
    [dragBtn addTarget:self action:@selector(touchEnded:withEvent:) forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [bgView addSubview:dragBtn];
    
    updateBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width+5, 3, 45, 45)];
    updateBtn.backgroundColor = [UIColor blackColor];
    updateBtn.layer.cornerRadius = updateBtn.frame.size.height/2;
    updateBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:11];
    [bgView addSubview:updateBtn];
    
    updatedlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    updatedlabel.font = [UIFont fontWithName:@"Arial" size:10];
    updatedlabel.textAlignment = kLabelAlignmentCenter;
    updatedlabel.numberOfLines = 0;
    updatedlabel.textColor = [UIColor whiteColor];
    [updateBtn addSubview:updatedlabel];
    
    [self setDistance];
    
}
- (void)touchBegan:(UIButton *)control withEvent:event {
    [self fadeInLabel];
    updatedlabel.font = [UIFont fontWithName:@"Arial" size:15];
}
- (void)touchMoving:(UIButton *)control withEvent:event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if(touchPoint.x >16 && touchPoint.x < (bgView.frame.size.width-16))
        dragBtn.frame = CGRectMake(touchPoint.x-16, 5, 32, 32);
    
    [self setDistance];
}
- (void)touchEnded:(UIButton *)addOnButton withEvent:event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if(touchPoint.x <0)
        dragBtn.frame = CGRectMake(0, 5, 32, 32);
    
    if(touchPoint.x > bgView.frame.size.width)
        dragBtn.frame = CGRectMake(bgView.frame.size.width-32, 5, 32, 32);
    
    [self fadeOutLabel];
}
-(void) fadeInLabel
{
    [self setDistance];
}
-(void) fadeOutLabel
{
    [self setDistance];
}
-(void) setDistance
{
    int distance = (int)(dragBtn.frame.origin.x);
    updatedlabel.text = [NSString stringWithFormat:@"%i",distance];
    barViewFill.frame = CGRectMake(0, 0, distance, 3);
}

@end
