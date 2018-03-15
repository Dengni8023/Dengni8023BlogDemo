//
//  KVC_KVOViewController.m
//  JGBlogExample
//
//  Created by Mei Jigao on 2018/3/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "KVC_KVOViewController.h"
#import <JGSourceBase/JGSourceBase.h>
#import "ExampleTableData.h"
#import "KVCPerson.h"
#import "KVOBook.h"

@interface KVC_KVOViewController () {
    
    KVOBook *memberBook;
}

@property (nonatomic, strong, readonly) NSArray<ExampleTableSectionInfo *> *exampleData;

@property (nonatomic, strong) KVOBook *propertyBook;

@end

@implementation KVC_KVOViewController

static int const PrivateKVOContext;
static void * KVOContext = 0;

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
                     ExampleTableSectionMake(@"常规读写",
                                             @[
                                               ExampleTableRowMake(@"常规Get、Set读写", @selector(personGetterSetterFunction)),
                                               ExampleTableRowMake(@"KVC读写", @selector(personKVCGettSetterFunction)),
                                               ]),
                     ExampleTableSectionMake(@"KVC键值搜索",
                                             @[
                                               ExampleTableRowMake(@"KVC Set属性键值搜索", @selector(personKVCSetSearchFunction)),
                                               ExampleTableRowMake(@"KVC Get属性键值搜索", @selector(personKVCGetSearchFunction)),
                                               ]),
                     ExampleTableSectionMake(@"KVC可变属性",
                                             @[
                                               ExampleTableRowMake(@"有序 集合属性读取、修改", @selector(personKVCMutableArrayFunction)),
                                               ExampleTableRowMake(@"无序 集合属性读取、修改", @selector(personKVCMutableSetFunction)),
                                               ]),
                     ExampleTableSectionMake(@"KVC集合方法",
                                             @[
                                               ExampleTableRowMake(@"KVC集合方法-简单方法", @selector(personKVCFuncCalculateFuntion)),
                                               ExampleTableRowMake(@"KVC集合方法-对象方法", @selector(personKVCFuncObjectFuntion)),
                                               ExampleTableRowMake(@"KVC集合方法-集合方法", @selector(personKVCFuncCollectFuntion)),
                                               ]),
                     ExampleTableSectionMake(@"KVO-KVB",
                                             @[
                                               ExampleTableRowMake(@"KVO-KVB添加移除测试-页面推出时移除", @selector(bookKVOObserverAddRemoveFunction)),
                                               ExampleTableRowMake(@"KVO值变化测试", @selector(bookKVOObserverValueChangeFunction)),
                                               ]),
                     ];
}

- (void)dealloc {
    
    JGLog(@"<%@: %p>, %@", NSStringFromClass([self class]), self, self.title);
    
    [memberBook removeObserver:self forKeyPath:@"name"];
    [memberBook removeObserver:self forKeyPath:@"name"];
    [memberBook removeObserver:self forKeyPath:@"name" context:KVOContext];
    //[memberBook removeObserver:self forKeyPath:@"name" context:(void *)&PrivateKVOContext];
    [_propertyBook removeObserver:self forKeyPath:@"name"];
}

#pragma mark - Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"KVC、KVB、KVO";
    
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

#pragma mark - KVC
// 使用Getter、Setter方法，必须有公有property
- (void)personGetterSetterFunction {
    
    KVCPerson *p = [[KVCPerson alloc] initWithName:@"姓名" birthdate:@"2017-01-01"];
    p.name = @"Setter-姓名";
    
    Company *c = [[Company alloc] initWithName:@"公司名称" tel:@"400-800-xxxx"];
    p.company = c;
    
    // 集合数据
    p.interest = @[@"Setter-Interest_1", @"Setter-Interest_2"];
    p.ownedBooks = [NSSet setWithArray:@[@"Setter-Book_1", @"Setter-Book_2", @"Setter-Book_3"]];
    
    JGLog(@"\nName = %@;"
          "\nID NO. = %@;"
          "\nAge = %zd;"
          "\nCompany = <Name : %@; Telphone : %@>"
          "\nInterest = %@"
          "\nBooks = %@",
          p.name,
          p.idNumber,
          p.age,
          p.company.name, p.company.telphone,
          p.interest,
          p.ownedBooks
          );
}

// 使用KVC方法，property不需要公有（内部声明的私有Property、成员变量均可）
- (void)personKVCGettSetterFunction {
    
    KVCPerson *p = [[KVCPerson alloc] initWithName:@"姓名" birthdate:@"2017-01-01"];
    
    // KVV验证
    [p setValue:@"KVC-姓名" forKey:@"name"];
    [p setValue:@"姓名" forKey:@"name"];
    
    Company *c = [[Company alloc] initWithName:@"公司名称" tel:@"400-800-xxxx"];
    [p setValue:c forKey:@"company"];
    [p setValue:@"400-800-KVC" forKeyPath:@"company.telphone"];
    
    // 集合数据
    [p setValue:@[@"KVC-Interest_1", @"KVC-Interest_2"] forKey:@"interest"];
    [p setValue:[NSSet setWithArray:@[@"KVC-Book_1", @"KVC-Book_2", @"KVC-Book_3"]] forKey:@"ownedBooks"];
    
    JGLog(@"\nName = %@;"
          "\nID NO. = %@;"
          "\nAge = %@;"
          "\nCompany = <Name : %@; Telphone : %@>"
          "\nInterest = %@"
          "\nBooks = %@",
          [p valueForKey:@"name"],
          [p valueForKey:@"idNumber"],
          [p valueForKey:@"age"],
          [p valueForKeyPath:@"company.name"], [p valueForKeyPath:@"company.telphone"],
          [p valueForKey:@"interest"],
          [p valueForKey:@"ownedBooks"]
          );
}

// KVC Set键值搜索
- (void)personKVCSetSearchFunction {
    
    KVCPerson *p = [[KVCPerson alloc] initWithName:@"姓名" birthdate:@"2017-01-01"];
    [p setValue:@"KVC-姓名" forKey:@"nameSetString"];
    
    JGLog(@"\nName = %@;"
          "\nID NO. = %@;"
          "\nAge = %@;"
          "\nNameSetString = %@",
          [p valueForKey:@"name"],
          [p valueForKey:@"idNumber"],
          [p valueForKey:@"age"],
          [p valueForKey:@"nameSetString"]
          );
}

// KVC Get键值搜索
- (void)personKVCGetSearchFunction {
    
    KVCPerson *p = [[KVCPerson alloc] initWithName:@"姓名" birthdate:@"2017-01-01"];
    [p setValue:@[@"KVC-Interest_1", @"KVC-Interest_2"] forKey:@"interest"];
    
    JGLog(@"\nName = %@;"
          "\nID NO. = %@;"
          "\nAge = %@;"
          "\nInterestCollect = %@",
          [p valueForKey:@"name"],
          [p valueForKey:@"idNumber"],
          [p valueForKey:@"age"],
          [p valueForKey:@"interestCollect"]
          );
}

// KVC获取集合
- (void)personKVCMutableArrayFunction {
    
    KVCPerson *p = [[KVCPerson alloc] initWithName:@"姓名" birthdate:@"2017-01-01"];
    [p setValue:@[@"KVC-Interest_1", @"KVC-Interest_2"] forKey:@"interest"];
    
    id oriValue = [p valueForKey:@"interest"];
    id multiValue = [p mutableArrayValueForKey:@"interest"];
    NSMutableArray *multiModify = [p mutableArrayValueForKey:@"interest"];
    [multiModify addObject:@"Add Interest-1"];
    
    JGLog(@"\nName = %@;"
          "\nID NO. = %@;"
          "\nInterest = %@"
          "\nOri Interest = %@;"
          "\nMulti Interest = %@"
          "\nModify Interest = %@",
          [p valueForKey:@"name"],
          [p valueForKey:@"idNumber"],
          [p valueForKey:@"interest"],
          oriValue,
          multiValue,
          multiModify
          );
}

// KVC获取可变集合方法测试
- (void)personKVCMutableSetFunction {
    
    KVCPerson *p = [[KVCPerson alloc] initWithName:@"姓名" birthdate:@"2017-01-01"];
    [p setValue:[NSSet setWithArray:@[@"KVC-Book_1", @"KVC-Book_2", @"KVC-Book_3"]] forKey:@"ownedBooks"];
    
    id oriValue = [p valueForKey:@"ownedBooks"];
    id multiValue = [p mutableArrayValueForKey:@"ownedBooks"];
    NSMutableArray *multiModify = [p mutableArrayValueForKey:@"ownedBooks"];
    [multiModify addObject:@"Add Book-1"];
    
    JGLog(@"\nName = %@;"
          "\nID NO. = %@;"
          "\nBook = %@"
          "\nOri Book = %@;"
          "\nMulti Book = %@"
          "\nModify Book = %@",
          [p valueForKey:@"name"],
          [p valueForKey:@"idNumber"],
          [p valueForKey:@"ownedBooks"],
          oriValue,
          multiValue,
          multiModify
          );
}

- (void)personKVCFuncCalculateFuntion {
    
    NSMutableArray *persons = @[].mutableCopy;
    for (NSInteger i = 0; i < 8; i++) {
        
        KVCPerson *p = [[KVCPerson alloc] initWithName:[NSString stringWithFormat:@"姓名-%zd", i] birthdate:[NSString stringWithFormat:@"%04zd-01-01", 2000 + i]];
        [persons addObject:p];
    }
    
    JGLog(@"\nAvg Age = %@"
          "\nCount Age = %@"
          "\nMax Age = %@"
          "\nMin Age = %@"
          "\nSum Age = %@",
          [persons valueForKeyPath:@"@avg.age"],
          [persons valueForKeyPath:@"@count"],
          [persons valueForKeyPath:@"@max.age"],
          [persons valueForKeyPath:@"@min.age"],
          [persons valueForKeyPath:@"@sum.age"]
          );
}

- (void)personKVCFuncObjectFuntion {
    
    NSMutableArray *persons = @[].mutableCopy;
    for (NSInteger i = 0; i < 8; i++) {
        
        KVCPerson *p = [[KVCPerson alloc] initWithName:[NSString stringWithFormat:@"Name-%zd", i % 4] birthdate:[NSString stringWithFormat:@"%04zd-01-01", 2000 + i]];
        [persons addObject:p];
    }
    
    id distinctUnion = [persons valueForKeyPath:@"@distinctUnionOfObjects.name"];
    id allUnion = [persons valueForKeyPath:@"@unionOfObjects.name"];
    
    JGLog(@"\nDistinct Union Names = <%@ : %@>"
          "\nUnion Names = <%@ : %@>",
          NSStringFromClass([distinctUnion class]), distinctUnion,
          NSStringFromClass([allUnion class]), allUnion
          );
}

- (void)personKVCFuncCollectFuntion {
    
    NSMutableArray *persons = @[].mutableCopy;
    for (NSInteger i = 0; i < 8; i++) {
        
        KVCPerson *p = [[KVCPerson alloc] initWithName:[NSString stringWithFormat:@"Name-%zd", i % 4] birthdate:[NSString stringWithFormat:@"%04zd-01-01", 2000 + i]];
        [p setValue:@[@"KVC-Interest_1", @"KVC-Interest_2"] forKey:@"interest"];
        [p setValue:[NSSet setWithArray:@[@"KVC-Book_1", @"KVC-Book_2", @"KVC-Book_3"]] forKey:@"ownedBooks"];
        [persons addObject:p];
    }
    
    id distinctUnionInterest = [persons valueForKeyPath:@"@distinctUnionOfArrays.interest"];
    id allUnionInterest = [persons valueForKeyPath:@"@unionOfArrays.interest"];
    //id allUnionInterestSet = [persons valueForKeyPath:@"@distinctUnionOfSets.interest"]; // Array不支持Sets操作，崩溃
    
    JGLog(@"\nDistinct Union Array Interest = <%@ : %@>"
          "\nUnion Array Interest = <%@ : %@>",
          NSStringFromClass([distinctUnionInterest class]), distinctUnionInterest,
          NSStringFromClass([allUnionInterest class]), allUnionInterest
          );
    
    id distinctUnionBook = [persons valueForKeyPath:@"@distinctUnionOfArrays.ownedBooks"];
    id allUnionBook = [persons valueForKeyPath:@"@unionOfArrays.ownedBooks"];
    id allUnionBookSet = [persons valueForKeyPath:@"@distinctUnionOfSets.ownedBooks"];
    
    JGLog(@"\nDistinct Union Array Book = <%@ : %@>"
          "\nUnion Array Book = <%@ : %@>"
          "\nUnion Set Book = <%@ : %@>",
          NSStringFromClass([distinctUnionBook class]), distinctUnionBook,
          NSStringFromClass([allUnionBook class]), allUnionBook,
          NSStringFromClass([allUnionBookSet class]), allUnionBookSet
          );
}

#pragma mark - KVO
- (void)bookKVOObserverAddRemoveFunction {

    // 成员对象，添加、移除测试
    if (!memberBook) {
        
        memberBook = [[KVOBook alloc] initWithName:@"Member Book Name" originPrice:1200 publish:@"Publish Member Goverment Name"];
        [memberBook addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
        [memberBook addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(void *)&PrivateKVOContext];
        [memberBook addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:KVOContext];
    }

    // 属性对象，添加、移除测试
    if (!_propertyBook) {
        
        _propertyBook = [[KVOBook alloc] initWithName:@"Property Book Name" originPrice:1200 publish:@"Publish Property Goverment Name"];
        [_propertyBook addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:KVOContext];
    }
}

- (void)bookKVOObserverValueChangeFunction {
    
    // 局部对象
    KVOBook *b = [[KVOBook alloc] initWithName:@"Book Name" originPrice:1200 publish:@"Publish Goverment Name"];
    [b addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:KVOContext];
    [b addObserver:self forKeyPath:@"price" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:KVOContext];
    [b addObserver:self forKeyPath:@"discount" options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:KVOContext];
    
    b.name = @"KVO-Book Name";
    b.price = 800;
    
    // 局部对象内存释放前必需移除观察者
    //[b removeObserver:self forKeyPath:@"name"];
    //[b removeObserver:self forKeyPath:@"price"];
    //[b removeObserver:self forKeyPath:@"discount"];
    [b removeObserver:self forKeyPath:@"name" context:KVOContext];
    [b removeObserver:self forKeyPath:@"price" context:KVOContext];
    [b removeObserver:self forKeyPath:@"discount" context:KVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    // 必须有自定义处理，如直接调用 [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];则崩溃
    if (context == (void *)&PrivateKVOContext || context == KVOContext) {
        
        NSLog(@"%zd, %zd", context == (void *)&PrivateKVOContext, context == KVOContext);
        NSLog(@"收到KVO消息 ===========>>>>>>>"
              "\n%@, %@ = %@"
              "\n\n",
              object, keyPath,
              change
              );
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - End

@end

