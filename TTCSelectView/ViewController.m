//
//  ViewController.m
//  TTCSelectView
//
//  Created by Vision on 15/9/16.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "ViewController.h"
#import "TTCSelectView.h"
#import "UIView+ITTAdditions.h"

@interface ViewController ()<
TTCSelectViewDataSource,
TTCSelectViewDelegate>

@property (nonatomic, strong) NSArray *letters;
@property (nonatomic, strong) NSArray *brand;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _letters = @[@"热门", @"A", @"B", @"C",
                         @"D", @"E", @"F", @"G",
                         @"H", @"I", @"J", @"K",
                         @"L", @"M", @"N", @"O",
                         @"P", @"Q", @"R", @"S",
                         @"T", @"U", @"V", @"W",
                         @"X", @"Y", @"Z"];
    _brand = @[@"奥迪", @"￼AC Schnitzer", @"Artega", @"奔驰", @"宝马", @"保时捷", @"宝沃", @"巴博斯", @"大众", @"卡尔森", @"KTM", @"MINI", @"欧宝", @"smart", @"STARTECH", @"泰卡特", @"威兹曼", @"西雅特", @"日韩品牌", @"阿尔特", @"本田", @"丰田", @"光冈", @"铃木", @"雷克萨斯", @"朗世", @"马自达", @"讴歌", @"日产", @"三菱", @"斯巴鲁", @"五十铃", @"英菲尼迪", @"起亚", @"双龙", @"现代", @"别克", @"道奇", @"底特律电动车", @"福特", @"GMC", @"Jeep", @"凯迪拉克", @"克莱斯勒", @"林肯", @"乔治·巴顿", @"山姆", @"赛麟SALEEN", @"特斯拉", @"雪佛兰", @"星客特欧系其他", @"标致", @"DS", @"雷诺", @"PGO", @"雪铁龙", @"阿斯顿·马丁", @"宾利", @"捷豹", @"路虎", @"劳斯莱斯", @"路特斯", @"迈凯伦", @"摩根", @"Noble", @"阿尔法·罗密欧", @"布加迪", @"法拉利", @"菲亚特", @"Faralli Mazzanti", @"兰博基尼", @"玛莎拉蒂", @"帕加尼", @"依维柯", @"科尼赛克", @"沃尔沃", @"斯柯达自主品牌", @"比亚迪", @"宝骏", @"北汽幻速", @"北汽绅宝", @"北京", @"奔腾", @"北汽制造", @"北汽威旺", @"北汽新能源", @"比速汽车", @"北汽瑞丽", @"长安轿车", @"长安商用", @"长城", @"昌河", @"长安跨越", @"长城华冠", @"成功", @"长久汽车", @"东风风行", @"东风风神", @"东风风光", @"东南", @"东风小康", @"东风·郑州日产", @"东风风度", @"东风御风", @"东风风诺", @"福田", @"福迪", @"福汽启腾", @"飞驰商务车", @"广汽传祺", @"观致汽车", @"广汽吉奥", @"广汽中兴", @"广汽日野", @"哈弗", @"海马", @"红旗", @"华泰", @"黄海", @"汉腾", @"哈飞", @"华颂", @"华泰新能源", @"海马商用车", @"海格", @"汇众", @"恒天汽车", @"华凯", @"吉利汽车", @"江淮", @"金杯", @"江铃", @"金龙", @"九龙", @"江铃集团轻汽", @"金旅客车", @"江南", @"凯翼", @"开瑞", @"科瑞斯的", @"卡威", @"康迪全球鹰电动汽车", @"陆风", @"猎豹汽车", @"力帆", @"莲花", @"蓝海房车", @"雷丁电动", @"理念", @"陆地方舟", @"LeSEE", @"领志", @"MG", @"美亚", @"纳智捷", @"欧朗", @"欧联", @"奇瑞", @"启辰", @"庆铃", @"荣威", @"上汽大通MAXUS", @"斯威", @"陕汽通家", @"上喆汽车", @"腾势", @"五菱", @"潍柴英致", @"威麟", @"潍柴欧睿", @"新凯", @"一汽", @"驭胜", @"野马汽车", @"宇通", @"永源", @"游侠汽车", @"御捷", @"扬州亚星客车", @"众泰", @"中华", @"知豆"];
    
    TTCSelectView *newView = [TTCSelectView tTCSelectViewWithFrame:CGRectMake(0, 30, self.view.width, self.view.height - 30) indexArray:_letters style:TTCSelectViewStyleCar];
    newView.delegate = self;
    newView.dataSource = self;
    [self.view addSubview:newView];
}
- (NSInteger)selectView:(TTCSelectView *)selectView numberOfSectionsInTableView:(TTCBaseTableView *)tableView{
    if (tableView.level == 2) {
        return 2;
    }
    if (tableView.level == 3) {
        return 1;
    }
    return [_letters count];
}
- (NSString *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView.level == 3) {
        
    }
    return _letters[section];
}

- (NSInteger)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_letters count];
}

- (TTCBaseTableViewCell *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"cell%ld",(long)tableView.level];
    TTCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TTCBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (tableView.level == 1 || tableView.level == 3) {
        cell.textLabel.text = _brand[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
    } else {
        cell.textLabel.text = _letters[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
    }
    
    return cell;
}

- (void)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd", tableView.level);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
