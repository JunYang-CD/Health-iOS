//
//  RecipeCategory.m
//  Persistence
//
//  Created by Jerry Yang on 10/9/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCategory.h"

@implementation RecipeCategory

- (instancetype)init
{
    self = [super init];
    if (self) {
        _checked = false;
    }
    return self;
}

- (instancetype) initWithData:(NSString *)ID cookClass:(NSString *)cookClass name:(NSString *)name{
    _checked = false;
    _ID = ID;
    _name = name;
    _cookclass = cookClass;
    return self;
}

+(NSDictionary *) JSONKeyPathsByPropertyKey{
    return
    @{
      @"ID":@"id",
      @"cookclass":@"cookclass",
      @"name":@"name"
      };
}

+(NSDictionary *)managedObjectKeysByPropertyKey{
    return
    @{
      @"id":@"ID",
      @"cookclass":@"cookclass",
      @"name":@"name",
      @"checked":@"checked"
      };
}


@end

@implementation RecipeCategoryRealmObject

-(instancetype)initWithMantleModel:(RecipeCategory *)recipeCategory{
    self = [super init];
    if(!self) return nil;
    
    _ID = [(NSNumber*)recipeCategory.ID stringValue];
    _cookclass = [(NSNumber*)recipeCategory.cookclass stringValue];
    _name = recipeCategory.name;
    return self;
}

+(NSString *)primaryKey{
    return @"ID";
}

+(NSDictionary *)defaultPropertyValues{
    return @{@"name":@"无名菜"};
}

-(RecipeCategory *)recipeCategory{
    RecipeCategory *recipeCategory = [[RecipeCategory new]initWithData:self.ID cookClass:self.cookclass name:self.name];
    return recipeCategory;
    
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
