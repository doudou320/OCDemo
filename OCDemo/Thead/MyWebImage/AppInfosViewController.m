//
//  ImageListViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/23.
//

#import "AppInfosViewController.h"
#import "AppInfoCell.h"
#import "AppInfo.h"
#import "NSString+SandBox.h"
#import "SDDownloadOperationManager.h"

@interface AppInfosViewController ()

@property (nonatomic, strong) NSArray *appInfos;

@end

@implementation AppInfosViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (NSArray *)appInfos {
    if (!_appInfos) {
        _appInfos = [AppInfo appInfos];
    }
    return _appInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {

}

#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppInfoCell *cell = [AppInfoCell createCellWithTableView:tableView];
    AppInfo *appInfo = self.appInfos[indexPath.row];
    
    cell.appInfo = appInfo;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"队列的操作数:%zd",self.queue.operations.count);
}


@end
