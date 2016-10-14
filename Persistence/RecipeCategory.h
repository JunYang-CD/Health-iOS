//
//  RecipeCategory.h
//  Persistence
//
//  Created by Jerry Yang on 10/9/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import <Realm/RLMObject.h>

@interface RecipeCategory : MTLModel<MTLJSONSerializing>
@property (nonatomic,readonly) NSString* ID;
@property (nonatomic,readonly) NSString* cookclass; //0 is top level
@property (nonatomic,readonly) NSString* name;
@property (nonatomic) BOOL* checked;
-(instancetype)init;
-(instancetype)initWithData:(NSString *)ID cookClass:(NSString *)cookClass name:(NSString *)name;

@end

@interface RecipeCategoryRealmObject : RLMObject
@property (nonatomic) NSString* ID;
@property (nonatomic) NSString* cookclass; //0 is top level
@property (nonatomic) NSString* name;

-(instancetype)initWithMantleModel: (RecipeCategory *)recipeCategory;
-(RecipeCategory *) recipeCategory;

@end


@interface RecipeCategoryResponseModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly) NSArray<RecipeCategory *> *recipeCategories;

@end

