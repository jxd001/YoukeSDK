//
//  ZPFTrackHelper.h
//  YoukeSDK
//
//  Created by ss on 15/3/23.
//  Copyright (c) 2015年 zipingfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  @author jxd, 15-09-01 10:09:20
 *
 *  聊天列表数据实体类
 */
@interface YoukeMessageListObject : NSObject

@property (strong, nonatomic) NSString *fromUid;
@property (strong, nonatomic) NSString *toUid;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userAvatar;
@property (strong, nonatomic) NSString *userPhone;
@property (strong, nonatomic) NSString *messageContent;
@property (strong, nonatomic) NSString *messageTime;

@end


@interface YoukeSDK : NSObject

/**
 *  @author jxd, 15-08-07 12:08:30
 *
 *  获取新消息数BLOCK
 *
 *  @param newMessageCount      新消息数
 *  @param messageContent       消息内容
 *  @param messageFrom          消息发送者名字
 */
typedef void(^NEWMESSAGE_BLOCK)(NSInteger newMessageCount, NSString *messageContent, NSString *messageFrom);
@property (nonatomic, copy) NEWMESSAGE_BLOCK  newMessageBlocker;


/**
 *  @author jxd, 15-09-01 17:09:01
 *
 *  聊天详情页的商品被点击，将通过这个bolock把商品id传出来
 *
 *  @param goodsId        被点击的商品的商品id
 *  @param viewController 聊天详情页的实例变量，可以用该viewController来push或present商品详情页
 */
typedef void(^GOODSCLICK_BLOCK)(NSString *goodsId, UIViewController *viewController);
@property (nonatomic, copy) GOODSCLICK_BLOCK goodsClickBlocker;


/**
 *  @author jxd, 15-09-01 17:09:08
 *
 *  聊天详情页中的订单被点击，将通过这个block把订单id传出来
 *
 *  @param orderId          订单id
 *  @param viewController   聊天详情页的实例变量，可以用该viewController来push或present订单详情页
 */
typedef void(^ORDERCLICK_BLOCK)(NSString *orderId, UIViewController *viewController);
@property (nonatomic, copy) ORDERCLICK_BLOCK orderClickBlocker;



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
+ (void)registerYouKeWithAppKey:(NSString *)appKey;


/**
 *  @author jxd, 15-05-16 16:05:19
 *
 *  弹出客服聊天界面
 *
 */
+ (void)contactCustomServiceWithViewController:(UIViewController*)ctrl;


/**
 *  @author jxd, 15-05-25 17:05:13
 *
 *  提交商品及用户信息，访问商品页面时调用
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
+ (void)visitGoodsWithGoodsId:(NSString *)goodsId
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
 *  @author jxd, 15-05-25 17:05:03
 *
 *  离开商品页面时调用
 */
+ (void)leaveGoods;


/**
 *  @author jxd, 15-08-28 11:08:23
 *
 *  如果要在聊天列表显示正在浏览的订单，就要在打开聊天窗口之前调用该方法
 *
 *  @param orderId      订单号
 *  @param orderTime    订单时间
 *  @param goodsTitle   商品民称
 *  @param goodsImage   商品图片
 *  @param goodsPrice   商品价格
 */
+ (void)visitOrderWithOrderId:(NSString*)orderId
                    OrderTime:(NSString*)orderTime
                   GoodsTitle:(NSString*)goodsTitle
                   GoodsImage:(NSString*)goodsImage
                   GoodsPrice:(NSString*)goodsPrice;


/**
 *  @author jxd, 15-08-04 00:08:42
 *
 *  将用户与openfire绑定(用于点对点聊天)
 *
 *  @param userId    用户id
 *  @param userPhoto 用户头像
 *  @param userName  用户昵称
 *  @param tell      用户手机号
 *  @param email     用户email
 *  @param qq        用户qq号
 *  @param otherText 其他信息
 */
+ (void)bindOpenFireWithUserId:(NSString*)userId UserPhoto:(NSString*)userPhoto UserName:(NSString*)userName Tell:(NSString*)tell Email:(NSString*)email QQ:(NSString*)qq OtherText:(NSString*)otherText;


/**
 *  @author jxd, 15-07-31 15:07:26
 *
 *  实现点对点聊天，比如和APP用户体系内的某个“商家”
 *
 *  @param myUserId     登录用户的用户id
 *  @param toUserId     聊天对象的用户id
 *  @param ctrl         从哪个viewcontroller进入
 */
+ (void)openPointToPointTalkViewControllerWithMyUserid:(NSString*)myUserId ToUserId:(NSString*)toUserId ViewController:(UIViewController*)ctrl;


/**
 *  @author jxd, 15-07-31 14:07:32
 *
 *  实现点对点聊天，打开聊天列表(用于商家、店主等类型用户与普通用户聊天)
 *
 *  @param myUserId     登录用户id
 *  @param ctrl         从哪个viewcontroller弹出
 */
+ (void)openPointToPointTalkListWithMyUserId:(NSString*)myUserId ViewController:(UIViewController*)ctrl;


/**
 *  @author jxd, 15-08-30 12:08:58
 *
 *  获取点对点聊天列表数据，用于开发者需要自定义聊天列表界面的需求
 *
 *  @param userid  用户自己的用户id
 *  @param success 成功block，成功的block会返回聊天列表的数组，数组元素为YoukeMessageListObject类型
 *
 */
+ (void)getPointToPointTalkListDataWithMyUserid:(NSString*)userid
                                        success:(void (^)(NSArray *listArray)) success
                                        failure:(void (^)(NSError *error)) failure;


/**
 *  @author jxd, 15-06-17 06:06:37
 *
 *  打开帮助列表页面
 *
 *  @param ctrl 从哪个viewcontroller弹出该页面
 */
+ (void)openHelpViewControllerWithViewController:(UIViewController*)ctrl;


/**
 *  @author jxd, 15-08-07 10:08:37
 *
 *  获取最新未读消息数
 *
 *  @return 未读消息数
 */
+ (NSInteger)getNewMessageCount;


/**
 *  @author jxd, 15-06-15 13:06:55
 *
 *  获取当前正在浏览的商品
 *
 *
 *  @return 商品信息 ZPFCommodityObject
 */
- (id)getCurrentCommodity;

/**
 *  @author jxd, 15-08-28 11:08:44
 *
 *  获取正在浏览的订单
 *
 *  @return ZPFOrderObject
 */
- (id)getCurrentOrder;



@end


