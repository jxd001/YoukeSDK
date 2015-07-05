# YoukeSDK
YoukeSDK 帮助你的APP快速构建客服系统。

<br>
### 1、介绍
版本： V1.0.0 

YoukeSDK帮助您快速构建客服系统。  
主要实现功能：  
* 即时沟通  
* 数据分析  
* 触碰营销  
* FAQ功能  
* 更换皮肤

<br>
### 2、集成方法
2.1 下载 [iOS SDK](http://www.youkesdk.com/download/index.html) ，解压缩后得到 YoukeSDK 文件夹，把 YoukeSDK 文件夹拖入Xcode项目工程中。  
2.2 在Xcode的Build Settings>Other Linker Flags>添加`-ObjC`。  
2.3 Xcode切换到Build Phases选项卡，选择Link Binary With Libraries，点击+号，导入以下链接库：
```objective-c
libresolv.dylib  
libsqlite3.dylib  
libxml2.dylib
```

2.4 在appdelegate里导入YoukeSDK.h
```objective-c
#import "YoukeSDK.h"
```
2.5、获取Appkey，进入[YoukeSDK](http://t.youkesdk.com/)后台，注册账号并登录，登录后在左边菜单中选择 开发者>AppKey> 复制企业APPKEY
<center>![2015-06-23/5588cd1d1186a](http://box.kancloud.cn/2015-06-23_5588cd1d1186a.png)</center>
<br>
2.6 在didFinishLaunchingWithOptions中加入以下代码，将“企业APPKEY”改成上一步得到的APPKEY，集成完成。
```objective-c
//注册有客
[YoukeSDK registerYouKeWithAppKey:@"企业APPKEY"];
```

<br>
### 3、实现客服功能（即时沟通）
在需要实现客服聊天功能的地方（如按钮点击事件）中加入以下代码，即可跳转到客服聊天界面，客服列表中的客服人员，需在[YoukeSDK](http://t.youkesdk.com/)后台添加。
```objective-c
//跳转到客服聊天界面
[YoukeSDK contactCustomServiceWithViewController:self];
```  
<center>
![2015-06-24/558a12ed91242](http://box.kancloud.cn/2015-06-24_558a12ed91242.png)

<br>
### 4、实现数据分析

4.1 在商品详情页加入记录商品信息的代码，此处商品信息为必传，用于将用户访问的商品信息传到客服后台，方便客服了解用户当前正在浏览的商品，以及对用户访问的商品信息进行统计和数据分析功能；用户信息可传可不传。
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
4.2 在商品详情页的viewWillDisappear中加入以下代码，此步骤为了记录用户离开商品页面的时间、记录访问商品时长、进行数据统计和分析。
```objective-c
- (void)viewWillDisappear:(BOOL)animated{
     [YoukeSDK leaveGoods];
}
```
<center>![2015-06-23/5588d7f9d8a31](http://box.kancloud.cn/2015-06-23_5588d7f9d8a31.png)</center>
<br>
### 5、触碰营销功能
在后台触碰营销菜单进行相关设置，比如设置：在商品详情页停留1分钟或查看该商品10次以上，触发该计划。当用户浏览商品时间或次数达到该要求时，就会显示在创意管理中添加好的“优惠券”信息：
<center>![2015-06-23/5589499b42c05](http://box.kancloud.cn/2015-06-23_5589499b42c05.png)</center>

<center>![2015-06-23/55894a4392073](http://box.kancloud.cn/2015-06-23_55894a4392073.png)</center>
<br><br>
### 6、FAQ功能（在线问答）
请在[YoukeSDK](http://t.youkesdk.com/)后台添加问题分类和问题以及答案。在需要打开FAQ界面的地方（如按钮点击事件）添加以下代码，即可实现在线问答功能。
```objective-c
//跳转到FAQ界面
[YoukeSDK openHelpViewControllerWithViewController:self];
```
<center>![2015-06-23/5588d5b9c9618](http://box.kancloud.cn/2015-06-23_5588d5b9c9618.png)</center>

<center>![2015-06-23/5589478a99cad](http://box.kancloud.cn/2015-06-23_5589478a99cad.png)
</center>

<br>
### 7、更换皮肤
更换皮肤功能主要用于修改客服聊天列表界面、聊天详情界面、客服人员详情界面、FAQ界面等的导航栏颜色和导航文字的颜色。
如需修改icon等图片资源，请按步骤操作：在YoukeBundle.bundle文件上点击鼠标右键，选择“显示包内容”，找到对应的图片替换即可，注意图片名称和尺寸要相同。
```objective-c
/**
 *
 *  弹出客服聊天界面
 *
 *  @param ctrl              从哪个viewcontroller弹出聊天界面
 *  @param navigationBgColor 导航背景色
 *  @param titleColor        导航title文字颜色
 */
    [YoukeSDK contactCustomServiceWithViewController:self NavigationBackgroundColor:[UIColor whiteColor] TitleColor:[UIColor blackColor]];

/**
 *
 *  打开FAQ页面
 *
 *  @param ctrl              从哪个viewcontroller弹出FAQ界面
 *  @param navigationBgColor 导航背景色
 *  @param titleColor        导航title文字颜色
 */
    [YoukeSDK openHelpViewControllerWithViewController:self NavigationBackgroundColor:[UIColor whiteColor] TitleColor:[UIColor blackColor]];

```
