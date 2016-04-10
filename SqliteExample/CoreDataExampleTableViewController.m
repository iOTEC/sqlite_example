//
//  CoreDataExampleTableViewController.m
//  SqliteExample
//
//  Created by Orange Chang on 2016/4/10.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import "CoreDataExampleTableViewController.h"
#import "Member.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@interface CoreDataExampleTableViewController ()


@end

@implementation CoreDataExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) insertMember:(NSString *) name WithCompany:(NSString *) company
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];

    Member *member=[NSEntityDescription
                    insertNewObjectForEntityForName:@"Member"
                    inManagedObjectContext:managedObjectContext];
    member.name=name;
    member.company=company;
    member.create_time=[NSDate date];
    [self saveContext];
}
- (void)saveContext
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
    NSError *error = nil;
    
    if (![managedObjectContext save:&error]) {
        NSLog(@"[ERROR] Saving managed context error: %@",error);
    }else{
        NSLog(@"Managed context saved.");
    }
}

-(NSArray *) listMember
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext: managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [ managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Fetch error, something's wrong. %@",error);
    }
    return fetchedObjects;
}
-(NSArray *) getMemberNamed:(NSString *) name
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext: managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [ managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Fetch error, something's wrong. %@",error);
    }
    return fetchedObjects;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: // INSERT
        {
            [self insertMember:@"Orange" WithCompany:@"iotec.tw"];
            break;
        }
        case 1: // SELECT
        {
            NSArray *memberList=[self listMember];
            if(memberList){
                for (Member *member in memberList) {
                    NSLog(@"-- member ");
                    NSLog(@"  name : %@",member.name);
                    NSLog(@"  company : %@",member.company);
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateStyle:NSDateFormatterShortStyle];
                    [formatter setTimeStyle:NSDateFormatterMediumStyle];
                    NSString *currentDateString = [formatter stringFromDate:member.create_time];
                    NSLog(@"  create_time=%@", currentDateString);
                }
                if(memberList.count ==0)
                    NSLog(@"Member list empty.");
            }else{
                NSLog(@"Member list empty.");
            }
            break;
        }
        case 2: // UPDATE
        {
            NSArray *orangeMemberList=[self getMemberNamed:@"Orange"];
            if(orangeMemberList){
                for (Member *member in orangeMemberList) {
                    member.name=@"Apple";
                }
            }
            [self saveContext];
            NSLog(@"name updated to 'Apple'");
            break;
        }
        case 3: // UPDATE
        {
            NSArray *memberList=[self listMember];
            if(memberList){
                for(Member *member in memberList){
                    member.name=@"Orange";
                }
            }
            [self saveContext];
            NSLog(@"name updated to 'Orange'");
            break;
        }
        case 4: // DELETE
        {
            AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
            NSArray *memberList=[self getMemberNamed:@"Apple"];
            if(memberList){
                for(Member *member in memberList){
                    [managedObjectContext deleteObject:member];
                }
            }
            [self saveContext];
            NSLog(@"All record named 'Apple' deleted.");
            break;
        }
        default:
            break;
    }
}


@end
