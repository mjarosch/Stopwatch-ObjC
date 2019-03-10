//
//  RoundButton.h
//  Stopwatch
//
//  Created by Mike Jarosch on 2/27/19.
//  Copyright © 2019 Mike Jarosch. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE

@interface RoundButton : UIButton

- (void)setFillColor:(nullable UIColor *)color forState:(UIControlState)state; // default if nil. use transparent
- (nullable UIColor *)fillColorForState:(UIControlState)state;

@property(nonatomic, readonly, strong) UIColor  *currentFillColor;        // normal/highlighted/selected/disabled. always returns non-nil. default is transparent

// Since we can't be in the normal UIButton state editor in Xcode, add some helpers that can
@property(nonatomic, strong) IBInspectable UIColor  *fillColorForNormal;        // Always returns non-nil. default is transparent
@property(nonatomic, strong) IBInspectable UIColor  *fillColorForHighlighted;        // Always returns non-nil. default is transparent
@property(nonatomic, strong) IBInspectable UIColor  *fillColorForSelected;        // Always returns non-nil. default is transparent
@property(nonatomic, strong) IBInspectable UIColor  *fillColorForDisabled;        // Always returns non-nil. default is transparent


@end

NS_ASSUME_NONNULL_END
