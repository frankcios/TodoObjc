//
//  TaiwanArea.h
//  TodoObjc
//
//  Created by Frank on 2017/6/2.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaiwanArea : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSArray *cities;

+ (id)taiwanAreaWithHeader: (NSString *)header footer:(NSString *)footer cities:(NSArray *)cities;

@end
