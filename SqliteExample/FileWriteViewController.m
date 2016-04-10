//
//  FileWriteViewController.m
//  SqliteExample
//
//  Created by Orange Chang on 2016/4/10.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import "FileWriteViewController.h"
@interface FileWriteViewController()
{
    UIImage *crayImage;
}
@end

@implementation FileWriteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImageFromBundle];
    [_writeMessageLabel setText:@""];
    [_readMessageLabel setText:@""];
}
-(void) loadImageFromBundle{
    NSString *crayImageFilePath=[[NSBundle mainBundle]
                                 pathForResource:@"cray.png"
                                 ofType:nil];
    crayImage=[UIImage imageWithContentsOfFile:crayImageFilePath];
    [_bundleImageView setImage:crayImage];
}
- (IBAction)writeButtonClicked:(id)sender {
    [_writeMessageLabel setText:@""];
    if([_writeFileName hasText]==NO){
        [_writeMessageLabel setText:@"Please fill the file name."];
        return;
    }
    
    NSString *fileName=[NSString stringWithFormat:@"%@.png",_writeFileName.text];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath= [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *imageData=UIImagePNGRepresentation(crayImage);
    if(imageData){
        [imageData writeToFile:filePath atomically:YES];
        [_writeMessageLabel setText:@"Image saved to file."];
    }
}
- (IBAction)readButtonClicked:(id)sender {
    [_readMessageLabel setText:@""];
    if([_readFileName hasText]==NO){
        [_readMessageLabel setText:@"Please fill the file name."];
        return;
    }

    NSString *fileName=[NSString stringWithFormat:@"%@.png",_readFileName.text];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath= [documentsDirectory stringByAppendingPathComponent:fileName];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    if(image==nil){
        NSString *msg=[NSString stringWithFormat:@"Image %@.png not found.",_readFileName.text];
        [_readMessageLabel setText:msg];
        return;
    }
    [_readImageView setImage:image];
    NSString *msg=[NSString stringWithFormat:@"Image %@.png loaded.",_readFileName.text];
    [_readMessageLabel setText:msg];

}

@end
