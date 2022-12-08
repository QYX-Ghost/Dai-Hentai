//
//  SearchInfo.m
//  Dai-Hentai
//
//  Created by DaidoujiChen on 2017/2/21.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

#import "SearchInfo.h"
#import <objc/runtime.h>

@implementation SearchInfo

#pragma mark - Instance Method

- (NSString *)query:(NSString *)gid {
    NSString *keyword = self.keyword;
    if (self.chineseOnly.boolValue) {
        keyword = [keyword stringByAppendingString:@" language:Chinese"];
    } else if (self.originalOnly.boolValue) {
        keyword = [keyword stringByAppendingString:@" -translated -rewrite"];
    }
    
    //https://e-hentai.org/?inline_set=dm_l 列表
    //https://e-hentai.org/?inline_set=dm_t 縮圖
    NSMutableString *query = [NSMutableString stringWithFormat:@"?f_search=%@&f_apply=Apply+Filter&inline_set=dm_l", [[keyword componentsSeparatedByString:@" "] componentsJoinedByString:@"+"]];
    
    NSInteger cats = 1023;
    if (self.doujinshi.boolValue) {
        cats -= 2;
    }
    if (self.manga.boolValue) {
        cats -= 4;
    }
    if (self.artistcg.boolValue) {
        cats -= 8;
    }
    if (self.gamecg.boolValue) {
        cats -= 16;
    }
    if (self.western.boolValue) {
        cats -= 512;
    }
    if (self.non_h.boolValue) {
        cats -= 256;
    }
    if (self.imageset.boolValue) {
        cats -= 32;
    }
    if (self.cosplay.boolValue) {
        cats -= 64;
    }
    if (self.asianporn.boolValue) {
        cats -= 128;
    }
    if (self.misc.boolValue) {
        cats -= 1;
    }
    [query appendFormat:@"&f_cats=%@", @(cats)];
    
    if ([self.rating compare:@(0)] != NSOrderedSame) {
        [query appendFormat:@"&advsearch=1&f_sname=on&f_stags=on&f_sr=on&f_srdd=%@", @(self.rating.integerValue + 1)];
    }
    
    if (gid) {
        [query appendFormat:@"&next=%@", gid];
    }
    
    return [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSMutableArray<NSString *> *)hints {
    NSMutableArray *hints = objc_getAssociatedObject(self, _cmd);
    if (!hints) {
        return [NSMutableArray array];
    }
    return hints;
}

- (void)setHints:(NSString *)hint {
    NSMutableArray *hints = objc_getAssociatedObject(self, @selector(hints));
    if (!hints) {
        hints = [NSMutableArray array];
    }
    
    if ([hints containsObject:hint]) {
        [hints removeObject:hint];
    }
    else {
        [hints addObject:hint];
    }
    objc_setAssociatedObject(self, @selector(hints), hints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.keyword = @"";
        self.rating = @(0);
        self.doujinshi = @(1);
        self.manga = @(1);
        self.artistcg = @(1);
        self.gamecg = @(1);
        self.western = @(1);
        self.non_h = @(1);
        self.imageset = @(1);
        self.cosplay = @(1);
        self.asianporn = @(1);
        self.misc = @(1);
        self.chineseOnly = @(0);
        self.originalOnly = @(0);
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary {
    self = [super init];
    if (self) {
        [self restoreContents:[NSMutableDictionary dictionaryWithDictionary:dictionary] defaultContent:nil];
    }
    return self;
}

@end
