//
//  ViewController.h
//  eki
//
//  Created by Cocoa on 2017/11/11.
//  Copyright © 2017 Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (strong) IBOutlet NSTextField *previousEkiNameKanjiTextField;
@property (strong) IBOutlet NSTextField *previousEkiNameRomanTextField;
@property (strong) IBOutlet NSTextField *previousEkiNameKanaTextField;
@property (strong) IBOutlet NSTextField *previousEkiCodingTextField;

@property (strong) IBOutlet NSTextField *nextEkiNameKanjiTextField;
@property (strong) IBOutlet NSTextField *nextEkiNameRomanTextField;
@property (strong) IBOutlet NSTextField *nextEkiNameKanaTextField;
@property (strong) IBOutlet NSTextField *nextEkiCodingTextField;

@property (strong) IBOutlet NSTextField *ekiNameKanjiTextField;
@property (strong) IBOutlet NSTextField *ekiNameRomanTextField;
@property (strong) IBOutlet NSTextField *ekiNameKanaTextField;
@property (strong) IBOutlet NSColorWell *ekiLineColorWell;
@property (strong) IBOutlet NSTextField *ekiCodingTextField;
@property (strong) IBOutlet NSTextField *ekiSecondaryNameTextField;

@property (strong) IBOutlet NSPopUpButton *ekiMeihyoStyleButton;
@property (strong) IBOutlet NSTextField *ekiMeihyoScaleTextField;
@property (strong) IBOutlet NSButton *ekiMeihyoGenerateButton;

- (IBAction)generateEkiMeihyo:(id)sender;
@end

