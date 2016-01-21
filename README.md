### 1、介绍
版本：V1.0.9
官网：http://www.youkeyun.com

有客是中国领先的智能客服云平台，为移动应用APP开发者提供智能的客服SDK，帮助企业的客服人员进行实时在线客服沟通、分析用户的访问行为轨迹、实时开展触碰式的个性化营销，实现将流量转化为销量。  

主要实现功能：  
* APP用户与客服即时沟通  
* 工单系统  
* 数据分析  
* 触碰营销  
* FAQ功能  
* 点对点单聊
* 消息推送
* 更换皮肤
* 客服绩效

更新记录：
* 2015.8.10 增加：点对点单聊功能；
* 2015.8.12 增加：获取消息未读数以及最新消息内容接口；
* 2015.8.31 增加：在聊天详情显示正在浏览的订单功能；
* 2015.8.31 增加：在聊天详情显示的订单可以点击进入订单详情的接口；
* 2015.9.1   增加：获取聊天列表的数据的接口；
* 2015.9.2 增加：聊天详情页中的商品或订单被点击的事件；
* 2015.9.7 增加：绑定devicetoken，实现消息推送功能；
* 2015.10.10 优化：适配iOS9；
* 2015.11.7 增加：删除聊天列表中的记录
* 2016.1.20 增加：客服绩效接口


<br>
### 2、集成方法

2.1 安装方式一：通过cocoapods安装：
```objective-c
pod 'YoukeSDK'
```

2.2 安装方式二：下载 [iOS SDK](http://www.youkesdk.com/download/index.html) ，解压缩后得到 YoukeSDK 文件夹，把 YoukeSDK 文件夹拖入Xcode项目工程中。  
2.3 在Xcode的Build Settings>Other Linker Flags>添加`-ObjC`。  
2.4 Xcode切换到Build Phases选项卡，选择Link Binary With Libraries，点击+号，导入以下链接库：
```objective-c
libresolv.dylib  （xcode7为libresolv.tbd）
libsqlite3.dylib  （xcode7为lbsqlite3.tbd）
libxml2.dylib （xcode7为libxml2.tbd）
```

2.5 在appdelegate里导入YoukeSDK.h
```objective-c
#import "YoukeSDK.h"
```
2.6 获取Appkey，进入[YoukeSDK](http://t.youkesdk.com/)后台，注册账号并登录，登录后在左边菜单中选择 开发者>AppKey> 复制企业APPKEY
<center>
![2015-06-23/5588cd1d1186a](http://box.kancloud.cn/2015-06-23_5588cd1d1186a.png)
</center>
<br>
2.7 在didFinishLaunchingWithOptions中加入以下代码，将“企业APPKEY”改成上一步得到的APPKEY，集成完成。
```objective-c
//注册有客
[YoukeSDK registerYouKeWithAppKey:@"企业APPKEY"];
```

<br>
### 3、实现客服功能（即时沟通）
在需要实现聊天服务的页面的viewDidLoad方法中添加代码：
```objective-c
- (void)viewDidLoad {
    //连接聊天服务
    [YoukeSDK connectChatService];
}
```

在需要实现客服聊天功能的地方（如按钮点击事件）中加入以下代码，即可跳转到客服聊天界面，客服列表中的客服人员，需在[YoukeSDK](http://t.youkesdk.com/)后台添加。
```objective-c
//跳转到客服聊天界面
[YoukeSDK contactCustomServiceWithViewController:self];
```
如需统计客服绩效，则使用下面的方法：
```objective-c
Performance *p = [Performance new];
p.recordType = @"goods";
p.recordId = self.courseId;
[YoukeSDK contactCustomServiceWithViewController:self Performance:p];
```
<center>
![2015-06-24/558a12ed91242](http://box.kancloud.cn/2015-06-24_558a12ed91242.png)
</center>

### 4、工单提交与处理
当调用  
```objective-c
[YoukeSDK contactCustomServiceWithViewController:self]
```
方法时正巧没有客服在线，会自动跳转到工单提交界面，用户提交的工单会自动分配给各个客服处理：
<center>
![2015-07-17/55a8c9e584884](http://box.kancloud.cn/2015-07-17_55a8c9e584884.png)  
![2015-07-17/55a8ca17c4f28](http://box.kancloud.cn/2015-07-17_55a8ca17c4f28.png)
</center>
<br>
### 5、实现数据分析

5.1 在商品详情页加入记录商品信息的代码，此处商品信息为必传，用于将用户访问的商品信息传到客服后台，方便客服了解用户当前正在浏览的商品，以及对用户访问的商品信息进行统计和数据分析功能；用户信息可传可不传。
```objective-c
/**
 *  提交商品及用户信息
 *
 *  @param goodsId      商品id
 *  @param goodsTitle   商品标题
 *  @param goodsPrice   商品价格
 *  @param goodsImg     商品图片
 *  @param userName     用户昵称（app账号体系内的用户昵称）
 *  @param userPhoto    用户头像（app账号体系内的用户头像）
 *  @param callNumber   电话号码（app账号体系内的电话号码）
 *  @param email        Email（app账号体系内的Email）
 *  @param qq           QQ号（app账号体系内的QQ号）
 *  @param text         备注信息
 */
[YoukeSDK visitGoodsWithGoodsId:goodsId
                     GoodsTitle:goodsName
                     GoodsPrice:goodsPrice
                       GoodsImg:goodsImage
                       UserName:nil
                      UserPhoto:nil
                     CallNumber:nil
                          Email:nil
                             QQ:nil
                           Text:nil];    
```
5.2 在商品详情页的viewWillDisappear中加入以下代码，此步骤为了记录用户离开商品页面的时间、记录访问商品时长、进行数据统计和分析。
```objective-c
- (void)viewWillDisappear:(BOOL)animated{
     [YoukeSDK leaveGoods];
}
```
<center>![2015-06-23/5588d7f9d8a31](http://box.kancloud.cn/2015-06-23_5588d7f9d8a31.png)</center>
<br>
### 6、触碰营销功能
在后台触碰营销菜单进行相关设置，比如设置：在商品详情页停留1分钟或查看该商品10次以上，触发该计划。当用户浏览商品时间或次数达到该要求时，就会显示在创意管理中添加好的“优惠券”信息：
<center>![2015-06-23/5589499b42c05](http://box.kancloud.cn/2015-06-23_5589499b42c05.png)</center>

<center>![2015-06-23/55894a4392073](http://box.kancloud.cn/2015-06-23_55894a4392073.png)</center>
<br><br>
### 7、FAQ功能（在线问答）
请在[YoukeSDK](http://t.youkesdk.com/)后台添加问题分类和问题以及答案。在需要打开FAQ界面的地方（如按钮点击事件）添加以下代码，即可实现在线问答功能。
```objective-c
//跳转到FAQ界面
[YoukeSDK openHelpViewControllerWithViewController:self];
```
<center>![2015-06-23/5588d5b9c9618](http://box.kancloud.cn/2015-06-23_5588d5b9c9618.png)</center>

<center>![2015-06-23/5589478a99cad](http://box.kancloud.cn/2015-06-23_5589478a99cad.png)
</center>

### 8、点对点单聊
用于实现如用户和商家聊天、商家和上级代理商聊天等场景。
8.1、将用户与openfire绑定
~~~objective-c
/**
 *  @param userId    用户id
 *  @param userPhoto 用户头像
 *  @param userName  用户昵称
 *  @param tell      用户手机号
 *  @param email     用户email
 *  @param qq        用户qq号
 *  @param otherText 其他信息
 */
[YoukeSDK bindOpenFireWithUserId:@"10003"
                       UserPhoto:@"http://ww1.sinaimg.cn/bmiddle/97647685jw1euqexfregfj20w80l6q5t.jpg"
                        UserName:@"jxd002"
                            Tell:@"18515153245"
                           Email:@"8765645@qq.com"
                              QQ:@"8765645"
                       OtherText:@""];
~~~
如果要让商家看到我正在浏览的商品，在商品页面加入下面两个方法即可
```objective-c
//获取到商品信息时
[YoukeSDK visitGoodsWithGoodsId:goodsId
                     GoodsTitle:goodsName
                     GoodsPrice:goodsPrice
                       GoodsImg:goodsImage
                       UserName:nil
                      UserPhoto:nil
                     CallNumber:nil
                          Email:nil
                             QQ:nil
                           Text:nil];    
//离开页面时
[YoukeSDK leaveGoods];
```
如果要让商家看到我正在浏览的订单，在打开商家聊天窗口之前调用以下方法即可
```objective-c
[YoukeSDK visitOrderWithOrderId:@"9888444368"
                      OrderTime:@"08-21 12:20"
                     GoodsTitle:@"2014新款 漂流木帆布包男"
                     GoodsImage:@"http://img10.360buyimg.com/N6/s60x60_g13/M04/00/08/rBEhVFHeVO8IAAAAAAOkd-fxdusAAA8awB92ecAA6SP334.jpg"
                     GoodsPrice:@"99"];
```


8.2、用户打开商家的聊天窗口
~~~objective-c
/**
 *  @param myUserId     登录用户的用户id
 *  @param toUserId     聊天对象的用户id
 *  @param ctrl         从哪个viewcontroller进入
 *  @param showTips     是否显示提示框
 *  @param success      成功回调，成功的block会返回聊天列表的数组，数组元素为YoukeMessageListObject类型
 *  @param failure      失败回调，返回失败信息
 */
[YoukeSDK openPointToPointTalkViewControllerWithMyUserid:@"10001" ToUserId:@"10002" ViewController:self ShowTips:NO Success:^(NSArray *listArray) {
    //
} Failure:^(NSError *error) {
    NSLog(@"error:%@",[error localizedDescription]);
}];
~~~

8.3、商家打开聊天列表
~~~objective-c
/**
 *  @param myUserId     登录用户id
 *  @param ctrl         从哪个viewcontroller弹出
 *  @param showTips     是否显示提示框
 *  @param success      成功block，成功的block会返回聊天列表的数组，数组元素为YoukeMessageListObject类型
 *  @param failure      失败回调，返回失败信息
 */
[YoukeSDK openPointToPointTalkListWithMyUserId:@"10001" ViewController:self ShowTips:NO Success:^(NSArray *listArray) {
    //
} Failure:^(NSError *error) {
    NSLog(@"error:%@",[error localizedDescription]);
}];
~~~
<center>![2015-08-04/55c0723c0d83a](http://box.kancloud.cn/2015-08-04_55c0723c0d83a.png)</center>

8.4、获取最新聊天消息未读数
~~~objective-c
//方式一：直接获取最新未读数
NSInteger count = [YoukeSDK getNewMessageCount];
NSLog(@"getNewMessageCount:%@",@(count));
    
/**
 *  方式二：Block方式实时监听新消息数提醒
 *  @param newMessageCount 新消息数量
 *  @param messageContent  新消息内容
 *  @param messageFrom     新消息发送者名
 */
[YoukeSDK sharedInstance].newMessageBlocker = ^(NSInteger newMessageCount, NSString *messageContent, NSString *messageFrom)
{
    NSLog(@"getNewMessageCount:%@",@(newMessageCount));
    NSLog(@"messageContent:%@",@(messageContent));
    NSLog(@"messageFrom:%@",@(messageFrom));
};
~~~
8.5、获取最近聊天列表的数据（商家使用），用于需要自定义聊天列表的需求
```objc
/**
 *  获取点对点聊天列表数据，用于开发者需要自定义聊天列表界面的需求
 *
 *  @param userid       用户自己的用户id
 *  @param showTips     是否显示提示框
 *  @param success      成功回调，成功的block会返回聊天列表的数组，数组元素为YoukeMessageListObject类型
 *  @param failure      失败回调，返回失败信息
 *
 */
[YoukeSDK getPointToPointTalkListDataWithMyUserid:@"10001" ShowTips:NO Success:^(NSArray *listArray) {
    listData = listArray;
    [table reloadData];
} Failure:^(NSError *error) {
    NSLog(@"error:%@",[error localizedDescription]);
}];
```

8.6、聊天详情页点击商品或订单的事件
```objective-c
//聊天详情页中的商品被点击
[YoukeSDK sharedInstance].goodsClickBlocker = ^(NSString *goodsId, UIViewController *viewController)
{
    NSLog(@"goodsId:%@",goodsId);
};

//聊天详情页中的订单被点击
[YoukeSDK sharedInstance].orderClickBlocker = ^(NSString *orderId, UIViewController *viewController)
{
    NSLog(@"orderId:%@",orderId);
};
```

8.7、删除聊天列表中的记录
```objc
[YoukeSDK deleteChatUserWithMyUserId:_fromUserId ToUserId:_toUserId Success:^(NSString *successTips) {
      
} Failure:^(NSError *error) {
       
}];
```

<br>
### 9、实现APNS推送功能
YoukeSDK的消息推送支持客服对访客的消息推送、点对点聊天的消息推送，集成方法如下：<br>
9.1、在Appdelegate中加入以下代码：
```objc
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [YoukeSDK registerDeviceToken:deviceToken];
}
```
9.2、登录developer.apple.com制作推送证书，下载证书后双击导入系统钥匙串；<br>
9.3、打开系统钥匙串，找到你刚才导入的推送证书；<br>
> 如果是开发环境，证书名类似“Apple Development IOS Push Services：com.xxx.xxx”；<br>
> 如果是发布证书，证书名类似“Apple Production IOS Push Services：com.xxx.xxx”；

9.4、在找到的证书上点击右键，选择“导出”，导出p12证书的时候选择存放的地址，以及填写证书密码，密码可填可不填；<br>
9.5、打开终端，用“cd”命令进入你的证书所在的目录，执行以下命令，将证书转成pem格式，注意修改证书名称是否和你的对应；
```
openssl pkcs12 -in cert.p12 -out MyApnsCert.pem -nodes
```
9.6、登录http://t.youkesdk.com ，进入以下菜单：<br>
![2015-07-15/55a62e23a1f08](http://box.kancloud.cn/2015-10-10_5618c64eaa2d2.png)

选择和证书对应的环境上传证书，如果有密码填入密码，点击保存，再点击生效，如果显示“生效中”即成功；
>如果收不到推送，最常见的问题是Archive的时候Build Settings>Code Signing里的配置和提交的推送证书不匹配；
>还要注意，YoukeSDK只在接收方离线的时候才会发推送，在线的时候不会发推送，测试方法：直接上划关闭APP后测试推送。

<br>
### 10、更换皮肤
更换皮肤功能主要用于修改导航栏颜色、导航文字的颜色，修改聊天气泡颜色、聊天文字颜色。修改方法是替换skin.plist中对应的value：

```objective-c
MessageBubbleBackgroundColorFromOther //聊天气泡背景色（他人）
MessageBubbleBackgroundColorFromMe //聊天气泡背景色（我的）
MessageBubbleTextColorFromOther //聊天文字颜色（他人）
MessageBubbleTextColorFromMe  //聊天文字颜色（我的）
NavigationTitleColor  //导航栏文字颜色
NavigationBackgroundColor  //导航栏背景色
```
<center>
![2015-07-15/55a62e23a1f08](http://box.kancloud.cn/2015-07-15_55a62e23a1f08.png)
</center>
