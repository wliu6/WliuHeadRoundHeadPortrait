//
//  WliuHeadPortraitImageView.h
//  RoundHeadPortrait
//
//  Created by 66 on 15/8/14.
//  Copyright (c) 2015年 w66. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WliuHeadPortraitImageViewDelegate <NSObject>

@optional
- (void)w6_isClicked;

@end
IB_DESIGNABLE
@interface WliuHeadPortraitImageView : UIImageView
/*!
 *  @author 66, 15-08-18
 *
 *  @brief  click delegate
 *
 *  @since version number 1.0
 */
@property(nonatomic,assign) IBOutlet id<WliuHeadPortraitImageViewDelegate> delegate;
#pragma mark - default configure
/*!
 *  @author 66, 15-08-14
 *
 *  @brief  The color of the WliuHeadPortraitImageView's border
 *
 *  @since version number 1.0
 */
@property(nonatomic,strong) IBInspectable UIColor *borderColor;
/*!
 *  @author 66, 15-08-14
 *
 *  @brief  The width of the WliuHeadPortraitImageView's border.
 *
 *  @since version number 1.0
 */
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
/*!
 *  @author 66, 15-08-18
 *
 *  @brief  The alpha of WliuHeadPortraitImageView's mask view, you can used it when night theme...
 *
 *  @since version number 1.0
 */
@property(nonatomic,assign) IBInspectable CGFloat maskAlpha;//defalult is 0
/*!
 *  @author 66, 15-08-18
 *
 *  @brief  The background color of WliuHeadPortraitImageView's mask view, you can used it when night theme...
 *
 *  @since version number 1.0
 */
@property(nonatomic,strong) IBInspectable UIColor *maskBGColor;//defalult is clear color
#pragma mark - highlight configure
/*!
 *  @author 66, 15-08-14
 *
 *  @brief  The color of the WliuHeadPortraitImageView's border
 *
 *  @since version number 1.0
 */
@property(nonatomic,strong) IBInspectable UIColor *highlightBorderColor;//defalult is clear color
/*!
 *  @author 66, 15-08-14
 *
 *  @brief  The width of the WliuHeadPortraitImageView's border.
 *
 *  @since version number 1.0
 */
@property(nonatomic,assign) IBInspectable CGFloat highlightBorderWidth;//default is 0
/*!
 *  @author 66, 15-08-18
 *
 *  @brief  The alpha of WliuHeadPortraitImageView's mask view, you can used it when night theme...
 *
 *  @since version number 1.0
 */
@property(nonatomic,assign) IBInspectable CGFloat highlightMaskAlpha;// default is 0
/*!
 *  @author 66, 15-08-18
 *
 *  @brief  The background color of WliuHeadPortraitImageView's mask view, you can used it when night theme...
 *
 *  @since version number 1.0
 */
@property(nonatomic,strong) IBInspectable UIColor *highlightMaskBGColor;// default is clear color
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@end
