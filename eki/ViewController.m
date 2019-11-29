//
//  ViewController.m
//  eki
//
//  Created by Cocoa on 2017/11/11.
//  Copyright © 2017 Cocoa. All rights reserved.
//

#import "ViewController.h"
#import "EkiMeihyoPreviewController.h"
#import "Ekimeow.h"

@interface ViewController ()
@property (strong, nonatomic) NSDictionary * meihyo;
@property (strong) NSString * previous;
@property (strong) NSString * current;
@property (strong) NSString * next;
@property (strong) NSString * style;
@end

@implementation ViewController
@synthesize previousEkiNameKanjiTextField, previousEkiNameRomanTextField, previousEkiNameKanaTextField, previousEkiCodingTextField;
@synthesize nextEkiNameKanjiTextField, nextEkiNameRomanTextField, nextEkiNameKanaTextField, nextEkiCodingTextField;
@synthesize ekiNameKanjiTextField, ekiNameRomanTextField, ekiNameKanaTextField, ekiLineColorWell, ekiCodingTextField, ekiSecondaryNameTextField;
@synthesize ekiMeihyoStyleButton, ekiMeihyoScaleTextField, ekiMeihyoGenerateButton;
@synthesize meihyo;

- (void)viewDidAppear {
    self.view.window.styleMask &= ~NSWindowStyleMaskResizable;
    [self logo];
}

- (IBAction)generateEkiMeihyo:(id)sender {
    EkiInfo * previous = [EkiInfo infoWithKana:self.previousEkiNameKanaTextField.stringValue
                                         roman:self.previousEkiNameRomanTextField.stringValue
                                         kanji:self.previousEkiNameKanjiTextField.stringValue
                                        coding:self.previousEkiCodingTextField.stringValue];
    EkiInfo * current = [EkiInfo infoWithKana:self.ekiNameKanaTextField.stringValue
                                        roman:self.ekiNameRomanTextField.stringValue
                                        kanji:self.ekiNameKanjiTextField.stringValue
                           secondaryNameKanji:self.ekiSecondaryNameTextField.stringValue
                                    lineColor:self.ekiLineColorWell.color
                                       coding:self.ekiCodingTextField.stringValue];
    EkiInfo * next = [EkiInfo infoWithKana:self.nextEkiNameKanaTextField.stringValue
                                     roman:self.nextEkiNameRomanTextField.stringValue
                                     kanji:self.nextEkiNameKanjiTextField.stringValue
                                    coding:self.nextEkiCodingTextField.stringValue];
    double scale = self.ekiMeihyoScaleTextField.doubleValue;
    if (scale < 1.0) {
        scale = 1.0;
    }
    NSString * style = @[@"hankyu", @"tokyometro", @"jreast", @"jrc", @"keisei", @"izu"][self.ekiMeihyoStyleButton.indexOfSelectedItem];
    self.style = @[@"阪急電鉄", @"東京メトロ", @"JR東日本", @"JR東海", @"京成電鉄", @"伊豆急行"][self.ekiMeihyoStyleButton.indexOfSelectedItem];
    self.previous = self.previousEkiNameKanjiTextField.stringValue;
    self.current = self.ekiNameKanjiTextField.stringValue;
    self.next = self.nextEkiNameKanjiTextField.stringValue;
    self.meihyo = [Ekimeow ekiWithConfiguration:@{
                                                @"style"    : style,
                                                @"scale"    : @(scale),
                                                @"previous" : previous,
                                                @"current"  : current,
                                                @"next"     : next
                                                }];
    [self performSegueWithIdentifier:@"preview" sender:self];
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"preview"]) {
        EkiMeihyoPreviewController * previewController = segue.destinationController;
        previewController.meihyo = self.meihyo;
        previewController.style = self.style;
        previewController.previous = self.previous;
        previewController.current = self.current;
        previewController.next = self.next;
    }
}

- (NSImage *)logo {
    double scale = 4;

    CGFloat width = 512 * scale;
    CGFloat height = 512 * scale;
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
    [img lockFocus];

    //// Color Declarations
    NSColor* color = [NSColor colorWithRed: 0.268 green: 0.801 blue: 0.867 alpha: 1];
    NSColor* color3 = [NSColor colorWithRed: 0.948 green: 0.835 blue: 0.683 alpha: 1];

    //// Rectangle Drawing
    NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(57* scale, 246* scale, 400* scale, 200* scale)];
    [NSColor.whiteColor setFill];
    [rectanglePath fill];
    [NSColor.blackColor setStroke];
    rectanglePath.lineWidth = 1* scale;
    [rectanglePath stroke];


    //// Rectangle 2 Drawing
    NSBezierPath* rectangle2Path = [NSBezierPath bezierPathWithRect: NSMakeRect(57.5* scale, 291* scale, 399* scale, 37* scale)];
    [color setFill];
    [rectangle2Path fill];


    //// Bezier Drawing
    NSBezierPath* bezierPath = [NSBezierPath bezierPath];
    [bezierPath moveToPoint: NSMakePoint(419* scale, 325* scale)];
    [bezierPath lineToPoint: NSMakePoint(434* scale, 310* scale)];
    [bezierPath lineToPoint: NSMakePoint(419* scale, 295* scale)];
    [bezierPath lineToPoint: NSMakePoint(414* scale, 295* scale)];
    [bezierPath lineToPoint: NSMakePoint(427* scale, 308* scale)];
    [bezierPath lineToPoint: NSMakePoint(400* scale, 308* scale)];
    [bezierPath lineToPoint: NSMakePoint(400* scale, 312* scale)];
    [bezierPath lineToPoint: NSMakePoint(427* scale, 312* scale)];
    [bezierPath lineToPoint: NSMakePoint(414* scale, 325* scale)];
    [bezierPath lineToPoint: NSMakePoint(419* scale, 325* scale)];
    [bezierPath closePath];
    [NSColor.whiteColor setFill];
    [bezierPath fill];


    //// Bezier 2 Drawing
    NSBezierPath* bezier2Path = [NSBezierPath bezierPath];
    [bezier2Path moveToPoint: NSMakePoint(228.73* scale, 386.95* scale)];
    [bezier2Path curveToPoint: NSMakePoint(236.91* scale, 399* scale) controlPoint1: NSMakePoint(230.09* scale, 389.96* scale) controlPoint2: NSMakePoint(234.18* scale, 399* scale)];
    [bezier2Path curveToPoint: NSMakePoint(241* scale, 386.95* scale) controlPoint1: NSMakePoint(239.64* scale, 399* scale) controlPoint2: NSMakePoint(241* scale, 386.95* scale)];
    [bezier2Path curveToPoint: NSMakePoint(254.63* scale, 388.45* scale) controlPoint1: NSMakePoint(241* scale, 386.95* scale) controlPoint2: NSMakePoint(247.81* scale, 388.45* scale)];
    [bezier2Path curveToPoint: NSMakePoint(268.26* scale, 386.95* scale) controlPoint1: NSMakePoint(261.45* scale, 388.45* scale) controlPoint2: NSMakePoint(268.26* scale, 386.95* scale)];
    [bezier2Path curveToPoint: NSMakePoint(275.08* scale, 399* scale) controlPoint1: NSMakePoint(268.26* scale, 386.95* scale) controlPoint2: NSMakePoint(272.01* scale, 399* scale)];
    [bezier2Path curveToPoint: NSMakePoint(282.48* scale, 385.13* scale) controlPoint1: NSMakePoint(278.14* scale, 399* scale) controlPoint2: NSMakePoint(280.93* scale, 390.64* scale)];
    [bezier2Path curveToPoint: NSMakePoint(280.53* scale, 350.78* scale) controlPoint1: NSMakePoint(284.04* scale, 379.63* scale) controlPoint2: NSMakePoint(293.14* scale, 359.82* scale)];
    [bezier2Path curveToPoint: NSMakePoint(230.09* scale, 350.78* scale) controlPoint1: NSMakePoint(267.92* scale, 341.74* scale) controlPoint2: NSMakePoint(242.7* scale, 341.74* scale)];
    [bezier2Path curveToPoint: NSMakePoint(228.73* scale, 386.95* scale) controlPoint1: NSMakePoint(217.48* scale, 359.82* scale) controlPoint2: NSMakePoint(228.73* scale, 386.95* scale)];
    [NSColor.blackColor setStroke];
    bezier2Path.lineWidth = 1* scale;
    bezier2Path.lineCapStyle = NSRoundLineCapStyle;
    [bezier2Path stroke];


    //// Bezier 5 Drawing
    NSBezierPath* bezier5Path = [NSBezierPath bezierPath];
    [bezier5Path moveToPoint: NSMakePoint(247.5* scale, 369.5* scale)];
    [bezier5Path curveToPoint: NSMakePoint(249.5* scale, 361.5* scale) controlPoint1: NSMakePoint(245.5* scale, 367.5* scale) controlPoint2: NSMakePoint(247.75* scale, 361.5* scale)];
    [bezier5Path curveToPoint: NSMakePoint(255.5* scale, 369.5* scale) controlPoint1: NSMakePoint(251.25* scale, 361.5* scale) controlPoint2: NSMakePoint(254.5* scale, 369.5* scale)];
    [bezier5Path curveToPoint: NSMakePoint(258.5* scale, 361.5* scale) controlPoint1: NSMakePoint(256.5* scale, 369.5* scale) controlPoint2: NSMakePoint(255.5* scale, 364.5* scale)];
    [bezier5Path curveToPoint: NSMakePoint(263.5* scale, 369.5* scale) controlPoint1: NSMakePoint(261.5* scale, 358.5* scale) controlPoint2: NSMakePoint(265.5* scale, 368.5* scale)];
    [NSColor.blackColor setStroke];
    bezier5Path.lineWidth = 1* scale;
    bezier5Path.lineCapStyle = NSRoundLineCapStyle;
    [bezier5Path stroke];


    //// Oval Drawing
    NSBezierPath* ovalPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(239* scale, 377* scale, 3* scale, 3* scale)];
    [NSColor.blackColor setFill];
    [ovalPath fill];


    //// Oval 2 Drawing
    NSBezierPath* oval2Path = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(268* scale, 377* scale, 3* scale, 3* scale)];
    [NSColor.blackColor setFill];
    [oval2Path fill];


    //// Text Drawing
    NSRect textRect = NSMakeRect(173* scale, 390* scale, 164* scale, 38* scale);
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentCenter;
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 29* scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: textStyle};

    [@"猫" drawInRect: NSOffsetRect(NSInsetRect(textRect, 0, 3), 0, 2) withAttributes: textFontAttributes];


    //// Text 2 Drawing
    NSRect text2Rect = NSMakeRect(192* scale, 424* scale, 125* scale, 16* scale);
    NSMutableParagraphStyle* text2Style = [[NSMutableParagraphStyle alloc] init];
    text2Style.alignment = NSTextAlignmentCenter;
    NSDictionary* text2FontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 13* scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: text2Style};

    [@"ね こ" drawInRect: NSOffsetRect(NSInsetRect(text2Rect, 0, 2), 0, 3) withAttributes: text2FontAttributes];


    //// Rectangle 3 Drawing
    NSBezierPath* rectangle3Path = [NSBezierPath bezierPathWithRect: NSMakeRect(57* scale, 42* scale, 35.5* scale, 204* scale)];
    [color3 setFill];
    [rectangle3Path fill];
    [NSColor.blackColor setStroke];
    rectangle3Path.lineWidth = 1* scale;
    [rectangle3Path stroke];


    //// Rectangle 4 Drawing
    NSBezierPath* rectangle4Path = [NSBezierPath bezierPathWithRect: NSMakeRect(421.5* scale, 42* scale, 35.5* scale, 204* scale)];
    [color3 setFill];
    [rectangle4Path fill];
    [NSColor.blackColor setStroke];
    rectangle4Path.lineWidth = 1* scale;
    [rectangle4Path stroke];


    //// Text 3 Drawing
    NSRect text3Rect = NSMakeRect(301* scale, 307* scale, 88* scale, 20* scale);
    NSMutableParagraphStyle* text3Style = [[NSMutableParagraphStyle alloc] init];
    text3Style.alignment = NSTextAlignmentRight;
    NSDictionary* text3FontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 16* scale], NSForegroundColorAttributeName: NSColor.whiteColor, NSParagraphStyleAttributeName: text3Style};

    [@"かわいい" drawInRect: NSOffsetRect(NSInsetRect(text3Rect, 0, 2), 0, 1) withAttributes: text3FontAttributes];


    //// Text 4 Drawing
    NSRect text4Rect = NSMakeRect(283* scale, 290* scale, 96* scale, 17* scale);
    {
        NSString* textContent = @"可愛い";
        NSMutableParagraphStyle* text4Style = [[NSMutableParagraphStyle alloc] init];
        text4Style.alignment = NSTextAlignmentRight;
        NSDictionary* text4FontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"JNR_Font" size: 12* scale], NSForegroundColorAttributeName: NSColor.whiteColor, NSParagraphStyleAttributeName: text4Style};

        CGFloat text4TextHeight = [textContent boundingRectWithSize: text4Rect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: text4FontAttributes].size.height;
        NSRect text4TextRect = NSMakeRect(NSMinX(text4Rect), NSMinY(text4Rect) + (text4Rect.size.height - text4TextHeight) / 2, text4Rect.size.width, text4TextHeight);
        [NSGraphicsContext saveGraphicsState];
        NSRectClip(text4Rect);
        [textContent drawInRect: NSOffsetRect(text4TextRect, 0, 2) withAttributes: text4FontAttributes];
        [NSGraphicsContext restoreGraphicsState];
    }


    //// Text 5 Drawing
    NSRect text5Rect = NSMakeRect(205* scale, 328* scale, 101* scale, 16* scale);
    NSMutableParagraphStyle* text5Style = [[NSMutableParagraphStyle alloc] init];
    text5Style.alignment = NSTextAlignmentCenter;
    NSDictionary* text5FontAttributes = @{NSFontAttributeName: [NSFont fontWithName: @"HiraMaruPro-W4" size: 13* scale], NSForegroundColorAttributeName: NSColor.blackColor, NSParagraphStyleAttributeName: text5Style};

    [@"Neko" drawInRect: NSOffsetRect(NSInsetRect(text5Rect, 0, 2), 0, 3) withAttributes: text5FontAttributes];


    [img unlockFocus];
    NSData * imageData = [img TIFFRepresentation];
    NSBitmapImageRep * imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    [imageRep setSize:[img size]];
    NSData * pngData = [imageRep representationUsingType:NSPNGFileType properties:@{}];
    [pngData writeToFile:@"/Users/cocoa/logo-cat.png" atomically:YES];
    return nil;
}

@end
