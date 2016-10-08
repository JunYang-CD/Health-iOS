//
//  RecipeCellController.h
//  Persistence
//
//  Created by Jerry Yang on 9/29/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCellViewModel.h"

@interface RecipeCellView: UITableViewCell

- (void) setRecipe:(NSString*)name imageUrl:(NSString*)imageUrl;
- (void) setData: (RecipeCellViewModel*) model;

@end
