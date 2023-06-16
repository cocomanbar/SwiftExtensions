//
//  MKSwiftMutableAttributeHelper.h
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSwiftMutableAttributeHelper : NSObject

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute alignment:(NSTextAlignment)alignment range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute lineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute lineSpacing:(CGFloat)lineSpacing range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute paragraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute paragraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute firstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute headIndent:(CGFloat)headIndent range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute tailIndent:(CGFloat)tailIndent range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute minimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute maximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute lineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute baseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute hyphenationFactor:(float)hyphenationFactor range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute defaultTabInterval:(float)defaultTabInterval range:(NSRange)range;
+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute tabStops:(nullable NSArray *)tabStops range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
