//
//  SettingViewController+BlurCover.m
//  Dai-Hentai
//
//  Created by QYX on 2021/7/8.
//  Copyright © 2021 DaidoujiChen. All rights reserved.
//

#import "SettingViewController+BlurCover.h"

@implementation SettingViewController (BlurCover)

- (IBAction)onBlurCoverSwitchChanged:(id)sender {
    if (self.blurCoverSwitch.on) {
        self.info.blurCover = @(YES);
    } else {
        self.info.blurCover = @(NO);
    }
    
    [DBUserPreference setInfo:self.info];
}

- (void)displayBlurCoverSwitch {
    if (self.info.blurCover.boolValue) {
        self.blurCoverSwitch.on = YES;
    } else {
        self.blurCoverSwitch.on = NO;
    }
}

@end
