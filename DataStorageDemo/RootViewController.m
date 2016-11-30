//
//  RootViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/24.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "RootViewController.h"
#import "PlistViewController.h"
#import "UserDefaultViewController.h"
#import "KeyedArchiverViewController.h"
#import "FMDBViewController.h"
#import "CoreDataViewController.h"




@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *ListArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"数据存储";
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kkk) name:@"closelogin" object:nil];
}

-(void)kkk
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenCell = @"idenCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:idenCell];
    }
    cell.textLabel.text = self.ListArr[indexPath.row];
    return cell;
}



-(NSMutableArray *)ListArr
{
    if (!_ListArr) {
        _ListArr = [NSMutableArray arrayWithObjects:@"Plist",@"NSUserdefault",@"NSKeyedArchiver",@"FMDB",@"Coredata", nil];
    }
    return _ListArr;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[PlistViewController alloc] init] animated:YES];
            break;
           case 1:
            [self.navigationController pushViewController:[[UserDefaultViewController alloc] init] animated:YES];
            break;
            case 2:
            [self.navigationController pushViewController:[[KeyedArchiverViewController alloc] init] animated:YES];
            break;
            case 3:
            [self.navigationController pushViewController:[[FMDBViewController alloc] init] animated:YES];
            break;
            case 4:
            [self.navigationController pushViewController:[[CoreDataViewController alloc] init] animated:YES];
        default:
            break;
    }
}







@end
