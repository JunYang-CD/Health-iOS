//
//  RecipeCellViewModel.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCellViewModel.h"

@implementation RecipeCellViewModel

+(instancetype) recipeCellViewModelWithNameImage:(NSString*) name imageUrl:(NSString*) imageUrl{
    RecipeCellViewModel* instance = [RecipeCellViewModel new];
    instance->_name = name;
    instance->_imageUrl = imageUrl;

    return instance;
    
}

-(instancetype)initWithFoods:(NSString *)foods{
    _foods = foods;
    return self;
}
@end
