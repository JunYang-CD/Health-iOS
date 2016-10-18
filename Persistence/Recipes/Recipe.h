//
//  Recipe.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import <Realm/RLMObject.h>


@interface Recipe : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* imageUrl;
@property (nonatomic, readonly) NSString* foods;
@property (nonatomic, readonly) NSString* steps;
@property (nonatomic, readonly) NSString* keywords;
@property (nonatomic, readonly) NSString* ID;

@end

@interface RecipeRealmObject : RLMObject
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* imageUrl;
@property (nonatomic, readonly) NSString* foods;
@property (nonatomic, readonly) NSString* steps;
@property (nonatomic, readonly) NSString* keywords;
@property (nonatomic, readonly) NSString* ID;
@property (nonatomic) NSInteger onPageIndex;

-(instancetype) initWithData:(Recipe *) recipe pageIndex: (NSInteger) pageIndex;
@end


@interface RecipeResponseModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, readonly) NSArray<Recipe *> *recipes;
//@property (nonatomic, readonly) Recipe *recipe;

@end
