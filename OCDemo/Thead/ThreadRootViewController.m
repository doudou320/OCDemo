//
//  ThreadRootViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/19.
//

#import "ThreadRootViewController.h"
#import "PThread/PThreadViewController.h"
#import "NSThread/NSThreadViewController.h"
#import "GCD/GCDViewController.h"
#import "NSoperation/NSOperationViewController.h"
#import "NSoperation/ErnieViewController.h"
#import "Singleton/SingletonViewController.h"
#import "MyWebImage/AppInfosViewController.h"

@interface ThreadRootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ThreadRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubview];
}

- (void)loadSubview {
    [self.view addSubview: self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame: UIScreen.mainScreen.bounds style: UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass: UITableViewCell.class forCellReuseIdentifier: @"UITableViewCell"];
        _tableView = tableView;
    }
    return  _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSDictionary * categoryDict = @{@"id": @"pthread", @"title": @"pthread"};
        NSDictionary * algorithmDict = @{@"id": @"NSThread", @"title": @"NSThread"};
        NSDictionary * responseChainDict = @{@"id": @"GCD", @"title": @"GCD"};
        NSDictionary * nsOperationDict = @{@"id": @"nsoperation", @"title": @"NSOperation"};
        NSDictionary * singletonDict = @{@"id": @"singleton", @"title": @"单例"};
        NSDictionary * downloadImgDict = @{@"id": @"download", @"title": @"异步下载图片"};

        NSArray * array = [[NSArray alloc] initWithObjects: categoryDict, algorithmDict, responseChainDict, nsOperationDict, singletonDict, downloadImgDict, nil];
        _dataSource = array;
    }
    
    return _dataSource;
}

#pragma UITableViewDataSource && UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"UITableViewCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"UITableViewCell"];
    }
    cell.contentView.backgroundColor = [UIColor systemOrangeColor];
    if (indexPath.row < self.dataSource.count) {
        NSDictionary *dict = self.dataSource[indexPath.row];
        cell.textLabel.text = dict[@"title"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSource.count) {
        NSDictionary *dict = self.dataSource[indexPath.row];
        NSString *ID = [dict objectForKey: @"id"];
        UIViewController *vc = nil;
        if ([ID isEqualToString: @"pthread"]) {
            vc = [[PThreadViewController alloc] init];
        } else if ([ID isEqualToString: @"NSThread"]) {
            vc = [[NSThreadViewController alloc] init];
        } else if ([ID isEqualToString: @"GCD"]) {
            vc = [[GCDViewController alloc] init];
        } else if ([ID isEqualToString: @"nsoperation"]) {
            vc = [[NSOperationViewController alloc] init];
        } else if ([ID isEqualToString:@"singleton"]) {
            vc = [[SingletonViewController alloc] init];
        } else if ([ID isEqualToString:@"download"]) {
            vc = [[AppInfosViewController alloc] init];
        }
        
        [self.navigationController pushViewController: vc animated: YES];

    }
}

@end
