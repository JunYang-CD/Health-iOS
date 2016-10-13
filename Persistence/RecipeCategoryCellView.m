//
//  RecipeCategoryCellViewTableViewCell.m
//  Persistence
//
//  Created by Jerry Yang on 10/13/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCategoryCellView.h"

@interface RecipeCategoryCellView()
@property (weak, nonatomic) IBOutlet UILabel *recipeCategoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (nonatomic, readonly) RecipeCategory* category;

@end

@implementation RecipeCategoryCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if(selected){
        _category.checked = !_category.checked;
    }
    _checkImage.hidden = !_category.checked;
}

- (void)setData:(RecipeCategory *)category {
    _category = category;
    _recipeCategoryLabel.text = category.name;
}

@end
