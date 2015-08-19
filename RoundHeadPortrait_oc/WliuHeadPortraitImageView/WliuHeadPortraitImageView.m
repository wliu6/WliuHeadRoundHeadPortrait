//
//  WliuHeadPortraitImageView.m
//  RoundHeadPortrait
//
//  Created by 66 on 15/8/14.
//  Copyright (c) 2015年 w66. All rights reserved.
//

#define W6_MaskViewDefaultBackgroundColor [UIColor clearColor]
#define W6_MaskViewDefaultAlpha 0.0f
#define W6_CARendering_MinPoint 2
#import "WliuHeadPortraitImageView.h"

@interface WliuHeadPortraitImageView ()
{
    BOOL _isLoadNib;
    BOOL _isDefaultInit;
    UIView *_maskView;
    CGFloat _radius;
    BOOL _cornerRadiusIsChanged;
    BOOL _isCustomCornerRadius;
}
@end
typedef NS_ENUM(NSInteger, W6_centerOffsetOrientation) {
    W6_centerDefaultOrientation = 0,
    W6_centerHorizontalOrientation,
    W6_centerVerticalOrientation
};

struct WliuSide {
    CGFloat lengthOfSide;
    W6_centerOffsetOrientation offsetOrientation;
    CGFloat offset;
};
typedef struct WliuSide W6_Side;
W6_Side W6_MakeSide(CGFloat lengthOfSide, W6_centerOffsetOrientation offsetOrientation,CGFloat offset){
    W6_Side side;
    side.lengthOfSide = lengthOfSide;
    side.offsetOrientation = offsetOrientation;
    side.offset = offset;
    return side;
}

struct WliuSquare {
    CGPoint origin;
    CGFloat lengthOfSide;
};
typedef struct WliuSquare W6_Square;
W6_Square W6_MakeSquare(CGPoint origin, CGFloat lengthOfSide){
    W6_Square square;
    square.origin = origin;
    square.lengthOfSide = lengthOfSide;
    return square;
}
@implementation WliuHeadPortraitImageView
#pragma mark - Initializes reset
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isLoadNib = NO;
        _isDefaultInit = YES;
        _cornerRadiusIsChanged = NO;
        _isCustomCornerRadius = NO;
        self.userInteractionEnabled = YES;
        [self configureMaskViewWithSize:self.frame.size];
        [self configureHighlightProperties];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _isLoadNib = YES;
        _isDefaultInit = NO;
        _cornerRadiusIsChanged = NO;
        _isCustomCornerRadius = NO;
        self.userInteractionEnabled = YES;
        [self configureMaskViewWithSize:self.frame.size];
        [self configureHighlightProperties];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    W6_Square square = [self w6_reallyFrameWithFrame:frame];
    CGRect reallyFrame = CGRectMake(square.origin.x, square.origin.y, square.lengthOfSide, square.lengthOfSide);
    _radius = square.lengthOfSide / 2;
    self = [super initWithFrame:reallyFrame];
    if (self) {
        self.layer.cornerRadius = _radius;
        self.layer.masksToBounds = YES;
        _isLoadNib = NO;
        _isDefaultInit = NO;
        _cornerRadiusIsChanged = NO;
        _isCustomCornerRadius = NO;
        self.userInteractionEnabled = YES;
        [self configureMaskViewWithSize:self.frame.size];
        [self configureHighlightProperties];
    }
    return self;
}
#pragma mark - super class methdo reset
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_isLoadNib) {
        CGRect rect = self.frame;
        self.frame = rect;
    }
}
#pragma mark - properties reset
- (void)setFrame:(CGRect)frame
{
    W6_Square square = [self w6_reallyFrameWithFrame:frame];
    CGRect reallyFrame = CGRectMake(square.origin.x, square.origin.y, square.lengthOfSide, square.lengthOfSide);
    CGFloat lengthOfSide = square.lengthOfSide;
    [super setFrame:reallyFrame];
    _radius = lengthOfSide / 2;
    __weak typeof(self) wself = self;
    if (wself) {
        if (!_isCustomCornerRadius) {
            wself.layer.cornerRadius = _radius;
        }
        wself.layer.masksToBounds = YES;
        if (_isLoadNib || _isDefaultInit) {
            if (_maskView) {
                _maskView.frame = CGRectMake(_maskView.frame.origin.x, _maskView.frame.origin.y, reallyFrame.size.width, reallyFrame.size.height);
            }
        }
    }
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (!cornerRadius) return;
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    if (_isLoadNib) {
        _isCustomCornerRadius = YES;
    }
    _cornerRadiusIsChanged = YES;
}
#pragma mark -- default configure
- (void)setBorderColor:(UIColor *)borderColor
{
    if (borderColor) {
        __weak typeof(self) wself = self;
        if (wself) {
            wself.layer.borderColor = borderColor.CGColor;
        }
        _borderColor = borderColor;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (borderWidth) {
        __weak typeof(self) wself = self;
        if (borderWidth < W6_CARendering_MinPoint) {
            borderWidth = W6_CARendering_MinPoint;
        }
        if (wself) {
            wself.layer.borderWidth = borderWidth;
        }
        _borderWidth = borderWidth;
    }
}

- (void)setMaskAlpha:(CGFloat)maskAlpha
{
    if (!maskAlpha) return;
    if (maskAlpha > 1.0f) {
        _maskAlpha = 1;
        return;
    }
    _maskAlpha = maskAlpha;
    [self checkMaskView];
    _maskView.alpha = maskAlpha;
}

- (void)setMaskBGColor:(UIColor *)maskBGColor
{
    if (!maskBGColor) return;
    _maskBGColor = maskBGColor;
    [self checkMaskView];
    _maskView.backgroundColor = maskBGColor;
}
#pragma mark -- highlight configure
- (void)setHighlightBorderWidth:(CGFloat)highlightBorderWidth
{
    if (highlightBorderWidth) {
        if (highlightBorderWidth < W6_CARendering_MinPoint) {
            highlightBorderWidth = W6_CARendering_MinPoint;
        }
        _highlightBorderWidth = highlightBorderWidth;
    }
}
- (void)setHighlightMaskAlpha:(CGFloat)highlightMaskAlpha
{
    if (!highlightMaskAlpha) return;
    if (highlightMaskAlpha > 1.0f) {
        _highlightMaskAlpha = 1;
        return;
    }
    _highlightMaskAlpha = highlightMaskAlpha;
}
#pragma mark - 'UIResponder' method reset
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [self touchPoint:touches];
    if ([self checkPointInRoundWithPoint:point RoundRadius:_radius]) {
        [self w6_configureHighlight];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint point = [self touchPoint:touches];
    if ([self checkPointInRoundWithPoint:point RoundRadius:_radius]) {
        [self w6_configureHighlight];
    }else{
        [self touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self w6_configureDefault];
    CGPoint point = [self touchPoint:touches];
    if ([self checkPointInRoundWithPoint:point RoundRadius:_radius]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(w6_isClicked)]) {
            [self.delegate w6_isClicked];
        }
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self w6_configureDefault];
}
#pragma mark - own private method
- (void)w6_configureDefault
{
    __weak typeof(self) wself = self;
    if (wself) {
        wself.layer.borderWidth = self.borderWidth;
        wself.layer.borderColor = self.borderColor.CGColor;
        if (_maskView) {
            _maskView.backgroundColor = self.maskBGColor;
            _maskView.alpha = self.maskAlpha;
        }
    }
}
- (void)w6_configureHighlight
{
    __weak typeof(self) wself = self;
    if (wself) {
        wself.layer.borderWidth = self.highlightBorderWidth;
        wself.layer.borderColor = self.highlightBorderColor.CGColor;
        if (_maskView) {
            _maskView.backgroundColor = self.highlightMaskBGColor;
            _maskView.alpha = self.highlightMaskAlpha;
        }
    }
}
- (CGPoint)touchPoint:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    return point;
}
- (BOOL)checkPointInRoundWithPoint:(CGPoint)point RoundRadius:(CGFloat)radius
{
    BOOL result = NO;
    CGPoint abstractCenter = CGPointMake(radius, radius);
    CGFloat diff_x = abstractCenter.x - point.x;
    CGFloat diff_y = abstractCenter.y - point.y;
    if (_cornerRadiusIsChanged) {
        CGFloat diagonalRadius = radius - self.cornerRadius;
        result = (hypot(diagonalRadius, diagonalRadius) + self.cornerRadius >= hypot(diff_x , diff_y)) && (fabs(diff_x) || fabs(diff_y));
    }else{
        result = (radius >= hypot(diff_x , diff_y));
    }
    return result;
}
- (void)checkMaskView
{
    NSAssert(_maskView, @"\n please check whether current view has correct frame  \n 请正确的初始化，检查当前view的frame是否正确 \n");
}
#pragma mark -- struct method
- (W6_Side)w6_CornerRadiusWithSize:(CGSize)size
{
    CGFloat width = size.width;
    CGFloat height = size.height;
    return W6_MakeSide(width >= height ? height : width, width >= height ? W6_centerHorizontalOrientation : W6_centerVerticalOrientation, width >= height ? (width - height) / 2 : (height - width) / 2);
}
- (W6_Square)w6_reallyFrameWithFrame:(CGRect)frame
{
    W6_Side side = [self w6_CornerRadiusWithSize:frame.size];
    CGFloat lengthOfSide = side.lengthOfSide;
    CGFloat originX = frame.origin.x;
    CGFloat originY = frame.origin.y;
    switch (side.offsetOrientation) {
        case W6_centerHorizontalOrientation:
        {
            originX += side.offset;
        }
            break;
        case W6_centerVerticalOrientation:
        {
            originY += side.offset;
        }
            break;
        default:
            break;
    }
    return W6_MakeSquare(CGPointMake(originX, originY), lengthOfSide);
}
#pragma mark - mask view method
- (void)configureMaskViewWithSize:(CGSize)size
{
    if (_maskView) return;
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    _maskView.backgroundColor = W6_MaskViewDefaultBackgroundColor;
    _maskView.alpha = W6_MaskViewDefaultAlpha;
    [self addSubview:_maskView];
}
#pragma mark - highlight
- (void)configureHighlightProperties
{
    self.highlightMaskAlpha = 0.0f;
    self.highlightBorderWidth = 0.0f;
    self.highlightBorderColor = [UIColor clearColor];
    self.highlightMaskBGColor = [UIColor clearColor];
}

@end