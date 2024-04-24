//
//  Html2LabelTools.m
//  YaoYaoDemo
//
//  Created by Wanglei on 2024/4/19.
//

#import "HtmlLabelTools.h"
#import <DTCoreText/DTCoreText.h>

@implementation HtmlLabelTools

//Html->富文本NSAttributedString
+ (NSAttributedString *)getAttributedStringWithHtml:(NSString *)htmlString{
    //获取富文本
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    return attributedString;
}

//使用HtmlString,和最大左右间距，计算视图的高度
+ (CGFloat)getAttributedTextHeightHtml:(NSString *)htmlString with_viewMaxRect:(CGRect)_viewMaxRect{
    //获取富文本
    NSAttributedString *attributedString =  [self getAttributedStringWithHtml:htmlString];
    //获取布局器
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    NSRange entireString = NSMakeRange(0, [attributedString length]);
    //获取Frame
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:_viewMaxRect range:entireString];
    //得到大小
    CGSize sizeNeeded = [layoutFrame frame].size;
    return sizeNeeded.height;
}

+ (CGRect)getAuxRectWithWidth:(CGFloat)width {
    return CGRectMake(15, 200, width, CGFLOAT_HEIGHT_UNKNOWN);
}

@end
