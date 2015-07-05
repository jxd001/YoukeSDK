//
//  ZPFTrackHelper.h
//  YoukeSDK
//
//  Created by ss on 15/3/23.
//  Copyright (c) 2015年 zipingfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YoukeSDK : NSObject


/**
 *  初始化对象
 *
 *  @return 返回单例对象
 */
+ (YoukeSDK *)sharedInstance;


/**
 *  @author jxd, 15-05-25 17:05:42
 *
 *  注册有客
 *
 *  @param appKey   AppKey
 *
 */
+(void)registerYouKeWithAppKey:(NSString *)appKey;


/**
 *  @author jxd, 15-05-16 16:05:19
 *
 *  弹出客服聊天界面
 *
 */
+(void)contactCustomServiceWithViewController:(UIViewController*)ctrl;



/**
 *  @author jxd, 15-05-25 17:05:13
 *
 *  提交商品及用户信息
 *
 *  @param goodsId      商品id(必传)
 *  @param goodsTitle   商品标题(必传)
 *  @param goodsPrice   商品价格(必传)
 *  @param goodsImg     商品图片(必传)
 *  @param userName     用户昵称（app账号体系内的用户昵称）
 *  @param userPhoto    用户头像（app账号体系内的用户头像）
 *  @param callNumber   电话号码（app账号体系内的电话号码）
 *  @param email        Email（app账号体系内的Email）
 *  @param qq           QQ号（app账号体系内的QQ号）
 *  @param text         备注信息
 */
+(void)visitGoodsWithGoodsId:(NSString *)goodsId
                  GoodsTitle:(NSString *)goodsTitle
                  GoodsPrice:(NSString *)goodsPrice
                    GoodsImg:(NSString *)goodsImg
                    UserName:(NSString *)userName
                   UserPhoto:(NSString *)userPhoto
                  CallNumber:(NSString *)callNumber
                       Email:(NSString *)email
                          QQ:(NSString *)qq
                        Text:(NSString *)text;
/**
 *  @author jxd, 15-06-15 13:06:55
 *
 *  获取当前正在浏览的商品
 *
 *
 *  @return 商品信息 ZPFCommodityObject
 */
-(id)getCurrentCommodity;


/**
 *  @author jxd, 15-05-25 17:05:03
 *
 *  离开商品页面时调用
 */
+(void)leaveGoods;


/**
 *  @author jxd, 15-06-17 06:06:37
 *
 *  打开帮助列表页面
 *
 *  @param ctrl 从哪个viewcontroller弹出该页面
 */
+(void)openHelpViewControllerWithViewController:(UIViewController*)ctrl;

@end


