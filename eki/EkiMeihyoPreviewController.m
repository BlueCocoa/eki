//
//  EkiMeihyoPreviewController.m
//  eki
//
//  Created by Cocoa on 2017/11/11.
//  Copyright © 2017 Cocoa. All rights reserved.
//

#import "EkiMeihyoPreviewController.h"
#import <Quartz/Quartz.h>

@implementation EkiMeihyoImageView

- (void)setImage:(NSImage *)image {
    self.layer = [[CALayer alloc] init];
    self.layer.contentsGravity = kCAGravityResizeAspect;
    self.layer.contents = image;
    self.wantsLayer = YES;
}

@end

@implementation EkiMeihyoPreviewController
@synthesize meihyo;
@synthesize previewImageView;
@synthesize style, previous, current, next;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.previewImageView setImageScaling:NSImageScaleProportionallyDown];
    [self.previewImageView setImage:self.meihyo[@"png"]];
    [self setTitle:[NSString stringWithFormat:@"%@ - %@ -> %@ -> %@", self.style, self.previous, self.current, self.next]];
}

- (IBAction)saveMeihyo:(id)sender {
    NSSavePanel * panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:[NSString stringWithFormat:@"%@", self.title]];
    NSView * accessoryView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 180, 40)];
    NSTextField * formatLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 10, 80, 20)];
    [formatLabel setBordered:NO];
    [formatLabel setDrawsBackground:NO];
    formatLabel.stringValue = @"选择格式喵 ➜ ";
    NSComboBox * fileformat = [[NSComboBox alloc] initWithFrame:NSMakeRect(80, 8, 100, 25)];
    [fileformat addItemsWithObjectValues:@[@"png", @"svg"]];
    [fileformat selectItemAtIndex:0];
    [accessoryView addSubview:formatLabel];
    [accessoryView addSubview:fileformat];
    [panel setAccessoryView:accessoryView];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL * filepath = [panel URL];
            NSString * extension = @[@"png", @"svg"][fileformat.indexOfSelectedItem];
            if (![filepath.pathExtension.lowercaseString isEqualToString:extension]) {
                filepath = [filepath URLByAppendingPathExtension:extension];
            }
            if ([extension isEqualToString:@"png"]) {
                NSImage * image = self.meihyo[@"png"];
                NSData * imageData = [image TIFFRepresentation];
                NSBitmapImageRep * imageRep = [NSBitmapImageRep imageRepWithData:imageData];
                [imageRep setSize:[image size]];
                NSData * pngData = [imageRep representationUsingType:NSPNGFileType properties:@{}];
                [pngData writeToURL:filepath atomically:YES];
            } else {
                [self.meihyo[@"svg"] writeToURL:filepath atomically:YES];
            }
        }
    }];
}

@end
