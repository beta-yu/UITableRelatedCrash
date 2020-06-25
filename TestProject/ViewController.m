//
//  ViewController.m
//  TestProject
//
//  Created by qiyu on 2020/6/18.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrOfSection0;
@property (nonatomic, strong) NSMutableArray *arrOfSection1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat headerViewHeight = 100;
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, headerViewHeight)];
    
    CGPoint headerViewOrigin = _headerView.frame.origin;
    CGSize headerViewSize = _headerView.frame.size;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(headerViewOrigin.x, headerViewOrigin.y + headerViewSize.height, self.view.frame.size.width, self.view.frame.size.height - 83 - headerViewHeight) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_headerView];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIButton *insertButton = [self addButtonWithTitle:@"insert" frame:CGRectMake(headerViewOrigin.x + 30, headerViewOrigin.y + headerViewSize.height - 40, 60, 30) action:@selector(insertRows)];
    
    UIButton *deleteButton = [self addButtonWithTitle:@"delete" frame:CGRectMake(insertButton.frame.origin.x + insertButton.frame.size.width + 60, headerViewOrigin.y + headerViewSize.height - 40, 60, 30) action:@selector(deleteRows)];
    
    [self addButtonWithTitle:@"reloadSections" frame:CGRectMake(deleteButton.frame.origin.x + deleteButton.frame.size.width + 60, headerViewOrigin.y + headerViewSize.height - 40, 150, 30) action:@selector(reloadSections)];
    
    _arrOfSection0 = [NSMutableArray arrayWithObjects:@1, @2, nil];
    _arrOfSection1 = [_arrOfSection0 mutableCopy];
}

- (UIButton *)addButtonWithTitle:(NSString *)title frame:(CGRect)frame action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [self.headerView addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)insertRows {
    [self.arrOfSection0 addObject:@(self.arrOfSection0.count + 1)];
    [self.arrOfSection0 addObject:@(self.arrOfSection0.count + 1)];
    
//    [self.tableView reloadData];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.arrOfSection0.count - 2 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.arrOfSection0.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
//    NSArray<NSIndexPath *> *indexPaths = @[[NSIndexPath indexPathForRow:self.arrOfSection0.count - 2 inSection:0], [NSIndexPath indexPathForRow:self.arrOfSection0.count - 1 inSection:0]];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteRows {
    if (self.arrOfSection0.count < 2) {
        return;
    }
    [self.arrOfSection0 removeObjectAtIndex:0];
    [self.arrOfSection0 removeObjectAtIndex:0];
    
    NSArray<NSIndexPath *> *indexPaths = @[[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0]];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)reloadSections {
    // 改变section0数据源
    if (self.arrOfSection0.count > 1) {
        [self.arrOfSection0 removeObjectAtIndex:0];
    }
    // reload section1
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%s", __func__);
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s-section:%ld", __func__, section);
    if (section == 0) {
        return self.arrOfSection0.count;
    }
    return self.arrOfSection1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s section: %ld  row: %ld", __func__, indexPath.section, indexPath.row);
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId"];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseId"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.label.text = [NSString stringWithFormat:@"%@", self.arrOfSection0[indexPath.row]];
    } else {
        cell.label.text = [NSString stringWithFormat:@"%@", self.arrOfSection1[indexPath.row]];
    }
    return cell;
}


@end
