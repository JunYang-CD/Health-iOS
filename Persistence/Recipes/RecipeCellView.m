//
//  RecipeCellController.m
//  Persistence
//
//  Created by Jerry Yang on 9/29/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCellView.h"

@interface RecipeCellView()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation RecipeCellView

-(void) setRecipe:(NSString*)name imageUrl:(NSString*)imageUrl{
    self.name.text = name;
    self.image.image = [UIImage imageNamed:@"first"];
}

-(void) setData:(RecipeCellViewModel *)model{
    self.name.text = model.name;
    self.image.image = [UIImage imageNamed:@"first"];
}

@end
