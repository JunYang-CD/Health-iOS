//
//  RecipeCellViewModel.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeCellViewModel : NSObject

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* foods;
@property (nonatomic, readonly) NSString* imageUrl;

+(instancetype) recipeCellViewModelWithNameImage: (NSString*) name imageUrl: (NSString*) imageUrl;

-(instancetype) initWithFoods: (NSString*) foods;

@end
