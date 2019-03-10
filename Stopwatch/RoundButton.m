//
//  RoundButton.m
//  Stopwatch
//
//  Created by Mike Jarosch on 2/27/19.
//  Copyright © 2019 Mike Jarosch. All rights reserved.
//

#import "RoundButton.h"

@interface RoundButton ()

@property (strong, nonatomic) CALayer *outerCircleLayer, *innerCircleLayer;
@property (strong, nonatomic) NSMutableDictionary *fillValues;

@end

@implementation RoundButton

- (id) init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.fillValues = [[NSMutableDictionary alloc] init];

    self.outerCircleLayer = [[CALayer alloc] init];
    self.outerCircleLayer.borderWidth = 2.0;

    [self.layer insertSublayer:self.outerCircleLayer atIndex:0];

    self.innerCircleLayer = [[CALayer alloc] init];
    self.innerCircleLayer.masksToBounds = YES;

    [self.layer insertSublayer:self.innerCircleLayer atIndex:0];

    [self updateCircleColorForState];
}

- (void)layoutSubviews
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGRect outerFrame = CGRectInset(self.bounds, 2, 2);
    CGRect innerFrame = CGRectInset(outerFrame, 3, 3);

    self.outerCircleLayer.frame = outerFrame;
    self.outerCircleLayer.cornerRadius = outerFrame.size.width / 2.0;
    self.outerCircleLayer.position = center;

    self.innerCircleLayer.frame = innerFrame;
    self.innerCircleLayer.cornerRadius = innerFrame.size.width / 2.0;
    self.innerCircleLayer.position = center;

    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    [self updateCircleColorForState];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    [self updateCircleColorForState];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    [self updateCircleColorForState];
}

- (UIColor *)_defaultFillColor
{
    return UIColor.clearColor;
}

- (void)setFillColor:(nullable UIColor *)color forState:(UIControlState)state { 
    NSNumber *key = [NSNumber numberWithInt:state];
    if (color) {
        [self.fillValues setObject:color forKey:key];
    } else {
        [self.fillValues removeObjectForKey:key];
    }

    [self updateCircleColorForState];
}

- (nullable UIColor *)fillColorForState:(UIControlState)state {
    return [self.fillValues objectForKey:[NSNumber numberWithInt:state]] ?: [self.fillValues objectForKey:[NSNumber numberWithInt:UIControlStateNormal]] ?: [self _defaultFillColor];
}

- (UIColor *)currentFillColor {
    return [self fillColorForState:self.state];
}

- (UIColor *)fillColorForNormal {
    return [self fillColorForState:UIControlStateNormal];
}

- (void)setFillColorForNormal:(UIColor *)color {
    [self setFillColor:color forState:UIControlStateNormal];
}

- (UIColor *)fillColorForHighlighted {
    return [self fillColorForState:UIControlStateHighlighted];
}

- (void)setFillColorForHighlighted:(UIColor *)color {
    [self setFillColor:color forState:UIControlStateHighlighted];
}

- (UIColor *)fillColorForSelected {
    return [self fillColorForState:UIControlStateSelected];
}

- (void)setFillColorForSelected:(UIColor *)color {
    [self setFillColor:color forState:UIControlStateSelected];
}

- (UIColor *)fillColorForDisabled {
    return [self fillColorForState:UIControlStateDisabled];
}

- (void)setFillColorForDisabled:(UIColor *)color {
    [self setFillColor:color forState:UIControlStateDisabled];
}

- (void)updateCircleColorForState {
    CGColorRef fillColor = self.currentFillColor.CGColor;
    self.outerCircleLayer.borderColor = fillColor;
    self.innerCircleLayer.backgroundColor = fillColor;
}

@end
