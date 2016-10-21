//
//  RecipeCategoryCellHeaderView.h
//  Persistence
//
//  Created by Jerry Yang on 10/13/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCategorySectionHeaderView : UIView

-(void) setSectionData: (NSString *) headerName sectionIndex: (NSInteger) sectionIndex collapse: (BOOL) collapse;

@end
