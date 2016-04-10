//
//  SqlExampleTableViewController.m
//  SqliteExample
//
//  Created by Orange Chang on 2016/3/30.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#define DB_NAME @"member.db"
#import "SqlDatabase.h"
#import "SqlExampleTableViewController.h"

@implementation SqlExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabaseMethod1];
}
-(void) initDatabaseMethod1
{
    SqlDatabase *sqlDb=  [[SqlDatabase alloc]init];
    
    if([sqlDb copyDatabase:DB_NAME]==NO){
        NSLog(@"Database create failed.");
    }
    
}
-(void) initDatabaseMethod2{
    SqlDatabase *sqlDb=  [[SqlDatabase alloc]init];
    
    if([sqlDb createDatabase:DB_NAME]==NO){
        NSLog(@"Database create failed.");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sqlite3 *db;
    NSString *databasePath=[SqlDatabase getDatabasePath:DB_NAME];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK)
    {
        NSLog(@"[ERROR] Database open failed.");
        return;
    }
    
    switch (indexPath.row) {
        case 0: // INSERT
        {
            char *errorMsg;
            const char *insertSql="insert into member(name,company) values('Orange','iOTEC Systems')";
            if (sqlite3_exec(db, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
                NSLog(@"INSERT OK");
            }else{
                NSLog(@"Insert error: %s",errorMsg);
            }
            break;
        }
        case 1: // SELECT
        {
            NSLog(@"*** SELECT ***");
            const char *sql = "select * from member";
            sqlite3_stmt *statement =nil;
            if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSString *_id,*name, *company;
                    
                    _id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                    company = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                    
                    NSLog(@"Record: %@> %@ , %@",_id, name, company);
                }
                
                sqlite3_finalize(statement);
            }
            break;
        }
        case 2: // UPDATE
        {
            char *errorMsg;
            const char *sql = "UPDATE member SET name='Apple' WHERE name='Orange'";
            
            if (sqlite3_exec(db, sql, NULL, NULL, &errorMsg)==SQLITE_OK) {
                NSLog(@"UPDATE OK");
            }else{
                NSLog(@"UPDATE error: %s",errorMsg);
            }
            break;
        }
        case 3: // UPDATE
        {
            char *errorMsg;
            const char *sql = "UPDATE member SET name='Orange' ";
            
            if (sqlite3_exec(db, sql, NULL, NULL, &errorMsg)==SQLITE_OK) {
                NSLog(@"UPDATE OK");
            }else{
                NSLog(@"UPDATE error: %s",errorMsg);
            }
            break;
        }
        case 4: // DELETE
        {
            char *errorMsg;
            const char *sql = "DELETE FROM member WHERE name='Apple'";
            
            if (sqlite3_exec(db, sql, NULL, NULL, &errorMsg)==SQLITE_OK) {
                NSLog(@"DELETE OK");
            }else{
                NSLog(@"DELETE error: %s",errorMsg);
            }
            break;
        }
        default:
            break;
    }
}

@end
