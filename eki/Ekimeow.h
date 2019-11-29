//
//  Ekimeow.h
//  eki
//
//  Created by Cocoa on 2017/11/11.
//  Copyright © 2017 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface EkiInfo : NSObject
+ (EkiInfo *)infoWithKana:(NSString *)kana roman:(NSString *)roman kanji:(NSString *)kanji coding:(NSString *)coding;
+ (EkiInfo *)infoWithKana:(NSString *)kana roman:(NSString *)roman kanji:(NSString *)kanji secondaryNameKanji:(NSString *)secondaryKanji lineColor:(NSColor *)color coding:(NSString *)coding;
- (NSString *)description;
@property (strong, nonatomic) NSString * nameKana;
@property (strong, nonatomic) NSString * nameRoman;
@property (strong, nonatomic) NSString * nameKanji;
@property (strong, nonatomic) NSString * secondaryNameKanji;
@property (strong, nonatomic) NSColor  * lineColor;
@property (strong, nonatomic) NSString * coding;
@end

@interface Ekimeow : NSObject
+ (NSDictionary *)ekiWithConfiguration:(NSDictionary *)config;

+ (NSString *)ekiWithHankyuSVG:(NSDictionary *)config;
+ (NSString *)ekiWithTokyoMetroSVG:(NSDictionary *)config;
+ (NSString *)ekiWithKeiseiSVG:(NSDictionary *)config;
+ (NSString *)ekiWithIzuSVG:(NSDictionary *)config;
+ (NSString *)ekiWithJREastSVG:(NSDictionary *)config;
+ (NSString *)ekiWithJRCSVG:(NSDictionary *)config;

+ (NSImage *)ekiWithHankyu:(NSDictionary *)config;
+ (NSImage *)ekiWithTokyoMetro:(NSDictionary *)config;
+ (NSImage *)ekiWithKeisei:(NSDictionary *)config;
+ (NSImage *)ekiWithIzu:(NSDictionary *)config;
+ (NSImage *)ekiWithJREast:(NSDictionary *)config;
+ (NSImage *)ekiWithJRC:(NSDictionary *)config;
@end
