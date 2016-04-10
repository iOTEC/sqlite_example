//
//  Member+CoreDataProperties.h
//  SqliteExample
//
//  Created by Orange Chang on 2016/4/10.
//  Copyright © 2016年 iOTEC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Member.h"

NS_ASSUME_NONNULL_BEGIN

@interface Member (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSDate *create_time;

@end

NS_ASSUME_NONNULL_END
