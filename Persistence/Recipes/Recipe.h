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

@class RecipeRealmObject;
@class RecipeFavRealmObject;

@interface Recipe : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* imageUrl;
@property (nonatomic, readonly) NSString* foods;
@property (nonatomic, readonly) NSString* steps;
@property (nonatomic, readonly) NSString* keywords;
@property (nonatomic, readonly) NSString* ID;

-(instancetype)initWithRecipeReamObj:(RecipeRealmObject *)recipeRealmObj;
-(instancetype)initWithRecipeFavReamObj:(RecipeFavRealmObject *)recipeRealmObj;

@end

@interface RecipeRealmObject : RLMObject
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* imageUrl;
@property (nonatomic) NSString* foods;
@property (nonatomic) NSString* steps;
@property (nonatomic) NSString* keywords;
@property (nonatomic) NSString* ID;

-(instancetype) initWithData:(Recipe *) recipe;
-(Recipe *)recipeObj;
@end

@interface RecipeFavRealmObject : RecipeRealmObject

@end


@interface RecipeResponseModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, readonly) NSArray<Recipe *> *recipes;
//@property (nonatomic, readonly) Recipe *recipe;

@end
