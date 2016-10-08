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
    [instance initWithNameImage:name imageUrl:imageUrl];
    return instance;
    
}

-(void)initWithNameImage:(NSString*) name imageUrl:(NSString*) imageUrl{
    _name = name;
    _imageUrl = imageUrl;
}
@end
