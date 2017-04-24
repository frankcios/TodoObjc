//
//  ViewController.h
//  TodoObjc
//
//  Created by Frank on 2017/4/24.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *myMutableArray;
    NSUserDefaults *myUserdefault;
    __weak IBOutlet UITableView *myTableView;
}


@end

