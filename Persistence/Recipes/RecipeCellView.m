//
//  RecipeCellController.m
//  Persistence
//
//  Created by Jerry Yang on 9/29/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCellView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface RecipeCellView()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *foods;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation RecipeCellView

-(void) setData:(RecipeCellViewModel *)model{
    self.foods.text = model.foods;
    self.name.text = model.name;
    
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]
                 placeholderImage:[UIImage imageNamed:@"main-dishes"]];

}


@end
