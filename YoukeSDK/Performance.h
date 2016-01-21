//
//  Performance.h
//  云商通
//
//  Created by XuDong Jin on 16/1/21.
//  Copyright © 2016年 zipingfang. All rights reserved.
//  用于企业统计客服绩效的类

#import <Foundation/Foundation.h>

@interface Performance : NSObject

//记录类型，goods或order，不传则为goods
@property (strong, nonatomic) NSString *recordType;
//记录id，传商品id或订单id
@property (strong, nonatomic) NSString *recordId;

@end
