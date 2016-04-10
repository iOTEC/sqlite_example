//
//  UserDefaultViewController.m
//  SqliteExample
//
//  Created by Orange Chang on 2016/4/8.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import "UserDefaultViewController.h"

@implementation UserDefaultViewController
- (IBAction)performWrite:(id)sender {
    if([_writeNameField hasText]==NO){
        [_writeMessageLabel setText:@"Please input write attribute name"];
        return;
    }
    if([_writeValueField hasText]==NO){
        [_writeMessageLabel setText:@"Please input write attribute value"];
        return;
    }
    NSString *keyString=_writeNameField.text;
    NSString *valueString=_writeValueField.text;
    [[NSUserDefaults standardUserDefaults] setObject:valueString forKey:keyString];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_writeMessageLabel setText:@"Attribute value saved."];
}
- (IBAction)performRead:(id)sender {
    if([_readNameField hasText]==NO){
        [_readMessageLabel setText:@"Please input write attribute name"];
        [_readValueLabel setText:@"" ];
        return;
    }
    NSString *keyString=_readNameField.text;
    NSString *value=[[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    if(value!=nil){
        [_readValueLabel setText:[NSString stringWithFormat:@"Attribute Value: %@",value] ];
    }else{
        [_readMessageLabel setText:@"Attribute Value not found"];
        [_readValueLabel setText:@"" ];
    }
    [_readMessageLabel setText:@""];
}

@end
