//
//  ViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/7/10.
//

#import "ViewController.h"
#import "CategoryViewController.h"
#import "Algorithm/AlgorithmListViewController.h"
#import "ResponserChain/ResponseChainViewController.h"
#import "Thead/ThreadRootViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

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
        NSDictionary * categoryDict = @{@"id": @"category", @"title": @"分类"};
        NSDictionary * algorithmDict = @{@"id": @"algorithm", @"title": @"算法"};
        NSDictionary * responseChainDict = @{@"id": @"responseChain", @"title": @"事件响应"};
        NSDictionary * nsOperationDict = @{@"id": @"multiThread", @"title": @"多线程"};

        NSArray * array = [[NSArray alloc] initWithObjects:categoryDict, algorithmDict, responseChainDict, nsOperationDict, nil];
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
        if ([ID isEqualToString: @"category"]) {
            vc = [[CategoryViewController alloc] init];
        } else if ([ID isEqualToString: @"algorithm"]) {
            vc = [[AlgorithmListViewController alloc] init];
        } else if ([ID isEqualToString: @"responseChain"]) {
            vc = [[ResponseChainViewController alloc] init];
        } else if ([ID isEqualToString: @"multiThread"]) {
            vc = [[ThreadRootViewController alloc] init];
        }
        
        [self.navigationController pushViewController: vc animated: YES];

    }
}

@end
