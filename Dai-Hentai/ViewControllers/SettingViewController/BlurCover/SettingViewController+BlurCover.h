//
//  SettingViewController+BlurCover.h
//  Dai-Hentai
//
//  Created by QYX on 2021/7/8.
//  Copyright © 2021 DaidoujiChen. All rights reserved.
//

#import "PrivateSettingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController (BlurCover)

- (IBAction)onBlurCoverSwitchChanged:(id)sender;
- (void)displayBlurCoverSwitch;

@end

NS_ASSUME_NONNULL_END
