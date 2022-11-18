//
//  AlgorithmListViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/8/10.
//

#import "AlgorithmListViewController.h"
#import "AlgorithmDetailViewController.h"

@interface AlgorithmListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AlgorithmListViewController

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
        NSDictionary * subsequenceDict = @{@"id": @"subsequence", @"title": @"最大子序列"};
        NSDictionary * rotateDigitsDict = @{@"id": @"rotateDigits", @"title": @"旋转数字"};
        NSArray * array = [[NSArray alloc] initWithObjects: subsequenceDict, rotateDigitsDict,nil];
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
        AlgorithmDetailViewController *detailVC = [[AlgorithmDetailViewController alloc] init];
        detailVC.algorithmID = ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end
