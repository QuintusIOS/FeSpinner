//
//  FeWaveLayer.m
//  FeSpinner
//
//  Created by Nghia Tran on 12/18/13.
//  Copyright (c) 2013 fe. All rights reserved.
//

#import "FeWaveLayer.h"

#define kMaxIndex 30

@interface FeWaveLayer ()
{
    
}
@property (strong, nonatomic) CABasicAnimation *waveAnimation;
@property (strong, nonatomic) CABasicAnimation *loadingAnimation;

// Time loading, depend on current height loading;
@property (assign, nonatomic) CGFloat durationLoading;

/////////////////////////////////
// Common init
-(void) commonInit;

// init some CABasicAnimation
-(void) initBasicAnimation;

// calculator durationLoading
-(void) calculatorDurationLoading;
@end

@implementation FeWaveLayer
@synthesize path = _path;

-(id) initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
        
        [self commonInit];
        
        // init some BAsic Animation
        [self initBasicAnimation];
    }
    return self;
}
-(void) commonInit
{
    // Should Anti alize
    self.allowsEdgeAntialiasing = YES;
    self.magnificationFilter = kCAFilterNearest;
    
    // BOOL
    _isWaving = NO;
    _isLoading = NO;
    
    _durationLoading = 1;
}
-(void) initBasicAnimation
{
    // Wave animation
    // Like wave
    _waveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    _waveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x - self.bounds.size.width / 2, self.position.y)];
    _waveAnimation.duration = 3.0;
    _waveAnimation.repeatCount = HUGE_VAL;
    
    // Calculator time duration
    [self calculatorDurationLoading];
    
    // Loading animation
    // animate percent
    _loadingAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    //_loadingAnimation.toValue = [NSNumber numberWithInt:];
    _loadingAnimation.duration = _durationLoading;
    _loadingAnimation.repeatCount = HUGE_VAL;
}
-(void) calculatorDurationLoading
{
    
}
-(void) drawInContext:(CGContextRef)ctx
{
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    
    //**************
    // Draw it self
    CGMutablePathRef path = CGPathCreateMutable();
    
    float yc = 10;//The height of a crest.
    float w = 0;//starting x value.
    float y = self.bounds.size.height;
    float width = self.bounds.size.width;
    int cycles = 2;//number of waves
    float x = width/cycles;
    CGPathMoveToPoint(path, NULL, w,y/2);
    
    while (w <= width) {
        //CGPathMoveToPoint(path, NULL, w,y/2);
        CGPathAddQuadCurveToPoint(path, NULL, w+x/4, y/2 - yc, w+x/2, y/2);
        CGPathAddQuadCurveToPoint(path, NULL, w+3*x/4, y/2 + yc, w+x, y/2);
        w+=x;
    }
    
    CGPathAddLineToPoint(path, nil, self.bounds.size.width,self.bounds.size.height / 2);
    
    CGPathAddLineToPoint(path, nil, self.bounds.size.width,self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height / 2);
    CGPathCloseSubpath(path);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, 1);
    CGContextAddPath(ctx, path);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillPath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
}
-(void) starAnimate
{
        //[self addAnimation:anim forKey:@"position"];
}
-(void) setPercent:(CGFloat)percent animate:(BOOL)animate
{
    
}
@end