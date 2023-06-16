//
//  MKSwiftMutableAttributeHelper.m
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

#import "MKSwiftMutableAttributeHelper.h"
#import <CoreText/CoreText.h>

@implementation NSParagraphStyle (MKSwiftMutableAttributeHelper)

+ (NSParagraphStyle *)mk_styleWithCTStyle:(CTParagraphStyleRef)CTStyle {
    if (CTStyle == NULL) return nil;
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat lineSpacing;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing)) {
        style.lineSpacing = lineSpacing;
    }
#pragma clang diagnostic pop
    
    CGFloat paragraphSpacing;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing)) {
        style.paragraphSpacing = paragraphSpacing;
    }
    
    CTTextAlignment alignment;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment)) {
        style.alignment = NSTextAlignmentFromCTTextAlignment(alignment);
    }
    
    CGFloat firstLineHeadIndent;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &firstLineHeadIndent)) {
        style.firstLineHeadIndent = firstLineHeadIndent;
    }
    
    CGFloat headIndent;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierHeadIndent, sizeof(CGFloat), &headIndent)) {
        style.headIndent = headIndent;
    }
    
    CGFloat tailIndent;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierTailIndent, sizeof(CGFloat), &tailIndent)) {
        style.tailIndent = tailIndent;
    }
    
    CTLineBreakMode lineBreakMode;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierLineBreakMode, sizeof(CTLineBreakMode), &lineBreakMode)) {
        style.lineBreakMode = (NSLineBreakMode)lineBreakMode;
    }
    
    CGFloat minimumLineHeight;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &minimumLineHeight)) {
        style.minimumLineHeight = minimumLineHeight;
    }
    
    CGFloat maximumLineHeight;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &maximumLineHeight)) {
        style.maximumLineHeight = maximumLineHeight;
    }
    
    CTWritingDirection baseWritingDirection;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierBaseWritingDirection, sizeof(CTWritingDirection), &baseWritingDirection)) {
        style.baseWritingDirection = (NSWritingDirection)baseWritingDirection;
    }
    
    CGFloat lineHeightMultiple;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierLineHeightMultiple, sizeof(CGFloat), &lineHeightMultiple)) {
        style.lineHeightMultiple = lineHeightMultiple;
    }
    
    CGFloat paragraphSpacingBefore;
    if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &paragraphSpacingBefore)) {
        style.paragraphSpacingBefore = paragraphSpacingBefore;
    }
    
    if ([style respondsToSelector:@selector(tabStops)]) {
        CFArrayRef tabStops;
        if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierTabStops, sizeof(CFArrayRef), &tabStops)) {
            if ([style respondsToSelector:@selector(setTabStops:)]) {
                NSMutableArray *tabs = [NSMutableArray new];
                [((__bridge NSArray *)(tabStops))enumerateObjectsUsingBlock : ^(id obj, NSUInteger idx, BOOL *stop) {
                    CTTextTabRef ctTab = (__bridge CFTypeRef)obj;
                    
                    NSTextTab *tab = [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentFromCTTextAlignment(CTTextTabGetAlignment(ctTab)) location:CTTextTabGetLocation(ctTab) options:(__bridge id)CTTextTabGetOptions(ctTab)];
                    [tabs addObject:tab];
                }];
                if (tabs.count) {
                    style.tabStops = tabs;
                }
            }
        }
        
        CGFloat defaultTabInterval;
        if (CTParagraphStyleGetValueForSpecifier(CTStyle, kCTParagraphStyleSpecifierDefaultTabInterval, sizeof(CGFloat), &defaultTabInterval)) {
            if ([style respondsToSelector:@selector(setDefaultTabInterval:)]) {
                style.defaultTabInterval = defaultTabInterval;
            }
        }
    }
    
    return style;
}

@end

@implementation MKSwiftMutableAttributeHelper

#pragma mark - Private

#define MKParagraphStyleSet(target, _attr_) \
[target enumerateAttribute:NSParagraphStyleAttributeName \
                 inRange:range \
                 options:kNilOptions \
              usingBlock: ^(NSParagraphStyle *value, NSRange subRange, BOOL *stop) { \
                  NSMutableParagraphStyle *style = nil; \
                  if (value) { \
                      if (CFGetTypeID((__bridge CFTypeRef)(value)) == CTParagraphStyleGetTypeID()) { \
                          value = [NSParagraphStyle mk_styleWithCTStyle:(__bridge CTParagraphStyleRef)(value)]; \
                      } \
                      if (value. _attr_ == _attr_) return; \
                      if ([value isKindOfClass:[NSMutableParagraphStyle class]]) { \
                          style = (id)value; \
                      } else { \
                          style = value.mutableCopy; \
                      } \
                  } else { \
                      if ([NSParagraphStyle defaultParagraphStyle]. _attr_ == _attr_) return; \
                      style = [NSParagraphStyle defaultParagraphStyle].mutableCopy; \
                  } \
                  style. _attr_ = _attr_; \
                    [MKSwiftMutableAttributeHelper mutableAttribute:target setParagraphStyle:style range:subRange]; \
              }];

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute setParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    
    if (paragraphStyle && [paragraphStyle isKindOfClass:NSParagraphStyle.class]) {
        [mutableAttribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    } else {
        [mutableAttribute removeAttribute:NSParagraphStyleAttributeName range:range];
    }
}

#pragma mark - Public

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute alignment:(NSTextAlignment)alignment range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, alignment);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute lineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, lineBreakMode);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute lineSpacing:(CGFloat)lineSpacing range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, lineSpacing);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute paragraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, paragraphSpacing);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute paragraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, paragraphSpacingBefore);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute firstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, firstLineHeadIndent);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute headIndent:(CGFloat)headIndent range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, headIndent);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute tailIndent:(CGFloat)tailIndent range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, tailIndent);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute minimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, minimumLineHeight);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute maximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, maximumLineHeight);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute lineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, lineHeightMultiple);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute baseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, baseWritingDirection);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute hyphenationFactor:(float)hyphenationFactor range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, hyphenationFactor);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute defaultTabInterval:(float)defaultTabInterval range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, defaultTabInterval);
}

+ (void)mutableAttribute:(NSMutableAttributedString *)mutableAttribute tabStops:(NSArray *)tabStops range:(NSRange)range {
    MKParagraphStyleSet(mutableAttribute, tabStops);
}

@end
