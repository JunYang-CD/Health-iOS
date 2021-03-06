//
//  Recipe.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "Recipe.h"
#import "Api.h"

@implementation RecipeRealmObject

-(instancetype)initWithData:(Recipe *)recipe{
    _ID = [(NSNumber*)recipe.ID stringValue];
    _name = recipe.name;
    _foods = recipe.foods;
    _imageUrl = recipe.imageUrl;
    _keywords = recipe.keywords;
    _steps = recipe.steps;
    return self;
}

-(Recipe *) recipeObj{
    Recipe *recipe = [[Recipe new] initWithRecipeReamObj:self];
    return recipe;
}
@end

@implementation RecipeFavRealmObject
+(NSString *)primaryKey{
    return @"ID";
}

@end

@implementation Recipe

@synthesize imageUrl = _imageUrl;

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return
    @{
      @"name":@"name",
      @"imageUrl":@"img",
      @"foods":@"food",
      @"steps":@"message",
      @"keywords":@"keywords",
      @"ID":@"id"
      };
}

-(NSString*) imageUrl{
    if(_imageUrl){
        if(! [_imageUrl containsString:RecipeImagePrefix]){
            NSMutableString *url = [NSMutableString stringWithString: RecipeImagePrefix];
            [url appendString: _imageUrl];
            return url;
        }
    }
    return _imageUrl;
}

-(instancetype)initWithRecipeReamObj:(RecipeRealmObject *)recipeRealmObj{
    _ID = recipeRealmObj.ID;
    _name = recipeRealmObj.name;
    _imageUrl = recipeRealmObj.imageUrl;
    _steps = recipeRealmObj.steps;
    _keywords = recipeRealmObj.keywords;
    _foods = recipeRealmObj.foods;
    return self;
}

-(instancetype)initWithRecipeFavReamObj:(RecipeFavRealmObject *)recipeRealmObj{
    _ID = recipeRealmObj.ID;
    _name = recipeRealmObj.name;
    _imageUrl = recipeRealmObj.imageUrl;
    _steps = recipeRealmObj.steps;
    _keywords = recipeRealmObj.keywords;
    _foods = recipeRealmObj.foods;
    return self;
}



@end

@implementation RecipeResponseModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return
    @{
      @"recipes":@"tngou"
      //      @"recipe":@""
      };
}
+ (NSValueTransformer *)recipesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:Recipe.class];
}

@end
