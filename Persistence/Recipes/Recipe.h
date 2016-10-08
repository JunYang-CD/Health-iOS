//
//  Recipe.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* imageUrl;
@property (nonatomic, readonly) NSString* description;
@property (nonatomic, readonly) NSString* steps;
@property (nonatomic, readonly) NSString* keywords;


@end
