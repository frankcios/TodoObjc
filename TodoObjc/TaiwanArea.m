//
//  TaiwanArea.m
//  TodoObjc
//
//  Created by Frank on 2017/6/2.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "TaiwanArea.h"

@implementation TaiwanArea

+ (id)taiwanAreaWithHeader:(NSString *)header footer:(NSString *)footer cities:(NSArray *)cities {
    TaiwanArea *area = [[TaiwanArea alloc] init];
    area.header = header;
    area.footer = footer;
    area.cities = cities;
    
    return area;
}

@end
