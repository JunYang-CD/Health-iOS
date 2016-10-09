//
//  RecipeCategory.m
//  Persistence
//
//  Created by Jerry Yang on 10/9/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCategory.h"

@implementation RecipeCategory

+(NSDictionary *) JSONKeyPathsByPropertyKey{
    return
    @{
      @"ID":@"id",
      @"cookclass":@"cookclass",
      @"name":@"name"
      };
}

@end

@implementation RecipeCategoryResponseModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return
    @{
      @"recipeCategories":@"tngou"
      };
}

+ (NSValueTransformer *)recipeCategoriesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:RecipeCategory.class];
}

@end
