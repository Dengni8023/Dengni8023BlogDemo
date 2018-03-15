//
//  TableViewController.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/7.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "TableViewController.h"
#import <JGSourceBase/JGSourceBase.h>
#import "ExampleTableData.h"
#import "KVC_KVOViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray<ExampleTableSectionInfo *> *exampleData;

@end

@implementation TableViewController

#pragma mark - init & dealloc
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initDatas];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        
        [self initDatas];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self initDatas];
    }
    return self;
}

- (void)initDatas {
    
    _exampleData = @[
                    ExampleTableSectionMake(@"2018",
                                            @[
                                              ExampleTableRowMake(@"KVC、KVB、KVO", @selector(jumpToKVC_KVOController)),
                                              ]),
                    ];
}

#pragma mark - Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"JGBlogExample";
    
    self.tableView.rowHeight = 48;
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JGReuseIdentifier(UITableViewCell)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.exampleData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.exampleData[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGReuseIdentifier(UITableViewCell) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = self.exampleData[indexPath.section].rows[indexPath.row].title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.exampleData[section].title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SEL selctor = self.exampleData[indexPath.section].rows[indexPath.row].selector;
    if ([self respondsToSelector:selctor]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selctor];
#pragma clang diagnostic pop
        
        // 避免警告
        //IMP imp = [self methodForSelector:selctor];
        //void (*func)(id, SEL) = (void *)imp;
        //func(self,selctor);
    }
}

#pragma mark - Demo Control
- (void)jumpToKVC_KVOController {
    
    UIViewController *vcT = [[KVC_KVOViewController alloc] init];
    [self.navigationController pushViewController:vcT animated:YES];
}

#pragma mark - End

@end
