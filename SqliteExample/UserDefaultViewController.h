//
//  UserDefaultViewController.h
//  SqliteExample
//
//  Created by Orange Chang on 2016/4/8.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDefaultViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *writeMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *readMessageLabel;
@property (strong, nonatomic) IBOutlet UITextField *writeNameField;
@property (strong, nonatomic) IBOutlet UITextField *writeValueField;
@property (strong, nonatomic) IBOutlet UITextField *readNameField;
@property (strong, nonatomic) IBOutlet UILabel *readValueLabel;

@end
