//
//  Recipe.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "Recipe.h"
#import "Api.h"

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
    NSMutableString *url = [NSMutableString stringWithString: RecipeImagePrefix];
    [url appendString: _imageUrl];
    return url;
}

@end

@implementation RecipeResponseModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return
    @{
      @"recipes":@"tngou"
      };
}
+ (NSValueTransformer *)recipesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:Recipe.class];
}

@end
