//
//  RecipeCategoryCellHeaderView.m
//  Persistence
//
//  Created by Jerry Yang on 10/13/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCategorySectionHeaderView.h"

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@interface RecipeCategorySectionHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *sectionHeaderName;
@property (weak, nonatomic) IBOutlet UIButton *collapseExpandBtn;

@property (nonatomic, readonly) NSInteger sectionIndex;

@end

@implementation RecipeCategorySectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSectionData:(NSString *)headerName sectionIndex: (NSInteger) sectionIndex collapse:(BOOL)collapse{
    _sectionHeaderName.text = headerName;
    _sectionIndex = sectionIndex;
    if(!collapse){
        _collapseExpandBtn.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180.0));
    }
}
- (IBAction)toggleSectionHeader:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collapseExpandSection" object:self userInfo:@{@"sectionIndex":[NSNumber numberWithInteger:self.sectionIndex]}];    
}

@end
