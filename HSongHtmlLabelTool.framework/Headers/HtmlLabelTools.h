//
//  Html2LabelTools.h
//  YaoYaoDemo
//
//  Created by Wanglei on 2024/4/19.
//

#import <Foundation/Foundation.h>

//获取屏幕的大小
#define ZSToolScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ZSToolScreenHeight [UIScreen mainScreen].bounds.size.height


NS_ASSUME_NONNULL_BEGIN

@interface HtmlLabelTools : NSObject

+ (NSAttributedString *)getAttributedStringWithHtml:(NSString *)htmlString;
//使用HtmlString,和最大左右间距，计算视图的高度
+ (CGFloat)getAttributedTextHeightHtml:(NSString *)htmlString with_viewMaxRect:(CGRect)_viewMaxRect;

+ (CGRect)getAuxRectWithWidth: (CGFloat)width;

@end

NS_ASSUME_NONNULL_END
