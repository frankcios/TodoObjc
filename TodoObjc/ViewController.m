//
//  ViewController.m
//  TodoObjc
//
//  Created by Frank on 2017/4/24.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "ViewController.h"
#import "TaiwanArea.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myMutableArray = [[NSMutableArray alloc]init];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myUserdefault = [NSUserDefaults standardUserDefaults];
    
    // 註冊cell
    [myTableView registerClass:UITableViewCellStyleDefault forCellReuseIdentifier:@"Cell"];
    
    // 載入待辦事項
    [self loadList];
}

- (void)saveList {
    [myUserdefault setObject: myMutableArray forKey:@"TodoList"];
    [myUserdefault synchronize];
}

- (void)loadList {
    // 此時必須將陣列重新 init 為 mutableArray，因為儲存在 UserDefaults 裡的是不可變的
    myMutableArray = [[NSMutableArray alloc]initWithArray:[myUserdefault objectForKey:@"TodoList"]];
}

- (IBAction)addSomethingTodo:(UIBarButtonItem *)sender {
    
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"新增" message:@"請輸入待辦事項" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 類型是Array，取得第一個元素
        UITextField *item = myAlert.textFields.firstObject;
        [myMutableArray addObject:item.text];
        [self saveList];
        [myTableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [myAlert addAction:cancelAction];
    [myAlert addAction:okAction];
    [myAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"待辦事項";
    }];
    [self presentViewController:myAlert animated:YES completion:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSLog(@"調用numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"調用numberOfRows");
    return [myMutableArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"調用cellForRowAtIndexPath");
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.textLabel.text = [myUserdefault arrayForKey:@"TodoList"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self loadList];
        [myMutableArray removeObjectAtIndex:indexPath.row];
        [self saveList];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%lu", [myTableView indexPathForSelectedRow].row);
    [myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"修改" message:@"請輸入修改內容" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 類型是Array，取得第一個元素
        UITextField *item = myAlert.textFields.firstObject;
        myMutableArray[indexPath.row] = item.text;
        [self saveList];
        // 刷新一行數據
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [myTableView reloadRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationFade];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [myAlert addAction:cancelAction];
    [myAlert addAction:okAction];
    // 添加文本輸入框
    [myAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"待辦事項";
        textField.text = myMutableArray[indexPath.row];
    }];
    [self presentViewController:myAlert animated:YES completion:nil];
}


@end
