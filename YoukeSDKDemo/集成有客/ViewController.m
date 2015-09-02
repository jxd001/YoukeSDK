//
//  ZPFViewController.m
//  云商通
//
//  Created by ss on 15/4/20.
//  Copyright (c) 2015年 zipingfang. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "YoukeSDK.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UILabel *latestMessageLabel;
    NSArray *listData; //聊天列表
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 320, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"请使用以下DEMO账号登录 t.youkesdk.com";
    [header addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 320, 20)];
    label1.text = @"账号 youkedemo@youkesdk.com  密码 123456";
    label1.font = [UIFont systemFontOfSize:12.0f];
    [header addSubview:label1];
    
    table.tableHeaderView = header;
    
    
    //获取新消息数方式一：直接获取
    UITableViewCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
    NSInteger count = [YoukeSDK getNewMessageCount];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(count)];


    //方式二：Block方式实时监听新消息数
    [YoukeSDK sharedInstance].newMessageBlocker = ^(NSInteger newMessageCount, NSString *messageContent, NSString *messageFrom)
    {
        NSLog(@"getNewMessageCount:%@",@(newMessageCount));

        UITableViewCell *cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(newMessageCount)];
        
        NSString *message = [NSString stringWithFormat:@"%@:%@\n",messageFrom,messageContent];
        latestMessageLabel.text = message;
    };

    //聊天详情页中的商品被点击
    [YoukeSDK sharedInstance].goodsClickBlocker = ^(NSString *goodsId, UIViewController *viewController)
    {
        NSLog(@"goodsId:%@",goodsId);
    };

    //聊天详情页中的订单被点击
    [YoukeSDK sharedInstance].orderClickBlocker = ^(NSString *orderId, UIViewController *viewController)
    {
        NSLog(@"orderId:%@",orderId);
    };


    //将用户与openfire绑定
    
    //使用这句模拟普通用户
    [YoukeSDK bindOpenFireWithUserId:@"444" UserPhoto:@"http://tp3.sinaimg.cn/5587598398/50/5724069235/1" UserName:@"淘淘的店" Tell:@"123231213" Email:@"12323@123.com" QQ:@"12323" OtherText:@""];

    //使用这句模拟商家用户
//    [YoukeSDK bindOpenFireWithUserId:@"888" UserPhoto:@"http://tp3.sinaimg.cn/5587598398/50/5724069235/1" UserName:@"淘淘" Tell:@"123231213" Email:@"12323@123.com" QQ:@"12323" OtherText:@""];

}

-(void)viewWillAppear:(BOOL)animated{
#ifdef DEBUG
    //模拟访问商品
    [YoukeSDK visitGoodsWithGoodsId:@"123" GoodsTitle:@"吊带背心裙套装" GoodsPrice:@"988" GoodsImg:@"http://imgtest-lx.meilishuo.net/pic/_o/84/da/3c657d2116f3ff0ad32d25ee6d58_800_1044.jpg" UserName:nil UserPhoto:nil CallNumber:nil Email:nil QQ:nil Text:nil];
#endif
    
    //获取聊天列表
    [YoukeSDK getPointToPointTalkListDataWithMyUserid:@"444" success:^(NSArray *listArray) {
        NSLog(@"listArray:%@",listArray);
        listData = listArray;
        [table reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
#ifdef DEBUG
    //模拟离开商品
    [YoukeSDK leaveGoods];
#endif
}



#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;//联系客服，查看帮助
    }
    else if (section==1){
        return 2;//联系商家，获取商家聊天列表
    }
    else if (section==2){
        return 1;//显示最近消息
    }
    else if (section==3){
        return listData.count;//获取商家聊天列表，打开商家聊天窗口
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"联系客服";
        }
        else if(indexPath.row==1){
            cell.textLabel.text = @"查看帮助";
        }
    }
    else if(indexPath.section==1){
        if (indexPath.row==0) {
            cell.textLabel.text = @"联系商家（普通用户使用）";
        }
        else if(indexPath.row==1){
            cell.textLabel.text = @"获取商家聊天列表（商家用户使用）";
        }
    }
    else if(indexPath.section==2){
        if (!latestMessageLabel) {
            latestMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 44)];
            [cell addSubview:latestMessageLabel];
            
            NSInteger count = [YoukeSDK getNewMessageCount];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(count)];
            
        }
    }
    else if(indexPath.section==3){
        YoukeMessageListObject *obj = listData[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:obj.userAvatar]];
        cell.textLabel.text = obj.userName;
        
        NSString *content = obj.messageContent;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@（%@）",content,obj.messageTime];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"客服&帮助";
    }
    else if(section==1){
        return @"点对点单聊";
    }
    else if(section==2){
        return @"最新消息";
    }
    else{
        return @"开发者获取聊天列表";
    }
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //模拟浏览订单
            [YoukeSDK visitOrderWithOrderId:@"44234234" OrderTime:@"08-21 12:20" GoodsTitle:@"2014新款 漂流木帆布包男" GoodsImage:@"http://img10.360buyimg.com/N6/s60x60_g13/M04/00/08/rBEhVFHeVO8IAAAAAAOkd-fxdusAAA8awB92ecAA6SP334.jpg" GoodsPrice:@"99"];
            
            //打开客服列表
            [YoukeSDK contactCustomServiceWithViewController:self];
        }
        else if(indexPath.row==1){
            //打开帮助
            [YoukeSDK openHelpViewControllerWithViewController:self];
        }
    }
    else if(indexPath.section==1){
        if (indexPath.row==0) {
            //模拟浏览订单
            [YoukeSDK visitOrderWithOrderId:@"9888444368"
                                  OrderTime:@"08-21 12:20"
                                 GoodsTitle:@"2014新款 漂流木帆布包男"
                                 GoodsImage:@"http://img10.360buyimg.com/N6/s60x60_g13/M04/00/08/rBEhVFHeVO8IAAAAAAOkd-fxdusAAA8awB92ecAA6SP334.jpg"
                                 GoodsPrice:@"99"];
            
            /**
             *
             *  实现点对点聊天，比如和APP用户体系内的某个“商家”
             *
             *  @param myUserId 登录用户的用户id
             *  @param toUserId  聊天对象的用户id
             *  @param ctrl     从哪个viewcontroller进入
             */
            [YoukeSDK openPointToPointTalkViewControllerWithMyUserid:@"888" ToUserId:@"444" ViewController:self];
        }
        else if(indexPath.row==1){
            /**
             *
             *  实现点对点聊天，比如和APP用户体系内的某个“商家”
             *
             *  @param myUserId 登录用户的用户id
             *  @param toUserId  聊天对象的用户id
             *  @param ctrl     从哪个viewcontroller进入
             */
            [YoukeSDK openPointToPointTalkListWithMyUserId:@"444" ViewController:self];
        }
    }
    else if(indexPath.section==2){
       	
    }
    else {
        //直接进入聊天界面
        YoukeMessageListObject *obj = listData[indexPath.row];
        [YoukeSDK openPointToPointTalkViewControllerWithMyUserid:obj.fromUid ToUserId:obj.toUid ViewController:self];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
