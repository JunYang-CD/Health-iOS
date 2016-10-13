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

@end

@implementation RecipeCategoryCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setData:(NSString *)categoryName{
    _recipeCategoryLabel.text = categoryName;
}

@end
