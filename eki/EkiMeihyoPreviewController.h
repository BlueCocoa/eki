//
//  EkiMeihyoPreviewController.h
//  eki
//
//  Created by Cocoa on 2017/11/11.
//  Copyright © 2017 Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EkiMeihyoImageView : NSImageView
@end

@interface EkiMeihyoPreviewController : NSViewController
@property (strong) NSString * previous;
@property (strong) NSString * current;
@property (strong) NSString * next;
@property (strong) NSString * style;
@property (strong) IBOutlet EkiMeihyoImageView *previewImageView;
@property (strong, nonatomic) NSDictionary * meihyo;
- (IBAction)saveMeihyo:(id)sender;
@end
