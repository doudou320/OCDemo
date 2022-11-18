//
//  ImageCell.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/23.
//

#import "AppInfoCell.h"
#import "AppInfo.h"
#import <Masonry.h>
#import "UIImageView+WebCache.h"

@interface AppInfoCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabe;

@property (nonatomic, strong) UILabel *downloadLabel;

@end

@implementation AppInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.backgroundColor = [UIColor yellowColor];
        _iconView.image = [UIImage imageNamed:@"default"];
    }
    return _iconView;
}

- (UILabel *)nameLabe {
    if (!_nameLabe) {
        _nameLabe = [UILabel new];
        _nameLabe.textColor = [UIColor blackColor];
    }
    return _nameLabe;
}

- (UILabel *)downloadLabel {
    if (!_downloadLabel) {
        _downloadLabel = [UILabel new];
        _downloadLabel.textColor = [UIColor lightGrayColor];
    }
    return _downloadLabel;
}

- (void)setAppInfo:(AppInfo *)appInfo {
    if (appInfo) {
        [_iconView setImageURLString:appInfo.icon placeholderImage:[UIImage imageNamed:@"default"]];
        _nameLabe.text = appInfo.name;
        _downloadLabel.text = appInfo.download;
    }
}

+ (AppInfoCell *)createCellWithTableView:(UITableView *)tableView {
    static NSString *reusedID = @"AppInfoCell";
    AppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[AppInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusedID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
        [self setupSubViewsLayout];
    }
    return self;
}

- (void)setupViews {
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabe];
    [self.contentView addSubview:self.downloadLabel];
}

- (void)setupSubViewsLayout {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [_nameLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(15);
        make.top.equalTo(self.iconView);
    }];
    
    [_downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(15);
        make.bottom.equalTo(self.iconView);
    }];
}

@end
