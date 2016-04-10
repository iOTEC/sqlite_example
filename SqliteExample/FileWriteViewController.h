//
//  FileWriteViewController.h
//  SqliteExample
//
//  Created by Orange Chang on 2016/4/10.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileWriteViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *bundleImageView;
@property (strong, nonatomic) IBOutlet UITextField *writeFileName;
@property (strong, nonatomic) IBOutlet UITextField *readFileName;
@property (strong, nonatomic) IBOutlet UILabel *writeMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *readMessageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *readImageView;

@end
