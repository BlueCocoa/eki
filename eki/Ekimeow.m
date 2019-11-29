//
//  Ekimeow.m
//  eki
//
//  Created by Cocoa on 2017/11/11.
//  Copyright © 2017 Cocoa. All rights reserved.
//

#import "Ekimeow.h"

@implementation EkiInfo
@synthesize nameKana;
@synthesize nameRoman;
@synthesize nameKanji;
@synthesize secondaryNameKanji;
@synthesize lineColor;
@synthesize coding;

+ (EkiInfo *)infoWithKana:(NSString *)kana roman:(NSString *)roman kanji:(NSString *)kanji coding:(NSString *)coding {
    EkiInfo * info = [[EkiInfo alloc] init];
    [info setNameKana:kana];
    [info setNameRoman:roman];
    [info setNameKanji:kanji];
    [info setCoding:coding];
    return info;
}

+ (EkiInfo *)infoWithKana:(NSString *)kana roman:(NSString *)roman kanji:(NSString *)kanji secondaryNameKanji:(NSString *)secondaryKanji lineColor:(NSColor *)color coding:(NSString *)coding {
    EkiInfo * info = [[EkiInfo alloc] init];
    [info setNameKana:kana];
    [info setNameRoman:roman];
    [info setNameKanji:kanji];
    [info setSecondaryNameKanji:secondaryKanji];
    [info setLineColor:color];
    [info setCoding:coding];
    return info;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<EkiInfo: %p>\nEki Name: %@\n          %@\n          %@", self, self.nameKanji, self.nameKana, self.nameRoman];
}

@end

@implementation Ekimeow

+ (NSDictionary *)ekiWithConfiguration:(NSDictionary *)config {
    NSLog(@"config: %@", config);
    NSString * style = [config valueForKey:@"style"];
    if ([style isEqualToString:@"hankyu"]) {
        return @{@"png":[self ekiWithHankyu:config],
                 @"svg":[self ekiWithHankyuSVG:config]};
    } else if ([style isEqualToString:@"tokyometro"]) {
        return @{@"png":[self ekiWithTokyoMetro:config],
                 @"svg":[self ekiWithTokyoMetroSVG:config]};
    } else if ([style isEqualToString:@"keisei"]) {
        return @{@"png":[self ekiWithKeisei:config],
                 @"svg":[self ekiWithKeiseiSVG:config]};
    } else if ([style isEqualToString:@"izu"]) {
        return @{@"png":[self ekiWithIzu:config],
                 @"svg":[self ekiWithIzuSVG:config]};
    } else if ([style isEqualToString:@"jreast"]) {
        return @{@"png":[self ekiWithJREast:config],
                 @"svg":[self ekiWithJREastSVG:config]};
    } else if ([style isEqualToString:@"jrc"]) {
        return @{@"png":[self ekiWithJRC:config],
                 @"svg":[self ekiWithJRCSVG:config]};
    }
    return nil;
}

#pragma mark
#pragma mark - Hankyu

+ (NSString *)ekiWithHankyuSVG:(NSDictionary *)config {
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    NSString * SVG = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n\
<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"602\" height=\"362\"  xml:space=\"preserve\" id=\"Hankyu\">\n\
<!-- Made with ❤️ by Cocoa -->\n\
    <rect id=\"hankyu-ekiBackground\" stroke=\"none\" fill=\"rgb(25, 9, 81)\" x=\"1\" y=\"1\" width=\"600\" height=\"360\" rx=\"20\" />\n\
    <rect id=\"hankyu-segmention\" stroke=\"none\" fill=\"rgb(255, 255, 255)\" x=\"25\" y=\"252\" width=\"552\" height=\"2\" />\n\
    <path id=\"hankyu-previousEkiArrow\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-linecap=\"round\" stroke-linejoin=\"bevel\" stroke-miterlimit=\"10\" fill=\"rgb(160, 30, 0)\" d=\"M 25,309 L 71,284 55,309 71,334 25,309\" />\n\
    <path id=\"hankyu-nextEkiArrow\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-linecap=\"round\" stroke-linejoin=\"bevel\" stroke-miterlimit=\"10\" fill=\"rgb(160, 30, 0)\" d=\"M 577,309 L 531,284 547,309 531,334 577,309\" />\n";
    
    if (previous) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"21\" x=\"80\" y=\"284\"><tspan x=\"80\" y=\"302\">%@</tspan></text>\n    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"16\" x=\"81\" y=\"309\"><tspan x=\"81\" y=\"327\">%@</tspan></text>\n", previous.nameKana, previous.nameRoman];
    }
    
    if (current) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"56\" x=\"133\" y=\"47\" text-anchor=\"middle\"><tspan x=\"301\" y=\"96\">%@</tspan></text>\n    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"32\" x=\"236.42\" y=\"110\" text-anchor=\"middle\"><tspan x=\"301\" y=\"138\">%@</tspan></text>\n    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"40\" x=\"152.46\" y=\"189\" text-anchor=\"middle\"><tspan x=\"301\" y=\"228\">%@</tspan></text>\n", current.nameKana, current.nameKanji, current.nameRoman.uppercaseString];
        if (current.secondaryNameKanji.length > 0) {
            SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"32\" x=\"181.83\" y=\"145\" text-anchor=\"middle\"><tspan x=\"301\" y=\"176\">（%@）</tspan></text>\n", current.secondaryNameKanji];
        }
    }
    
    if (next) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"21\" x=\"376\" y=\"284\" text-anchor=\"end\"><tspan x=\"523\" y=\"302\">%@</tspan></text>\n    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMinPro-W6, 'Hiragino Mincho Pro', sans-serif\" font-size=\"16\" x=\"425.38\" y=\"309\" text-anchor=\"end\"><tspan x=\"523\" y=\"327\">%@</tspan></text>\n", next.nameKana, next.nameRoman.uppercaseString];
    }
    
    return [SVG stringByAppendingString:@"</svg>"];
}

+ (NSImage *)ekiWithHankyu:(NSDictionary *)config {
    double scale = 1.0;
    if ([config valueForKey:@"scale"] != nil) {
        scale = [[config valueForKey:@"scale"] doubleValue];
    }
    
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    CGFloat width = 600.0 * scale;
    CGFloat height = 360.0 * scale;
    NSRect imgRect = NSMakeRect(0.0, 0.0, width + 2, height + 2);
    NSSize imgSize = imgRect.size;
    
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc]
                                       initWithBitmapDataPlanes:NULL
                                       pixelsWide:imgSize.width
                                       pixelsHigh:imgSize.height
                                       bitsPerSample:8
                                       samplesPerPixel:4
                                       hasAlpha:YES
                                       isPlanar:NO
                                       colorSpaceName:NSDeviceRGBColorSpace
                                       bitmapFormat:NSAlphaFirstBitmapFormat
                                       bytesPerRow:0
                                       bitsPerPixel:0] ;
    
    //// set offscreen context
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];
    [NSGraphicsContext setCurrentContext:g];
    
    NSImage *img = [[NSImage alloc] initWithSize:imgSize];
    
    //// lock and draw
    [img lockFocus];
    
    //// Color Declarations
    NSColor* color1 = [NSColor colorWithCalibratedRed: 0.074 green: 0 blue: 0.248 alpha: 1];
    NSColor* color2 = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
    NSColor* color3 = [NSColor colorWithCalibratedRed: 0.55 green: 0.061 blue: 0.012 alpha: 1];
    
    //// eki background Drawing
    NSBezierPath* ekiBackgroundPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(1, 1, width, height) xRadius: 20*scale yRadius: 20*scale];
    [color1 setFill];
    [ekiBackgroundPath fill];
    
    
    //// segmention Drawing
    CGFloat segmentionPadding = 25.0*scale;
    CGFloat segemntionYPosition  = 108.0*scale;
    CGFloat segemntionHeight  = 2.0*scale;
    NSBezierPath* segmentionPath = [NSBezierPath bezierPathWithRect: NSMakeRect(segmentionPadding, segemntionYPosition, width - segmentionPadding * 2, segemntionHeight)];
    [color2 setFill];
    [segmentionPath fill];
    
    if (previous) {
        //// Previous Eki Arrow Drawing
        CGFloat previousEkiArrowPadding = 25.0*scale;
        CGFloat previousEkiArrowStartingY = 53.0*scale;
        CGFloat previousEkiArrowWidth = 46.0*scale;
        CGFloat previousEkiArrowHalfHeight = 25.0*scale;
        CGFloat previousEkiArrowIndent = 30.0*scale;
        
        NSBezierPath* previousEkiArrowPath = [NSBezierPath bezierPath];
        [previousEkiArrowPath moveToPoint: NSMakePoint(previousEkiArrowPadding, previousEkiArrowStartingY)];
        [previousEkiArrowPath lineToPoint: NSMakePoint(previousEkiArrowPadding + previousEkiArrowWidth, previousEkiArrowStartingY + previousEkiArrowHalfHeight)];
        [previousEkiArrowPath lineToPoint: NSMakePoint(previousEkiArrowPadding + previousEkiArrowIndent, previousEkiArrowStartingY)];
        [previousEkiArrowPath lineToPoint: NSMakePoint(previousEkiArrowPadding + previousEkiArrowWidth, previousEkiArrowStartingY - previousEkiArrowHalfHeight)];
        [previousEkiArrowPath lineToPoint: NSMakePoint(previousEkiArrowPadding, previousEkiArrowStartingY)];
        [color3 setFill];
        [previousEkiArrowPath fill];
        [NSColor.whiteColor setStroke];
        previousEkiArrowPath.lineWidth = 1*scale;
        previousEkiArrowPath.lineCapStyle = NSRoundLineCapStyle;
        previousEkiArrowPath.lineJoinStyle = NSBevelLineJoinStyle;
        [previousEkiArrowPath stroke];
        
        //// Previous Eki Name Drawing
        CGFloat previousEkiNameStartingX = 80.0*scale;
        CGFloat previousEkiNameStartingY = 53.0*scale;
        CGFloat previousEkiNameWidth = 221.0*scale;
        CGFloat previousEkiNameHeight = 25.0*scale;
        
        NSRect previousEkiNameRect = NSMakeRect(previousEkiNameStartingX, previousEkiNameStartingY, previousEkiNameWidth, previousEkiNameHeight);
        NSMutableParagraphStyle* previousEkiNameStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 21*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: previousEkiNameStyle};
        
        [previous.nameKana drawInRect: NSOffsetRect(previousEkiNameRect, 0, 2) withAttributes: previousEkiNameFontAttributes];
        
        //// Previous Eki Name (Roman) Drawing
        CGFloat previousEkiNameRomanStartingX = 81.0*scale;
        CGFloat previousEkiNameRomanStartingY = 28.0*scale;
        CGFloat previousEkiNameRomanWidth = 221.0*scale;
        CGFloat previousEkiNameRomanHeight = 25.0*scale;
        
        NSRect previousEkiNameRomanRect = NSMakeRect(previousEkiNameRomanStartingX, previousEkiNameRomanStartingY, previousEkiNameRomanWidth, previousEkiNameRomanHeight);
        {
            NSString* textContent = previous.nameRoman.uppercaseString;
            NSMutableParagraphStyle* previousEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiNameRomanStyle.alignment = NSTextAlignmentLeft;
            NSDictionary* previousEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"HelveticaNeue" size: 16*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: previousEkiNameRomanStyle};
            
            CGFloat previousEkiNameRomanTextHeight = [textContent boundingRectWithSize: previousEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: previousEkiNameRomanFontAttributes].size.height;
            NSRect previousEkiNameRomanTextRect = NSMakeRect(NSMinX(previousEkiNameRomanRect), NSMinY(previousEkiNameRomanRect) + (previousEkiNameRomanRect.size.height - previousEkiNameRomanTextHeight) / 2, previousEkiNameRomanRect.size.width, previousEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(previousEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(previousEkiNameRomanTextRect, 0, 4) withAttributes: previousEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    if (current) {
        //// Eki Name Drawing
        CGFloat ekiNameStartingX = 25.0*scale;
        CGFloat ekiNameStartingY = 255.0*scale;
        CGFloat ekiNameWidth = 552.0*scale;
        CGFloat ekiNameHeight = 60.0*scale;
        
        NSRect ekiNameRect = NSMakeRect(ekiNameStartingX, ekiNameStartingY, ekiNameWidth, ekiNameHeight);
        NSMutableParagraphStyle* ekiNameStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 50*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: ekiNameStyle};
        
        [current.nameKana drawInRect: NSOffsetRect(ekiNameRect, 0, 6) withAttributes: ekiNameFontAttributes];
        
        
        //// Eki Name (kanji) Drawing
        CGFloat ekiNameKanjiStartingX = 25.0*scale;
        CGFloat ekiNameKanjiStartingY = 217.0*scale;
        CGFloat ekiNameKanjiWidth = 552.0*scale;
        CGFloat ekiNameKanjiHeight = 35.0*scale;
        
        NSRect ekiNameKanjiRect = NSMakeRect(ekiNameKanjiStartingX, ekiNameKanjiStartingY, ekiNameKanjiWidth, ekiNameKanjiHeight);
        NSMutableParagraphStyle* ekiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanjiStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 30*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: ekiNameKanjiStyle};
        
        [current.nameKanji drawInRect: NSOffsetRect(ekiNameKanjiRect, 0, 0) withAttributes: ekiNameKanjiFontAttributes];
        
        
        //// Secondary Eki Name Drawing
        if (current.secondaryNameKanji.length > 0) {
            CGFloat ekiSecondaryNameStartingX = 25.0*scale;
            CGFloat ekiSecondaryNameStartingY = 176.0*scale;
            CGFloat ekiSecondaryNameWidth = 552.0*scale;
            CGFloat ekiSecondaryNameHeight = 41.0*scale;
            
            NSRect ekiSecondaryNameRect = NSMakeRect(ekiSecondaryNameStartingX, ekiSecondaryNameStartingY, ekiSecondaryNameWidth, ekiSecondaryNameHeight);
            NSMutableParagraphStyle* ekiSecondaryNameStyle = [[NSMutableParagraphStyle alloc] init];
            ekiSecondaryNameStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* ekiSecondaryNameFontAttributes = @{NSFontAttributeName: [NSFont systemFontOfSize: 32*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: ekiSecondaryNameStyle};
            
            [[NSString stringWithFormat:@"（%@）", current.secondaryNameKanji] drawInRect: NSOffsetRect(ekiSecondaryNameRect, 0, 1) withAttributes: ekiSecondaryNameFontAttributes];
        }
        
        //// Eki Name (Roman) Drawing
        CGFloat ekiNameRomanStartingX = 25.0*scale;
        CGFloat ekiNameRomanStartingY = 118.0*scale;
        CGFloat ekiNameRomanWidth = 552.0*scale;
        CGFloat ekiNameRomanHeight = 55.0*scale;
        
        NSRect ekiNameRomanRect = NSMakeRect(ekiNameRomanStartingX, ekiNameRomanStartingY, ekiNameRomanWidth, ekiNameRomanHeight);
        NSMutableParagraphStyle* ekiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameRomanStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont systemFontOfSize: 40*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: ekiNameRomanStyle};
        
        [current.nameRoman.uppercaseString drawInRect: NSOffsetRect(ekiNameRomanRect, 0, 0) withAttributes: ekiNameRomanFontAttributes];
    }
    
    if (next) {
        //// Next Eki Arrow Drawing
        CGFloat nextEkiArrowPadding = 577.0*scale;
        CGFloat nextEkiArrowStartingY = 53.0*scale;
        CGFloat nextEkiArrowWidth = 46.0*scale;
        CGFloat nextEkiArrowHalfHeight = 25.0*scale;
        CGFloat nextEkiArrowIndent = 30.0*scale;
        
        NSBezierPath* nextEkiArrowPath = [NSBezierPath bezierPath];
        [nextEkiArrowPath moveToPoint: NSMakePoint(nextEkiArrowPadding, nextEkiArrowStartingY)];
        [nextEkiArrowPath lineToPoint: NSMakePoint(nextEkiArrowPadding - nextEkiArrowWidth, nextEkiArrowStartingY + nextEkiArrowHalfHeight)];
        [nextEkiArrowPath lineToPoint: NSMakePoint(nextEkiArrowPadding - nextEkiArrowIndent, nextEkiArrowStartingY)];
        [nextEkiArrowPath lineToPoint: NSMakePoint(nextEkiArrowPadding - nextEkiArrowWidth, nextEkiArrowStartingY - nextEkiArrowHalfHeight)];
        [nextEkiArrowPath lineToPoint: NSMakePoint(nextEkiArrowPadding, nextEkiArrowStartingY)];
        [color3 setFill];
        [nextEkiArrowPath fill];
        [NSColor.whiteColor setStroke];
        nextEkiArrowPath.lineWidth = 1*scale;
        nextEkiArrowPath.lineCapStyle = NSRoundLineCapStyle;
        nextEkiArrowPath.lineJoinStyle = NSBevelLineJoinStyle;
        [nextEkiArrowPath stroke];
        
        //// Next Eki Name Drawing
        CGFloat nextEkiNameStartingX = 302.0*scale;
        CGFloat nextEkiNameStartingY = 53.0*scale;
        CGFloat nextEkiNameWidth = 221.0*scale;
        CGFloat nextEkiNameHeight = 25.0*scale;
        
        NSRect nextEkiNameRect = NSMakeRect(nextEkiNameStartingX, nextEkiNameStartingY, nextEkiNameWidth, nextEkiNameHeight);
        NSMutableParagraphStyle* nextEkiNameStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 21*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: nextEkiNameStyle};
        
        [next.nameKana drawInRect: NSOffsetRect(nextEkiNameRect, 0, 2) withAttributes: nextEkiNameFontAttributes];
        
        //// Next Eki Name (Roman) Drawing
        CGFloat nextEkiNameRomanStartingX = 302.0*scale;
        CGFloat nextEkiNameRomanStartingY = 28.0*scale;
        CGFloat nextEkiNameRomanWidth = 221.0*scale;
        CGFloat nextEkiNameRomanHeight = 25.0*scale;
        
        NSRect nextEkiNameRomanRect = NSMakeRect(nextEkiNameRomanStartingX, nextEkiNameRomanStartingY, nextEkiNameRomanWidth, nextEkiNameRomanHeight);
        {
            NSString* textContent = next.nameRoman.uppercaseString;
            NSMutableParagraphStyle* nextEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiNameRomanStyle.alignment = NSTextAlignmentRight;
            NSDictionary* nextEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"HelveticaNeue" size: 16*scale], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: nextEkiNameRomanStyle};
            
            CGFloat nextEkiNameRomanTextHeight = [textContent boundingRectWithSize: nextEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: nextEkiNameRomanFontAttributes].size.height;
            NSRect nextEkiNameRomanTextRect = NSMakeRect(NSMinX(nextEkiNameRomanRect), NSMinY(nextEkiNameRomanRect) + (nextEkiNameRomanRect.size.height - nextEkiNameRomanTextHeight) / 2, nextEkiNameRomanRect.size.width, nextEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(nextEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(nextEkiNameRomanTextRect, 0, 4) withAttributes: nextEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    [img unlockFocus];
    return img;
}

#pragma mark
#pragma mark - TokyoMetro

+ (NSString *)ekiWithTokyoMetroSVG:(NSDictionary *)config {
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    NSString * SVG = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n\
<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"240\"  xml:space=\"preserve\" id=\"TokyoMetro\">\n\
<!-- Made with ❤️ by Cocoa -->\n\
    <rect id=\"lineColor\" stroke=\"none\" fill=\"rgb(200, 27, 0)\" x=\"0\" y=\"160\" width=\"600\" height=\"80\" />\n\
    <rect id=\"whiteBackground\" stroke=\"none\" fill=\"rgb(255, 255, 255)\" x=\"0\" y=\"0\" width=\"600\" height=\"160\" />\n\
    <path id=\"nextArrow\" stroke=\"rgb(0, 0, 0)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"rgb(0, 0, 0)\" d=\"M 580,45 L 560,25 550,25 567,42 534,42 534,48 567,48 550,65 560,65 580,45 Z M 580,45\" />\n\
    <path id=\"previousArrow\" stroke=\"rgb(0, 0, 0)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"rgb(0, 0, 0)\" d=\"M 20,45 L 40,25 50,25 33,42 66,42 66,48 33,48 50,65 40,65 20,45 Z M 20,45\" />\n";
    
    if (previous) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"28\" x=\"20\" y=\"73\"><tspan x=\"20\" y=\"98\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"19\" x=\"20\" y=\"105\"><tspan x=\"20\" y=\"122\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"20\" x=\"20\" y=\"129\"><tspan x=\"20\" y=\"147\">%@</tspan></text>\n", previous.nameKanji, previous.nameKana, previous.nameRoman];
        if (previous.coding.length > 0) {
            SVG = [SVG stringByAppendingFormat:@"    <circle id=\"previousEkiCodingOutter\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"none\" cx=\"48\" cy=\"200\" r=\"27.5\" />\n    <circle id=\"previousEkiCodingInner\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"rgb(255, 255, 255)\" cx=\"48\" cy=\"200\" r=\"22.5\" />\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"20\" x=\"41.3\" y=\"177\" text-anchor=\"middle\"><tspan x=\"48.5\" y=\"195\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"20\" x=\"35.46\" y=\"199\" text-anchor=\"middle\"><tspan x=\"48.5\" y=\"217\">%@</tspan></text>\n", [previous.coding substringToIndex:1], previous.coding.length >= 1 ? [previous.coding substringFromIndex:1] : @""];
        }
    }
    
    if (current) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"56\" x=\"188\" y=\"19\" text-anchor=\"middle\"><tspan x=\"300\" y=\"68\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"25\" x=\"225.5\" y=\"89\" text-anchor=\"middle\"><tspan x=\"300.5\" y=\"111\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"25\" x=\"214.3\" y=\"126\" text-anchor=\"middle\"><tspan x=\"301\" y=\"148\">%@</tspan></text>\n", current.nameKanji, current.nameKana, current.nameRoman];
        if (current.coding.length > 0) {
            SVG = [SVG stringByAppendingFormat:@"    <circle id=\"ekiCodingOutter\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"none\" cx=\"300\" cy=\"200\" r=\"32.5\" />\n    <circle id=\"ekiCodingInner\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"rgb(255, 255, 255)\" cx=\"300\" cy=\"200\" r=\"27.5\" />\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"22\" x=\"292.58\" y=\"179\" text-anchor=\"middle\"><tspan x=\"300.5\" y=\"198\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"22\" x=\"286.66\" y=\"204\" text-anchor=\"middle\"><tspan x=\"301\" y=\"223\">%@</tspan></text>\n", [current.coding substringToIndex:1], current.coding.length >= 1 ? [current.coding substringFromIndex:1] : @""];
        }
    }
    
    if (next) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"28\" x=\"468\" y=\"73\" text-anchor=\"end\"><tspan x=\"580\" y=\"98\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"19\" x=\"447\" y=\"105\" text-anchor=\"end\"><tspan x=\"580\" y=\"122\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"20\" x=\"472\" y=\"129\" text-anchor=\"end\"><tspan x=\"580\" y=\"147\">%@</tspan></text>\n", next.nameKanji, next.nameKana, next.nameRoman];
        if (next.coding.length > 0) {
            SVG = [SVG stringByAppendingFormat:@"    <circle id=\"nextEkiCodingOutter\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"none\" cx=\"553\" cy=\"200\" r=\"27.5\" />\n    <circle id=\"nextEkiCodingInner\" stroke=\"rgb(255, 255, 255)\" stroke-width=\"1\" stroke-miterlimit=\"10\" fill=\"rgb(255, 255, 255)\" cx=\"553\" cy=\"200\" r=\"22.5\" />\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"20\" x=\"546.3\" y=\"179\" text-anchor=\"middle\"><tspan x=\"553.5\" y=\"197\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"20\" x=\"540.46\" y=\"199\" text-anchor=\"middle\"><tspan x=\"553.5\" y=\"217\">%@</tspan></text>\n", [next.coding substringToIndex:1], next.coding.length >= 1 ? [next.coding substringFromIndex:1] : @""];
        }
    }
    
    return [SVG stringByAppendingString:@"</svg>"];
}

+ (NSImage *)ekiWithTokyoMetro:(NSDictionary *)config {
    double scale = 1.0;
    if ([config valueForKey:@"scale"] != nil) {
        scale = [[config valueForKey:@"scale"] doubleValue];
    }
    
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    CGFloat width = 600.0 * scale;
    CGFloat height = 240.0 * scale;
    NSRect imgRect = NSMakeRect(0.0, 0.0, width, height);
    NSSize imgSize = imgRect.size;
    
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc]
                                      initWithBitmapDataPlanes:NULL
                                      pixelsWide:imgSize.width
                                      pixelsHigh:imgSize.height
                                      bitsPerSample:8
                                      samplesPerPixel:4
                                      hasAlpha:YES
                                      isPlanar:NO
                                      colorSpaceName:NSDeviceRGBColorSpace
                                      bitmapFormat:NSAlphaFirstBitmapFormat
                                      bytesPerRow:0
                                      bitsPerPixel:0] ;
    
    //// set offscreen context
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];
    [NSGraphicsContext setCurrentContext:g];
    
    NSImage *img = [[NSImage alloc] initWithSize:imgSize];
    
    //// lock and draw
    [img lockFocus];
    
    //// Color Declarations
    NSColor* color = [NSColor colorWithCalibratedRed: 0.726 green: 0 blue: 0.007 alpha: 1];
    NSColor* color2 = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
    NSColor* color3 = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// lineColor Drawing
    NSBezierPath* lineColorPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 0, 600*scale, 80*scale)];
    [color setFill];
    [lineColorPath fill];
    
    //// White Background Drawing
    NSBezierPath* whiteBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0*scale, 80*scale, 600*scale, 160*scale)];
    [color3 setFill];
    [whiteBackgroundPath fill];
    
    if (previous) {
        //// Previous Arrow Drawing
        NSBezierPath* previousArrowPath = [NSBezierPath bezierPath];
        [previousArrowPath moveToPoint: NSMakePoint(20*scale, 195*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(40*scale, 215*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(50*scale, 215*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(33*scale, 198*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(66*scale, 198*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(66*scale, 192*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(33*scale, 192*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(50*scale, 175*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(40*scale, 175*scale)];
        [previousArrowPath lineToPoint: NSMakePoint(20*scale, 195*scale)];
        [previousArrowPath closePath];
        [color2 setFill];
        [previousArrowPath fill];
        [NSColor.blackColor setStroke];
        previousArrowPath.lineWidth = 1*scale;
        [previousArrowPath stroke];
        
        //// Previous Eki Name Drawing
        NSRect previousEkiNameRect = NSMakeRect(20*scale, 129*scale, 175*scale, 38*scale);
        NSMutableParagraphStyle* previousEkiNameStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 28*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameStyle};
        
        [previous.nameKanji drawInRect: NSOffsetRect(previousEkiNameRect, 0, 3) withAttributes: previousEkiNameFontAttributes];
        
        
        //// Previous Eki Name (Kana) Drawing
        NSRect previousEkiNameKanaRect = NSMakeRect(20*scale, 111*scale, 218*scale, 24*scale);
        NSMutableParagraphStyle* previousEkiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameKanaStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 19*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameKanaStyle};
        
        [previous.nameKana drawInRect: NSOffsetRect(previousEkiNameKanaRect, 0, 1) withAttributes: previousEkiNameKanaFontAttributes];
        
        
        //// Previous Eki Name (Roman) Drawing
        NSRect previousEkiNameRomanRect = NSMakeRect(20*scale, 80*scale, 191*scale, 31*scale);
        NSMutableParagraphStyle* previousEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameRomanStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameRomanStyle};
        
        [previous.nameRoman drawInRect: NSOffsetRect(previousEkiNameRomanRect, 0, 1) withAttributes: previousEkiNameRomanFontAttributes];
        
        if (previous.coding.length >= 1) {
            //// Previous Eki Coding (Outter) Drawing
            NSBezierPath* previousEkiCodingOutterPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(20.5*scale, 12.5*scale, 55*scale, 55*scale)];
            [NSColor.whiteColor setStroke];
            previousEkiCodingOutterPath.lineWidth = 1*scale;
            [previousEkiCodingOutterPath stroke];
            
            //// Previous Eki Coding (Inner) Drawing
            NSBezierPath* previousEkiCodingInnerPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(25.5*scale, 17.5*scale, 45*scale, 45*scale)];
            [NSColor.whiteColor setFill];
            [previousEkiCodingInnerPath fill];
            [NSColor.whiteColor setStroke];
            previousEkiCodingInnerPath.lineWidth = 1;
            [previousEkiCodingInnerPath stroke];
            
            //// Previous Eki Coding R Drawing
            NSRect previousEkiCodingRRect = NSMakeRect(39*scale, 33*scale, 19*scale, 30*scale);
            NSMutableParagraphStyle* previousEkiCodingRStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiCodingRStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* previousEkiCodingRFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiCodingRStyle};
            
            [[previous.coding substringToIndex:1] drawInRect: NSOffsetRect(previousEkiCodingRRect, 0, 1) withAttributes: previousEkiCodingRFontAttributes];
        }
        
        if (previous.coding.length > 1) {
            //// Previous Eki Coding Rest Drawing
            NSRect previousEkiCodingRestRect = NSMakeRect(4*scale, 18*scale, 89*scale, 23*scale);
            NSMutableParagraphStyle* previousEkiCodingRestStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiCodingRestStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* previousEkiCodingRestFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiCodingRestStyle};
            
            [[previous.coding substringFromIndex:1] drawInRect: NSOffsetRect(previousEkiCodingRestRect, 0, 1) withAttributes: previousEkiCodingRestFontAttributes];
        }
    }
    
    if (current) {
        //// Eki Name Drawing
        NSRect ekiNameRect = NSMakeRect(20*scale, 151*scale, 560*scale, 70*scale);
        NSMutableParagraphStyle* ekiNameStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 56*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameStyle};
        
        [current.nameKanji drawInRect: NSOffsetRect(ekiNameRect, 0, 6) withAttributes: ekiNameFontAttributes];
        
        //// Eki Name (Kana) Drawing
        NSRect ekiNameKanaRect = NSMakeRect(196*scale, 114*scale, 209*scale, 37*scale);
        NSMutableParagraphStyle* ekiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanaStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 25*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanaStyle};
        
        [current.nameKana drawInRect: NSOffsetRect(ekiNameKanaRect, 0, 2) withAttributes: ekiNameKanaFontAttributes];
        
        
        //// Eki Name (Roman) Drawing
        NSRect ekiNameRomanRect = NSMakeRect(161*scale, 83*scale, 280*scale, 31*scale);
        NSMutableParagraphStyle* ekiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameRomanStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 25*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameRomanStyle};
        
        [current.nameRoman drawInRect: NSOffsetRect(ekiNameRomanRect, 0, 2) withAttributes: ekiNameRomanFontAttributes];
        
        if (current.coding.length >= 1) {
            //// Eki Coding (Outter) Drawing
            NSBezierPath* ekiCodingOutterPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(267.5*scale, 7.5*scale, 65*scale, 65*scale)];
            [NSColor.whiteColor setStroke];
            ekiCodingOutterPath.lineWidth = 1*scale;
            [ekiCodingOutterPath stroke];
            
            
            //// Eki Coding (Inner) Drawing
            NSBezierPath* ekiCodingInnerPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(272.5*scale, 12.5*scale, 55*scale, 55*scale)];
            [NSColor.whiteColor setFill];
            [ekiCodingInnerPath fill];
            [NSColor.whiteColor setStroke];
            ekiCodingInnerPath.lineWidth = 1*scale;
            [ekiCodingInnerPath stroke];
            
            //// Eki Coding R Drawing
            NSRect ekiCodingRRect = NSMakeRect(291*scale, 31*scale, 19*scale, 30*scale);
            NSMutableParagraphStyle* ekiCodingRStyle = [[NSMutableParagraphStyle alloc] init];
            ekiCodingRStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* ekiCodingRFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 22*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiCodingRStyle};
            
            [[current.coding substringToIndex:1] drawInRect: NSOffsetRect(ekiCodingRRect, 0, 3) withAttributes: ekiCodingRFontAttributes];
        }
        
        if (current.coding.length > 1) {
            //// Eki Coding Rest Drawing
            NSRect ekiCodingRestRect = NSMakeRect(186*scale, 13*scale, 230*scale, 23*scale);
            NSMutableParagraphStyle* ekiCodingRestStyle = [[NSMutableParagraphStyle alloc] init];
            ekiCodingRestStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* ekiCodingRestFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 22*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiCodingRestStyle};
            
            [[current.coding substringFromIndex:1] drawInRect: NSOffsetRect(ekiCodingRestRect, 0, 3) withAttributes: ekiCodingRestFontAttributes];
        }
    }
    
    if (next) {
        //// Next Arrow Drawing
        NSBezierPath* nextArrowPath = [NSBezierPath bezierPath];
        [nextArrowPath moveToPoint: NSMakePoint(580*scale, 195*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(560*scale, 215*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(550*scale, 215*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(567*scale, 198*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(534*scale, 198*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(534*scale, 192*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(567*scale, 192*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(550*scale, 175*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(560*scale, 175*scale)];
        [nextArrowPath lineToPoint: NSMakePoint(580*scale, 195*scale)];
        [nextArrowPath closePath];
        [color2 setFill];
        [nextArrowPath fill];
        [NSColor.blackColor setStroke];
        nextArrowPath.lineWidth = 1*scale;
        [nextArrowPath stroke];
        
        //// Next Eki Name Drawing
        NSRect nextEkiNameRect = NSMakeRect(405*scale, 129*scale, 175*scale, 38*scale);
        NSMutableParagraphStyle* nextEkiNameStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 28*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameStyle};
        
        [next.nameKanji drawInRect: NSOffsetRect(nextEkiNameRect, 0, 3) withAttributes: nextEkiNameFontAttributes];
        
        
        //// Next Eki Name (Kana) Drawing
        NSRect nextEkiNameKanaRect = NSMakeRect(362*scale, 111*scale, 218*scale, 24*scale);
        NSMutableParagraphStyle* nextEkiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameKanaStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 19*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameKanaStyle};
        
        [next.nameKana drawInRect: NSOffsetRect(nextEkiNameKanaRect, 0, 1) withAttributes: nextEkiNameKanaFontAttributes];
        
        
        //// Next Eki Name (Roman) Drawing
        NSRect nextEkiNameRomanRect = NSMakeRect(389*scale, 80*scale, 191*scale, 31*scale);
        NSMutableParagraphStyle* nextEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameRomanStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameRomanStyle};
        
        [next.nameRoman drawInRect: NSOffsetRect(nextEkiNameRomanRect, 0, 1) withAttributes: nextEkiNameRomanFontAttributes];
        
        if (next.coding.length >= 1) {
            //// Next Eki Coding (Outter) Drawing
            NSBezierPath* nextEkiCodingOutterPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(525.5*scale, 12.5*scale, 55*scale, 55*scale)];
            [NSColor.whiteColor setStroke];
            nextEkiCodingOutterPath.lineWidth = 1*scale;
            [nextEkiCodingOutterPath stroke];
            
            //// Next Eki Coding (Inner) Drawing
            NSBezierPath* nextEkiCodingInnerPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(530.5*scale, 17.5*scale, 45*scale, 45*scale)];
            [NSColor.whiteColor setFill];
            [nextEkiCodingInnerPath fill];
            [NSColor.whiteColor setStroke];
            nextEkiCodingInnerPath.lineWidth = 1*scale;
            [nextEkiCodingInnerPath stroke];
            
            //// Next Eki Coding R Drawing
            NSRect nextEkiCodingRRect = NSMakeRect(544*scale, 31*scale, 19*scale, 30*scale);
            NSMutableParagraphStyle* nextEkiCodingRStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiCodingRStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* nextEkiCodingRFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiCodingRStyle};
            
            [[next.coding substringToIndex:1] drawInRect: NSOffsetRect(nextEkiCodingRRect, 0, 1) withAttributes: nextEkiCodingRFontAttributes];
        }
        
        if (next.coding.length > 1) {
            //// Next Eki Coding Rest Drawing
            NSRect nextEkiCodingRestRect = NSMakeRect(509*scale, 18*scale, 89*scale, 23*scale);
            NSMutableParagraphStyle* nextEkiCodingRestStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiCodingRestStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* nextEkiCodingRestFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiCodingRestStyle};
            
            [[next.coding substringFromIndex:1] drawInRect: NSOffsetRect(nextEkiCodingRestRect, 0, 1) withAttributes: nextEkiCodingRestFontAttributes];
        }
    }
    
    [img unlockFocus];
    return img;
}

#pragma mark
#pragma mark - Keisei

+ (NSString *)ekiWithKeiseiSVG:(NSDictionary *)config {
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    NSString * SVG = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n\
<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"850\" height=\"200\"  xml:space=\"preserve\" id=\"Keisei\">\n\
<!-- Made with ❤️ by Cocoa -->\n\
    <rect id=\"whiteBackground\" stroke=\"none\" fill=\"rgb(255, 255, 255)\" x=\"0\" y=\"0\" width=\"850\" height=\"200\" />\n\
    <rect id=\"previousEkiBackground\" stroke=\"none\" fill=\"rgb(49, 47, 240)\" x=\"0\" y=\"79\" width=\"196\" height=\"41\" />\n\
    <path id=\"nextEkiBackgroundPart3\" stroke=\"none\" fill=\"rgb(49, 47, 240)\" d=\"M 845,120 L 798,79 716,79 716,120 845,120 Z M 845,120\" />\n\
    <rect id=\"nextEkiBackgroundPart2\" stroke=\"none\" fill=\"rgb(49, 47, 240)\" x=\"682\" y=\"79\" width=\"29\" height=\"41\" rx=\"4\" />\n\
    <rect id=\"nextEkiBackgroundPart1\" stroke=\"none\" fill=\"rgb(49, 47, 240)\" x=\"528\" y=\"79\" width=\"149\" height=\"41\" />\n";
    
    if (previous) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(49, 47, 240)\" font-family=\"HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"14\" x=\"45\" y=\"56\"><tspan x=\"45\" y=\"73\">%@</tspan></text>\n    <text  fill=\"rgb(255, 255, 255)\" font-family=\"HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"15\" x=\"45\" y=\"87\"><tspan x=\"45\" y=\"103.5\">%@</tspan></text>\n", previous.nameKana, previous.nameRoman];
    }
    
    if (current) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(49, 47, 240)\" font-family=\"HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"70\" x=\"222\" y=\"56\" text-anchor=\"middle\"><tspan x=\"362\" y=\"118\">%@</tspan></text>\n    <text  fill=\"rgb(49, 47, 240)\" font-family=\"-apple-system, 'Helvetica Neue', Helvetica, sans-serif\" font-size=\"20\" x=\"297.16\" y=\"124\" text-anchor=\"middle\"><tspan x=\"362\" y=\"142\">%@</tspan></text>\n", current.nameKanji, current.nameRoman];
    }
    
    if (next) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(49, 47, 240)\" font-family=\"HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"14\" x=\"641.21\" y=\"56\" text-anchor=\"middle\"><tspan x=\"697\" y=\"73\">%@</tspan></text>\n    <text  fill=\"rgb(49, 47, 240)\" font-family=\"HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"14\" x=\"659.2\" y=\"120\" text-anchor=\"middle\"><tspan x=\"697\" y=\"137\">%@</tspan></text>\n", next.nameKana, next.nameRoman];
    }
    
    return [SVG stringByAppendingString:@"</svg>"];
}

+ (NSImage *)ekiWithKeisei:(NSDictionary *)config {
    double scale = 1.0;
    if ([config valueForKey:@"scale"] != nil) {
        scale = [[config valueForKey:@"scale"] doubleValue];
    }
    
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    CGFloat width = 850.0 * scale;
    CGFloat height = 200.0 * scale;
    NSRect imgRect = NSMakeRect(0.0, 0.0, width, height);
    NSSize imgSize = imgRect.size;
    
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc]
                                      initWithBitmapDataPlanes:NULL
                                      pixelsWide:imgSize.width
                                      pixelsHigh:imgSize.height
                                      bitsPerSample:8
                                      samplesPerPixel:4
                                      hasAlpha:YES
                                      isPlanar:NO
                                      colorSpaceName:NSDeviceRGBColorSpace
                                      bitmapFormat:NSAlphaFirstBitmapFormat
                                      bytesPerRow:0
                                      bitsPerPixel:0];
        
    //// set offscreen context
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];
    [NSGraphicsContext setCurrentContext:g];
        
    NSImage *img = [[NSImage alloc] initWithSize:imgSize];
        
    //// lock and draw
    [img lockFocus];
    
    //// Color Declarations
    NSColor* color = [NSColor colorWithCalibratedRed: 0.14 green: 0 blue: 0.923 alpha: 1];
    
    //// White Background Drawing
    NSBezierPath* whiteBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 0, 850*scale, 200*scale)];
    [NSColor.whiteColor setFill];
    [whiteBackgroundPath fill];
    
    //// Previous Eki Background Drawing
    NSBezierPath* previousEkiBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0*scale, 80*scale, 196*scale, 41*scale)];
    [color setFill];
    [previousEkiBackgroundPath fill];
    
    //// Next Eki Background Part 3 Drawing
    NSBezierPath* nextEkiBackgroundPart3Path = [NSBezierPath bezierPath];
    [nextEkiBackgroundPart3Path moveToPoint: NSMakePoint(845*scale, 80*scale)];
    [nextEkiBackgroundPart3Path lineToPoint: NSMakePoint(798*scale, 121*scale)];
    [nextEkiBackgroundPart3Path lineToPoint: NSMakePoint(716*scale, 121*scale)];
    [nextEkiBackgroundPart3Path lineToPoint: NSMakePoint(716*scale, 80*scale)];
    [nextEkiBackgroundPart3Path lineToPoint: NSMakePoint(845*scale, 80*scale)];
    [nextEkiBackgroundPart3Path closePath];
    [color setFill];
    [nextEkiBackgroundPart3Path fill];
    
    
    //// Next Eki Background Part 2 Drawing
    NSBezierPath* nextEkiBackgroundPart2Path = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(682*scale, 80*scale, 29*scale, 41*scale) xRadius: 4*scale yRadius: 4*scale];
    [color setFill];
    [nextEkiBackgroundPart2Path fill];
    
    
    //// Next Eki Background Part 1 Drawing
    NSBezierPath* nextEkiBackgroundPart1Path = [NSBezierPath bezierPathWithRect: NSMakeRect(528*scale, 80*scale, 149*scale, 41*scale)];
    [color setFill];
    [nextEkiBackgroundPart1Path fill];
    
    if (previous) {
        //// Previous Eki Name (Kana) Drawing
        NSRect previousEkiNameKanaRect = NSMakeRect(45*scale, 122*scale, 151*scale, 26*scale);
        {
            NSString* textContent = previous.nameKana;
            NSMutableParagraphStyle* previousEkiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiNameKanaStyle.alignment = NSTextAlignmentLeft;
            NSDictionary* previousEkiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 14*scale], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: previousEkiNameKanaStyle};
            
            CGFloat previousEkiNameKanaTextHeight = [textContent boundingRectWithSize: previousEkiNameKanaRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: previousEkiNameKanaFontAttributes].size.height;
            NSRect previousEkiNameKanaTextRect = NSMakeRect(NSMinX(previousEkiNameKanaRect), NSMinY(previousEkiNameKanaRect), previousEkiNameKanaRect.size.width, previousEkiNameKanaTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(previousEkiNameKanaRect);
            [textContent drawInRect: NSOffsetRect(previousEkiNameKanaTextRect, 0, 3) withAttributes: previousEkiNameKanaFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
        
        
        //// Previous Eki Name (Roman) Drawing
        NSRect previousEkiNameRomanRect = NSMakeRect(45*scale, 94*scale, 151*scale, 26*scale);
        {
            NSString* textContent = previous.nameRoman;
            NSMutableParagraphStyle* previousEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiNameRomanStyle.alignment = NSTextAlignmentLeft;
            NSDictionary* previousEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 15*scale], NSForegroundColorAttributeName: NSColor.whiteColor, NSParagraphStyleAttributeName: previousEkiNameRomanStyle};
            
            CGFloat previousEkiNameRomanTextHeight = [textContent boundingRectWithSize: previousEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: previousEkiNameRomanFontAttributes].size.height;
            NSRect previousEkiNameRomanTextRect = NSMakeRect(NSMinX(previousEkiNameRomanRect), NSMinY(previousEkiNameRomanRect), previousEkiNameRomanRect.size.width, previousEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(previousEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(previousEkiNameRomanTextRect, 0, 2) withAttributes: previousEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    if (current) {
        //// Eki Name (Kanji) Drawing
        NSRect ekiNameKanjiRect = NSMakeRect(201*scale, 75*scale, 322*scale, 84*scale);
        NSMutableParagraphStyle* ekiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanjiStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 70*scale], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: ekiNameKanjiStyle};
        
        [current.nameKanji drawInRect: NSOffsetRect(ekiNameKanjiRect, 0, 7) withAttributes: ekiNameKanjiFontAttributes];
        
        //// Eki Name (Roman) Drawing
        NSRect ekiNameRomanRect = NSMakeRect(201*scale, 55*scale, 322*scale, 21*scale);
        {
            NSString* textContent = current.nameRoman;
            NSMutableParagraphStyle* ekiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            ekiNameRomanStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* ekiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 20*scale], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: ekiNameRomanStyle};
            
            CGFloat ekiNameRomanTextHeight = [textContent boundingRectWithSize: ekiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: ekiNameRomanFontAttributes].size.height;
            NSRect ekiNameRomanTextRect = NSMakeRect(NSMinX(ekiNameRomanRect), NSMinY(ekiNameRomanRect) + (ekiNameRomanRect.size.height - ekiNameRomanTextHeight) / 2, ekiNameRomanRect.size.width, ekiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(ekiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(ekiNameRomanTextRect, 0, 0) withAttributes: ekiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    if (next) {
        //// Next Eki Name (Kana) Drawing
        NSRect nextEkiNameKanaRect = NSMakeRect(596*scale, 122*scale, 202*scale, 26*scale);
        {
            NSString* textContent = next.nameKana;
            NSMutableParagraphStyle* nextEkiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiNameKanaStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* nextEkiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 14*scale], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: nextEkiNameKanaStyle};
            
            CGFloat nextEkiNameKanaTextHeight = [textContent boundingRectWithSize: nextEkiNameKanaRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: nextEkiNameKanaFontAttributes].size.height;
            NSRect nextEkiNameKanaTextRect = NSMakeRect(NSMinX(nextEkiNameKanaRect), NSMinY(nextEkiNameKanaRect), nextEkiNameKanaRect.size.width, nextEkiNameKanaTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(nextEkiNameKanaRect);
            [textContent drawInRect: NSOffsetRect(nextEkiNameKanaTextRect, 0, 3) withAttributes: nextEkiNameKanaFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
        
        
        //// Next Eki Name (Roman) Drawing
        NSRect nextEkiNameRomanRect = NSMakeRect(596*scale, 61*scale, 202*scale, 26*scale);
        {
            NSString* textContent = next.nameRoman;
            NSMutableParagraphStyle* nextEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiNameRomanStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* nextEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 14*scale], NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: nextEkiNameRomanStyle};
            
            CGFloat nextEkiNameRomanTextHeight = [textContent boundingRectWithSize: nextEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: nextEkiNameRomanFontAttributes].size.height;
            NSRect nextEkiNameRomanTextRect = NSMakeRect(NSMinX(nextEkiNameRomanRect), NSMinY(nextEkiNameRomanRect), nextEkiNameRomanRect.size.width, nextEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(nextEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(nextEkiNameRomanTextRect, 0, 3) withAttributes: nextEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    [img unlockFocus];
    return img;
}

#pragma mark
#pragma mark - Izu

+ (NSString *)ekiWithIzuSVG:(NSDictionary *)config {
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    NSString * SVG = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n\
<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"240\"  xml:space=\"preserve\" id=\"Izu\">\n\
<!-- Made with ❤️ by Cocoa -->\n\
    <rect id=\"whiteBackground\" stroke=\"none\" fill=\"rgb(255, 255, 255)\" x=\"0\" y=\"0\" width=\"600\" height=\"240\" />\n\
    <path id=\"previousEkiBackground\" stroke=\"none\" fill=\"rgb(199, 27, 0)\" d=\"M 0,131 L 0,160 170,160 199,131\" />\n\
    <path id=\"nextEkiBackground\" stroke=\"none\" fill=\"rgb(39, 37, 199)\" d=\"M 430,131 L 401,160 600,160 600,131\" />\n";
    
    if (previous) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"24\" x=\"20\" y=\"164\"><tspan x=\"20\" y=\"185\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"-apple-system, 'Helvetica Neue', Helvetica, sans-serif\" font-size=\"15\" x=\"20\" y=\"195\"><tspan x=\"20\" y=\"208\">%@</tspan></text>\n", previous.nameKanji, previous.nameRoman];
    }
    
    if (current) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"56\" x=\"188\" y=\"38\" text-anchor=\"middle\"><tspan x=\"300\" y=\"87\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"23\" x=\"231\" y=\"104\" text-anchor=\"middle\"><tspan x=\"300\" y=\"124\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"21\" x=\"227.17\" y=\"133\" text-anchor=\"middle\"><tspan x=\"300\" y=\"151\">%@</tspan></text>\n", current.nameKanji, current.nameKana, current.nameRoman];
    }
    
    if (next) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"24\" x=\"484\" y=\"164\" text-anchor=\"end\"><tspan x=\"580\" y=\"185\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"-apple-system, 'Helvetica Neue', Helvetica, sans-serif\" font-size=\"15\" x=\"505.15\" y=\"195\" text-anchor=\"end\"><tspan x=\"580\" y=\"208\">%@</tspan></text>\n", next.nameKanji, next.nameRoman];
    }
    
    return [SVG stringByAppendingString:@"</svg>"];
}

+ (NSImage *)ekiWithIzu:(NSDictionary *)config {
    double scale = 1.0;
    if ([config valueForKey:@"scale"] != nil) {
        scale = [[config valueForKey:@"scale"] doubleValue];
    }
    
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    CGFloat width = 600.0 * scale;
    CGFloat height = 240.0 * scale;
    NSRect imgRect = NSMakeRect(0.0, 0.0, width, height);
    NSSize imgSize = imgRect.size;
    
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc]
                                      initWithBitmapDataPlanes:NULL
                                      pixelsWide:imgSize.width
                                      pixelsHigh:imgSize.height
                                      bitsPerSample:8
                                      samplesPerPixel:4
                                      hasAlpha:YES
                                      isPlanar:NO
                                      colorSpaceName:NSDeviceRGBColorSpace
                                      bitmapFormat:NSAlphaFirstBitmapFormat
                                      bytesPerRow:0
                                      bitsPerPixel:0];
    
    //// set offscreen context
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];
    [NSGraphicsContext setCurrentContext:g];
    
    NSImage *img = [[NSImage alloc] initWithSize:imgSize];
    
    //// lock and draw
    [img lockFocus];
    
    //// Color Declarations
    NSColor* color = [NSColor colorWithCalibratedRed: 0.11 green: 0 blue: 0.729 alpha: 1];
    NSColor* color2 = [NSColor colorWithCalibratedRed: 0.721 green: 0 blue: 0.012 alpha: 1];
    
    //// White Background Drawing
    NSBezierPath* whiteBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 0, 600*scale, 240*scale)];
    [NSColor.whiteColor setFill];
    [whiteBackgroundPath fill];
    
    
    //// Previous Eki Background Drawing
    NSBezierPath* previousEkiBackgroundPath = [NSBezierPath bezierPath];
    [previousEkiBackgroundPath moveToPoint: NSMakePoint(0, 109*scale)];
    [previousEkiBackgroundPath lineToPoint: NSMakePoint(0, 80*scale)];
    [previousEkiBackgroundPath lineToPoint: NSMakePoint(170*scale, 80*scale)];
    [previousEkiBackgroundPath lineToPoint: NSMakePoint(199*scale, 109*scale)];
    [color2 setFill];
    [previousEkiBackgroundPath fill];
    
    //// Next Eki Background Drawing
    NSBezierPath* nextEkiBackgroundPath = [NSBezierPath bezierPath];
    [nextEkiBackgroundPath moveToPoint: NSMakePoint(430*scale, 109*scale)];
    [nextEkiBackgroundPath lineToPoint: NSMakePoint(401*scale, 80*scale)];
    [nextEkiBackgroundPath lineToPoint: NSMakePoint(600*scale, 80*scale)];
    [nextEkiBackgroundPath lineToPoint: NSMakePoint(600*scale, 109*scale)];
    [color setFill];
    [nextEkiBackgroundPath fill];
    
    if (previous) {
        //// Previous Eki Name (Kanji) Drawing
        NSRect previousEkiNameKanjiRect = NSMakeRect(20*scale, 42*scale, 275*scale, 34*scale);
        NSMutableParagraphStyle* previousEkiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameKanjiStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 24*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameKanjiStyle};
        
        [previous.nameKanji drawInRect: NSOffsetRect(previousEkiNameKanjiRect, 0, 2) withAttributes: previousEkiNameKanjiFontAttributes];
        
        
        //// Previous Eki Name (Roman) Drawing
        NSRect previousEkiNameRomanRect = NSMakeRect(20*scale, 30*scale, 275*scale, 15*scale);
        {
            NSString* textContent = previous.nameRoman;
            NSMutableParagraphStyle* previousEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiNameRomanStyle.alignment = NSTextAlignmentLeft;
            NSDictionary* previousEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont systemFontOfSize: 15*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameRomanStyle};
            
            CGFloat previousEkiNameRomanTextHeight = [textContent boundingRectWithSize: previousEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: previousEkiNameRomanFontAttributes].size.height;
            NSRect previousEkiNameRomanTextRect = NSMakeRect(NSMinX(previousEkiNameRomanRect), NSMinY(previousEkiNameRomanRect) + (previousEkiNameRomanRect.size.height - previousEkiNameRomanTextHeight) / 2, previousEkiNameRomanRect.size.width, previousEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(previousEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(previousEkiNameRomanTextRect, 0, 0) withAttributes: previousEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    if (current) {
        //// Eki Name (Kanji) Drawing
        NSRect ekiNameKanjiRect = NSMakeRect(20*scale, 125*scale, 560*scale, 85*scale);
        NSMutableParagraphStyle* ekiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanjiStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 56*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanjiStyle};
        
        [current.nameKanji drawInRect: NSOffsetRect(NSInsetRect(ekiNameKanjiRect, 0, 8), 0, 6) withAttributes: ekiNameKanjiFontAttributes];
        
        
        //// Eki Name (Kana) Drawing
        NSRect ekiNameKanaRect = NSMakeRect(20*scale, 109*scale, 560*scale, 27*scale);
        NSMutableParagraphStyle* ekiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanaStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 23*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanaStyle};
        
        [current.nameKana drawInRect: NSOffsetRect(ekiNameKanaRect, 0, 3) withAttributes: ekiNameKanaFontAttributes];
        
        
        //// Eki Name (Roman) Drawing
        NSRect ekiNameRomanRect = NSMakeRect(199*scale, 80*scale, 202*scale, 29*scale);
        NSMutableParagraphStyle* ekiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameRomanStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 21*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameRomanStyle};
        
        [current.nameRoman drawInRect: NSOffsetRect(NSInsetRect(ekiNameRomanRect, 0, 2), 0, 2) withAttributes: ekiNameRomanFontAttributes];
    }
    
    if (next) {
        //// Next Eki Name (Kanji) Drawing
        NSRect nextEkiNameKanjiRect = NSMakeRect(305*scale, 42*scale, 275*scale, 34*scale);
        NSMutableParagraphStyle* nextEkiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameKanjiStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 24*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameKanjiStyle};
        
        [next.nameKanji drawInRect: NSOffsetRect(nextEkiNameKanjiRect, 0, 2) withAttributes: nextEkiNameKanjiFontAttributes];
        
        
        //// Next Eki Name (Roman) Drawing
        NSRect nextEkiNameRomanRect = NSMakeRect(305*scale, 30*scale, 275*scale, 15*scale);
        {
            NSString* textContent = next.nameRoman;
            NSMutableParagraphStyle* nextEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiNameRomanStyle.alignment = NSTextAlignmentRight;
            NSDictionary* nextEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont systemFontOfSize: 15*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameRomanStyle};
            
            CGFloat nextEkiNameRomanTextHeight = [textContent boundingRectWithSize: nextEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: nextEkiNameRomanFontAttributes].size.height;
            NSRect nextEkiNameRomanTextRect = NSMakeRect(NSMinX(nextEkiNameRomanRect), NSMinY(nextEkiNameRomanRect) + (nextEkiNameRomanRect.size.height - nextEkiNameRomanTextHeight) / 2, nextEkiNameRomanRect.size.width, nextEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(nextEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(nextEkiNameRomanTextRect, 0, 0) withAttributes: nextEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    [img unlockFocus];
    return img;
}

#pragma mark
#pragma mark - JREast

+ (NSString *)ekiWithJREastSVG:(NSDictionary *)config {
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    NSString * SVG = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n\
<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"240\"  xml:space=\"preserve\" id=\"JREast\">\n\
<!-- Made with ❤️ by Cocoa -->\n\
    <rect id=\"whiteBackground\" stroke=\"none\" fill=\"rgb(255, 255, 255)\" x=\"0\" y=\"0\" width=\"600\" height=\"240\" />\n\
    <path id=\"lineBackground\" stroke=\"none\" fill=\"rgb(30, 120, 0)\" d=\"M 0,139 L 570,139 590,160 570,180 0,180 0,139\" />\n";
    
    if (previous) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"26\" x=\"20\" y=\"145\"><tspan x=\"20\" y=\"168\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"-apple-system, 'Helvetica Neue', Helvetica, sans-serif\" font-size=\"13\" x=\"20\" y=\"188\"><tspan x=\"20\" y=\"204\">%@</tspan></text>\n", previous.nameKanji, previous.nameRoman];
    }
    
    if (current) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"62\" x=\"171.5\" y=\"34\" text-anchor=\"middle\"><tspan x=\"295.5\" y=\"89\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"25\" x=\"220.5\" y=\"102\" text-anchor=\"middle\"><tspan x=\"295.5\" y=\"124\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"25\" x=\"208.8\" y=\"186\" text-anchor=\"middle\"><tspan x=\"295.5\" y=\"208\">%@</tspan></text>\n", current.nameKanji, current.nameKana, current.nameRoman];
        NSColor * color = current.lineColor ? current.lineColor : [NSColor colorWithRed: 0.406 green: 0.767 blue: 0.249 alpha: 1];
        color = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
        SVG = [SVG stringByAppendingFormat:@"    <rect id=\"lineColor\" stroke=\"none\" fill=\"rgb(%d, %d, %d)\" x=\"275\" y=\"139\" width=\"41\" height=\"41\" />\n", (int)(color.redComponent * 255), (int)(color.greenComponent * 255), (int)(color.blueComponent * 255)];
    }
    
    if (next) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"26\" x=\"467\" y=\"145\" text-anchor=\"end\"><tspan x=\"571\" y=\"168\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"-apple-system, 'Helvetica Neue', Helvetica, sans-serif\" font-size=\"13\" x=\"504.74\" y=\"188\" text-anchor=\"end\"><tspan x=\"571\" y=\"204\">%@</tspan></text>\n", next.nameKanji, next.nameRoman];
    }
    
    return [SVG stringByAppendingString:@"</svg>"];
}

+ (NSImage *)ekiWithJREast:(NSDictionary *)config {
    double scale = 1.0;
    if ([config valueForKey:@"scale"] != nil) {
        scale = [[config valueForKey:@"scale"] doubleValue];
    }
    
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    CGFloat width = 600.0 * scale;
    CGFloat height = 240.0 * scale;
    NSRect imgRect = NSMakeRect(0.0, 0.0, width, height);
    NSSize imgSize = imgRect.size;
    
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc]
                                      initWithBitmapDataPlanes:NULL
                                      pixelsWide:imgSize.width
                                      pixelsHigh:imgSize.height
                                      bitsPerSample:8
                                      samplesPerPixel:4
                                      hasAlpha:YES
                                      isPlanar:NO
                                      colorSpaceName:NSDeviceRGBColorSpace
                                      bitmapFormat:NSAlphaFirstBitmapFormat
                                      bytesPerRow:0
                                      bitsPerPixel:0];
    
    //// set offscreen context
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];
    [NSGraphicsContext setCurrentContext:g];
    
    NSImage *img = [[NSImage alloc] initWithSize:imgSize];
    
    //// lock and draw
    [img lockFocus];
    
    //// Color Declarations
    NSColor* color = [NSColor colorWithRed: 0.118 green: 0.469 blue: 0 alpha: 1];
    NSColor* color2 = [NSColor colorWithRed: 0.406 green: 0.767 blue: 0.249 alpha: 1];
    if (current && current.lineColor) {
        color2 = current.lineColor;
    }
    
    //// White Background Drawing
    NSBezierPath* whiteBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 0, 600*scale, 240*scale)];
    [NSColor.whiteColor setFill];
    [whiteBackgroundPath fill];
    
    
    //// Line Background Drawing
    NSBezierPath* lineBackgroundPath = [NSBezierPath bezierPath];
    [lineBackgroundPath moveToPoint: NSMakePoint(0, 101*scale)];
    [lineBackgroundPath lineToPoint: NSMakePoint(570*scale, 101*scale)];
    [lineBackgroundPath lineToPoint: NSMakePoint(590*scale, 80*scale)];
    [lineBackgroundPath lineToPoint: NSMakePoint(570*scale, 60*scale)];
    [lineBackgroundPath lineToPoint: NSMakePoint(0, 60*scale)];
    [lineBackgroundPath lineToPoint: NSMakePoint(0, 101*scale)];
    [color setFill];
    [lineBackgroundPath fill];
    
    
    //// Line Color Drawing
    NSBezierPath* lineColorPath = [NSBezierPath bezierPathWithRect: NSMakeRect(275*scale, 60*scale, 41*scale, 41*scale)];
    [color2 setFill];
    [lineColorPath fill];
    
    if (previous) {
        //// Previous Eki Name (Kanji) Drawing
        NSRect previousEkiNameKanjiRect = NSMakeRect(20*scale, 60*scale, 255*scale, 41*scale);
        NSMutableParagraphStyle* previousEkiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameKanjiStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 26*scale], NSForegroundColorAttributeName: NSColor.whiteColor, NSParagraphStyleAttributeName: previousEkiNameKanjiStyle};
        
        [previous.nameKanji drawInRect: NSOffsetRect(NSInsetRect(previousEkiNameKanjiRect, 0, 6), 0, 2) withAttributes: previousEkiNameKanjiFontAttributes];
        
        //// Previous Eki Name (Roman) Drawing
        NSRect previousEkiNameRomanRect = NSMakeRect(20*scale, 30*scale, 96*scale, 22*scale);
        {
            NSString* textContent = previous.nameRoman;
            NSMutableParagraphStyle* previousEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            previousEkiNameRomanStyle.alignment = NSTextAlignmentLeft;
            NSDictionary* previousEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 14*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameRomanStyle};
            
            CGFloat previousEkiNameRomanTextHeight = [textContent boundingRectWithSize: previousEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: previousEkiNameRomanFontAttributes].size.height;
            NSRect previousEkiNameRomanTextRect = NSMakeRect(NSMinX(previousEkiNameRomanRect), NSMinY(previousEkiNameRomanRect) + (previousEkiNameRomanRect.size.height - previousEkiNameRomanTextHeight) / 2, previousEkiNameRomanRect.size.width, previousEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(previousEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(previousEkiNameRomanTextRect, 0, 1) withAttributes: previousEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    if (current) {
        //// Eki Name (Kanji) Drawing
        NSRect ekiNameKanjiRect = NSMakeRect(20*scale, 140*scale, 551*scale, 75*scale);
        NSMutableParagraphStyle* ekiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanjiStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 62*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanjiStyle};
        
        [current.nameKanji drawInRect: NSOffsetRect(ekiNameKanjiRect, 0, 5) withAttributes: ekiNameKanjiFontAttributes];
        
        
        //// Eki Name (Kana) Drawing
        NSRect ekiNameKanaRect = NSMakeRect(20*scale, 115*scale, 551*scale, 30*scale);
        NSMutableParagraphStyle* ekiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanaStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 25*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanaStyle};
        
        [current.nameKana drawInRect: NSOffsetRect(ekiNameKanaRect, 0, 2) withAttributes: ekiNameKanaFontAttributes];
        
        
        //// Eki Name (Roman) Drawing
        NSRect ekiNameRomanRect = NSMakeRect(20*scale, 26*scale, 551*scale, 30*scale);
        NSMutableParagraphStyle* ekiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameRomanStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 25*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameRomanStyle};
        
        [current.nameRoman drawInRect: NSOffsetRect(ekiNameRomanRect, 0, 2) withAttributes: ekiNameRomanFontAttributes];
    }
    
    if (next) {
        //// Next Eki Name (Kanji) Drawing
        NSRect nextEkiNameKanjiRect = NSMakeRect(316*scale, 60*scale, 255*scale, 41*scale);
        NSMutableParagraphStyle* nextEkiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameKanjiStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 26*scale], NSForegroundColorAttributeName: NSColor.whiteColor, NSParagraphStyleAttributeName: nextEkiNameKanjiStyle};
        
        [next.nameKanji drawInRect: NSOffsetRect(NSInsetRect(nextEkiNameKanjiRect, 0, 6), 0, 2) withAttributes: nextEkiNameKanjiFontAttributes];
        
        //// Next Eki Name (Roman) Drawing
        NSRect nextEkiNameRomanRect = NSMakeRect(475*scale, 30*scale, 96*scale, 22*scale);
        {
            NSString* textContent = next.nameRoman;
            NSMutableParagraphStyle* nextEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
            nextEkiNameRomanStyle.alignment = NSTextAlignmentRight;
            NSDictionary* nextEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 14*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameRomanStyle};
            
            CGFloat nextEkiNameRomanTextHeight = [textContent boundingRectWithSize: nextEkiNameRomanRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: nextEkiNameRomanFontAttributes].size.height;
            NSRect nextEkiNameRomanTextRect = NSMakeRect(NSMinX(nextEkiNameRomanRect), NSMinY(nextEkiNameRomanRect) + (nextEkiNameRomanRect.size.height - nextEkiNameRomanTextHeight) / 2, nextEkiNameRomanRect.size.width, nextEkiNameRomanTextHeight);
            [NSGraphicsContext saveGraphicsState];
            NSRectClip(nextEkiNameRomanRect);
            [textContent drawInRect: NSOffsetRect(nextEkiNameRomanTextRect, 0, 1) withAttributes: nextEkiNameRomanFontAttributes];
            [NSGraphicsContext restoreGraphicsState];
        }
    }
    
    [img unlockFocus];
    return img;
}

#pragma mark
#pragma mark - JRC

+ (NSString *)ekiWithJRCSVG:(NSDictionary *)config {
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    NSString * SVG = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n\
<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"240\"  xml:space=\"preserve\" id=\"JRC\">\n\
<!-- Made with ❤️ by Cocoa -->\n\
    <rect id=\"whiteBackground\" stroke=\"none\" fill=\"rgb(255, 255, 255)\" x=\"0\" y=\"0\" width=\"600\" height=\"240\" />\n\
    <rect id=\"ekiNameRomanBackground\" stroke=\"none\" fill=\"rgb(240, 100, 1)\" x=\"0\" y=\"125\" width=\"600\" height=\"35\" />\n\
    <path id=\"leftBraket\" stroke=\"rgb(0, 0, 0)\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-miterlimit=\"10\" fill=\"none\" d=\"M 297.5,177 C 297.5,177 290.5,182.75 290.5,188.5 290.5,194.25 297.5,200 297.5,200\" />\n\
    <path id=\"rightBraket\" stroke=\"rgb(0, 0, 0)\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-miterlimit=\"10\" fill=\"none\" d=\"M 302.5,177 C 302.5,177 309.5,184.33 309.5,188.5 309.5,194.25 302.5,200 302.5,200\" />\n";
    
    if (previous) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"25\" x=\"20\" y=\"170\"><tspan x=\"20\" y=\"192\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"15\" x=\"20\" y=\"200\"><tspan x=\"20\" y=\"213\">%@</tspan></text>\n", previous.nameKana, previous.nameRoman];
    }
    
    if (current) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"54\" x=\"138\" y=\"36\" text-anchor=\"middle\"><tspan x=\"300\" y=\"84\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"22\" x=\"256\" y=\"95\" text-anchor=\"middle\"><tspan x=\"300\" y=\"114\">%@</tspan></text>\n    <text  fill=\"rgb(255, 255, 255)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"22\" x=\"223.7\" y=\"130\" text-anchor=\"middle\"><tspan x=\"300\" y=\"149\">%@</tspan></text>\n    ", current.nameKana, current.nameKanji, current.nameRoman];
    }
    
    if (next) {
        SVG = [SVG stringByAppendingFormat:@"    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"25\" x=\"405\" y=\"170\" text-anchor=\"end\"><tspan x=\"580\" y=\"192\">%@</tspan></text>\n    <text  fill=\"rgb(0, 0, 0)\" font-family=\"'JNR_Font', HiraMaruPro-W4, 'Hiragino Maru Gothic Pro', sans-serif\" font-size=\"15\" x=\"499\" y=\"200\" text-anchor=\"end\"><tspan x=\"580\" y=\"213\">%@</tspan></text>\n", next.nameKana, next.nameRoman];
    }
    
    return [SVG stringByAppendingString:@"</svg>"];
}

+ (NSImage *)ekiWithJRC:(NSDictionary *)config {
    double scale = 1.0;
    if ([config valueForKey:@"scale"] != nil) {
        scale = [[config valueForKey:@"scale"] doubleValue];
    }
    
    EkiInfo * previous = [config valueForKey:@"previous"];
    EkiInfo * current  = [config valueForKey:@"current"];
    EkiInfo * next     = [config valueForKey:@"next"];
    
    CGFloat width = 600.0 * scale;
    CGFloat height = 240.0 * scale;
    NSRect imgRect = NSMakeRect(0.0, 0.0, width, height);
    NSSize imgSize = imgRect.size;
    
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc]
                                      initWithBitmapDataPlanes:NULL
                                      pixelsWide:imgSize.width
                                      pixelsHigh:imgSize.height
                                      bitsPerSample:8
                                      samplesPerPixel:4
                                      hasAlpha:YES
                                      isPlanar:NO
                                      colorSpaceName:NSDeviceRGBColorSpace
                                      bitmapFormat:NSAlphaFirstBitmapFormat
                                      bytesPerRow:0
                                      bitsPerPixel:0];
    
    //// set offscreen context
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];
    [NSGraphicsContext setCurrentContext:g];
    
    NSImage *img = [[NSImage alloc] initWithSize:imgSize];
    
    //// lock and draw
    [img lockFocus];
    //// Color Declarations
    NSColor* color = [NSColor colorWithRed: 0.941 green: 0.393 blue: 0.003 alpha: 1];
    
    //// White Background Drawing
    NSBezierPath* whiteBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 0, 600*scale, 240*scale)];
    [NSColor.whiteColor setFill];
    [whiteBackgroundPath fill];
    
    
    //// Eki Name Roman Background Drawing
    NSBezierPath* ekiNameRomanBackgroundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 80*scale, 600*scale, 35*scale)];
    [color setFill];
    [ekiNameRomanBackgroundPath fill];
    
    
    //// Left Braket Drawing
    NSBezierPath* leftBraketPath = [NSBezierPath bezierPath];
    [leftBraketPath moveToPoint: NSMakePoint(297.5*scale, 63*scale)];
    [leftBraketPath curveToPoint: NSMakePoint(290.5*scale, 51.5*scale) controlPoint1: NSMakePoint(297.5*scale, 63*scale) controlPoint2: NSMakePoint(290.5*scale, 57.25*scale)];
    [leftBraketPath curveToPoint: NSMakePoint(297.5*scale, 40*scale) controlPoint1: NSMakePoint(290.5*scale, 45.75*scale) controlPoint2: NSMakePoint(297.5*scale, 40*scale)];
    [NSColor.blackColor setStroke];
    leftBraketPath.lineWidth = 2*scale;
    leftBraketPath.lineCapStyle = NSRoundLineCapStyle;
    [leftBraketPath stroke];
    
    
    //// Right Braket Drawing
    NSBezierPath* rightBraketPath = [NSBezierPath bezierPath];
    [rightBraketPath moveToPoint: NSMakePoint(302.5*scale, 63*scale)];
    [rightBraketPath curveToPoint: NSMakePoint(309.5*scale, 51.5*scale) controlPoint1: NSMakePoint(302.5*scale, 63*scale) controlPoint2: NSMakePoint(309.5*scale, 55.67*scale)];
    [rightBraketPath curveToPoint: NSMakePoint(302.5*scale, 40*scale) controlPoint1: NSMakePoint(309.5*scale, 45.75*scale) controlPoint2: NSMakePoint(302.5*scale, 40*scale)];
    [NSColor.blackColor setStroke];
    rightBraketPath.lineWidth = 2*scale;
    rightBraketPath.lineCapStyle = NSRoundLineCapStyle;
    [rightBraketPath stroke];
    
    
    if (previous) {
        //// Previous Eki Name (Kana) Drawing
        NSRect previousEkiNameKanaRect = NSMakeRect(20*scale, 40*scale, 276*scale, 30*scale);
        NSMutableParagraphStyle* previousEkiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameKanaStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 25*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameKanaStyle};
        
        [previous.nameKana drawInRect: NSOffsetRect(previousEkiNameKanaRect, 0, 2) withAttributes: previousEkiNameKanaFontAttributes];
        
        
        //// Previous Eki Name (Roman) Drawing
        NSRect previousEkiNameRomanRect = NSMakeRect(20*scale, 22*scale, 276*scale, 18*scale);
        NSMutableParagraphStyle* previousEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        previousEkiNameRomanStyle.alignment = NSTextAlignmentLeft;
        NSDictionary* previousEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 15*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: previousEkiNameRomanStyle};
        
        [previous.nameRoman drawInRect: NSOffsetRect(previousEkiNameRomanRect, 0, 2) withAttributes: previousEkiNameRomanFontAttributes];
    }
    
    if (current) {
        //// Eki Name (Roman) Drawing
        NSRect ekiNameRomanRect = NSMakeRect(0, 80*scale, 600*scale, 35*scale);
        NSMutableParagraphStyle* ekiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameRomanStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 22*scale], NSForegroundColorAttributeName: NSColor.whiteColor, NSParagraphStyleAttributeName: ekiNameRomanStyle};
        
        [current.nameRoman drawInRect: NSOffsetRect(NSInsetRect(ekiNameRomanRect, 0, 5), 0, 3) withAttributes: ekiNameRomanFontAttributes];
        
        
        //// Eki Name (Kanji) Drawing
        NSRect ekiNameKanjiRect = NSMakeRect(0, 115*scale, 600*scale, 30*scale);
        NSMutableParagraphStyle* ekiNameKanjiStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanjiStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanjiFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 22*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanjiStyle};
        
        [current.nameKanji drawInRect: NSOffsetRect(ekiNameKanjiRect, 0, 3) withAttributes: ekiNameKanjiFontAttributes];
        
        
        //// Eki Name (Kana) Drawing
        NSRect ekiNameKanaRect = NSMakeRect(0, 137*scale, 600*scale, 79*scale);
        NSMutableParagraphStyle* ekiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        ekiNameKanaStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* ekiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 54*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: ekiNameKanaStyle};
        
        [current.nameKana drawInRect: NSOffsetRect(NSInsetRect(ekiNameKanaRect, 0, 5), 0, 4) withAttributes: ekiNameKanaFontAttributes];
    }
    
    if (next) {
        //// Next Eki Name (Kana) Drawing
        NSRect nextEkiNameKanaRect = NSMakeRect(304*scale, 40*scale, 276*scale, 30*scale);
        NSMutableParagraphStyle* nextEkiNameKanaStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameKanaStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameKanaFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 25*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameKanaStyle};
        
        [next.nameKana drawInRect: NSOffsetRect(nextEkiNameKanaRect, 0, 2) withAttributes: nextEkiNameKanaFontAttributes];
        
        
        //// Next Eki Name (Roman) Drawing
        NSRect nextEkiNameRomanRect = NSMakeRect(304*scale, 22*scale, 276*scale, 18*scale);
        NSMutableParagraphStyle* nextEkiNameRomanStyle = [[NSMutableParagraphStyle alloc] init];
        nextEkiNameRomanStyle.alignment = NSTextAlignmentRight;
        NSDictionary* nextEkiNameRomanFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 15*scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: nextEkiNameRomanStyle};
        
        [next.nameRoman drawInRect: NSOffsetRect(nextEkiNameRomanRect, 0, 2) withAttributes: nextEkiNameRomanFontAttributes];
    }
    
    [img unlockFocus];
    return img;
}

@end
