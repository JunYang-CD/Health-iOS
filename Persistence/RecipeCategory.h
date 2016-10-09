//
//  RecipeCategory.h
//  Persistence
//
//  Created by Jerry Yang on 10/9/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeCategory : NSObject
@property (nonatomic,readonly) NSString* ID;
@property (nonatomic,readonly) NSString* cookclass; //0 is top level
@property (nonatomic,readonly) NSString* name;
@end
