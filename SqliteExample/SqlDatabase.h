//
//  SqlDatabase.h
//  SqliteExample
//
//  Created by Orange Chang on 2016/3/28.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface SqlDatabase : NSObject
-(BOOL) createDatabase:(NSString *)databaseName;
-(BOOL) copyDatabase:(NSString *)databaseName;
+(NSString *) getDatabasePath:(NSString *) databaseName;

@end
