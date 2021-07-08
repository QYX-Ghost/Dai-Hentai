//
//  SettingViewController+Lock.m
//  Dai-Hentai
//
//  Created by DaidoujiChen on 2018/3/12.
//  Copyright © 2018年 DaidoujiChen. All rights reserved.
//

#import "SettingViewController+Lock.h"
#import "UIAlertController+Block.h"
#import "Dai_Hentai-Swift.h"
#import "DBUserPreference.h"

@implementation SettingViewController (Lock)

- (IBAction)onLocalThisAppSwitchChanged:(id)sender {
    if (!self.lockThisAppSwitch.on) {
        @weakify(self);
        [AuthHelper checkFor:@"驗證身份以解除鎖定" completion: ^(BOOL pass) {
            @strongify(self);
            
            if (pass) {
                self.info.isLockThisApp = @(NO);
                [self displayLockThisAppSwitch];
                [DBUserPreference setInfo:self.info];
                [AuthHelper refresh];
            }
            else {
                exit(0);
            }
        }];
        return;
    }
    
    // 無上鎖時, 跟用戶確認要上鎖這件事
    @weakify(self);
    [UIAlertController showAlertTitle:@"確定要上鎖嗎?" message:@"未來只可以透過指紋或是臉來解鎖, 密碼無法!" defaultOptions:@[ @"OK, 鎖8" ] cancelOption:@"O口O 真假, 我考慮一下" handler: ^(NSInteger optionIndex) {
        if (!optionIndex) {
            [self.lockThisAppSwitch setOn:NO animated:YES];
            return;
        }
        
        @strongify(self);
        if ([AuthHelper canLock]) {
            self.info.isLockThisApp = @(YES);
            [DBUserPreference setInfo:self.info];
        }
    }];
}

- (void)displayLockThisAppSwitch {
    if (self.info.isLockThisApp.boolValue) {
        self.lockThisAppSwitch.on = YES;
    } else {
        self.lockThisAppSwitch.on = NO;
    }
}

@end
