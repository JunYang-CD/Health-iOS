//
//  RecipeCategoryCellViewTableViewCell.h
//  Persistence
//
//  Created by Jerry Yang on 10/13/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCategory.h"

@interface RecipeCategoryCellView : UITableViewCell

-(void)setData:(RecipeCategory *)category;

@end
