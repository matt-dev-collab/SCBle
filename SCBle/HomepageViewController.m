//
//  HomepageViewController.m
//  SCBle
//
//  Created by 吗啡 on 15/8/30.
//  Copyright (c) 2015年 ___M.T.F___. All rights reserved.
//

#import "HomepageViewController.h"
#import "DeviceOperatorViewController.h"
#import "DeviceStatusCell.h"
#import "SBDevice.h"

@interface HomepageViewController ()<SWTableViewCellDelegate>

// 设备列表
@property (nonatomic, weak) IBOutlet UITableView *devicesView;
// 搜索到得所有设备
@property (nonatomic, strong) NSArray *devices;

@end

@implementation HomepageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // ADD CODE HERE
    self.navigationItem.titleView = [self customNavigationTitleView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(scanDevices:)];
    self.navigationItem.rightBarButtonItem = rightItem;

    // 构造数据
    SBDevice *device = [SBDevice new];
    device.on = NO;
    device.name = @"客厅情感灯";
    
    SBDevice *device2 = [SBDevice new];
    device2.on = NO;
    device2.name = @"蓝牙情感灯2";
    
    SBDevice *device3 = [SBDevice new];
    device3.on = NO;
    device3.name = @"蓝牙情感灯3";
    
    self.devices = [NSArray arrayWithObjects:device, device2, device3, nil];
    [self.devicesView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.navigationBar.hidden = NO;
    }];
}

// 自定义导航栏标题视图
- (UIView *)customNavigationTitleView
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"智能音乐灯"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:76/255.0 green:223/255.0 blue:190/255.0 alpha:1] range:NSMakeRange(0, 2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1] range:NSMakeRange(2, 3)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.attributedText = attributedString;
    [titleLabel sizeToFit];
    return titleLabel;
}

#pragma mark -- 搜索设备
- (void)scanDevices:(id)sender
{
    
}


#pragma mark -- 切换设备状态
- (IBAction)switchDeviceItem:(UIButton *)sender
{
    static BOOL on = YES;
    if (on) {
        [sender setImage:[UIImage imageNamed:@"kaiguan_close"] forState:UIControlStateNormal];
        on = NO;
    }else {
        [sender setImage:[UIImage imageNamed:@"kaiguan_open"] forState:UIControlStateNormal];
        on = YES;
    }
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceStatusCell"];
    SBDevice *device = [self.devices objectAtIndex:indexPath.row];
    [cell fillCellWithDeviceInfo:device];
    
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DeviceOperatorViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DeviceOperatorIdentify"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"cehua_bianji"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"cehua_shijian"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                icon:[UIImage imageNamed:@"cehua_shanchu"]];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"0");
            break;
        }
        case 1:
        {
            NSLog(@"1");
            break;
        }
        case 2:
            NSLog(@"2");
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}



@end
