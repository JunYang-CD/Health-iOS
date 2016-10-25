//
//  RecipeTableView.m
//  Persistence
//
//  Created by Jerry Yang on 10/21/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeTableViewDelegateImpl.h"
#import "RecipeCellView.h"

@implementation RecipeTableViewDelegateImpl

-(instancetype)initWithData:(NSArray<Recipe *> *)recipes pageIndex:(NSInteger)pageIndex{
    self.autoLoadMore = false;
    self.recipes = [recipes copy];
    self.pageIndex = pageIndex;
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"fav count %lu", (unsigned long)[self.recipes count]);
    return [self.recipes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"fav count %lu", (unsigned long)[self.recipes count]);
    
    RecipeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"RecipeItem" bundle:nil] forCellReuseIdentifier:@"recipeCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    }
    
    Recipe* recipe = [self.recipes objectAtIndex:indexPath.row];
    RecipeCellViewModel *recipeCellViewModel = [[RecipeCellViewModel recipeCellViewModelWithNameImage:[NSString stringWithFormat:@"%@", recipe.name] imageUrl:recipe.imageUrl] initWithFoods:recipe.foods];
    [cell setData:recipeCellViewModel];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_recipes && [_recipes count] > indexPath.row){
        Recipe *selectedRecipe = [self.recipes objectAtIndex:indexPath.row];
        if(self.controllerDelegate){
            [self.controllerDelegate showRecipeDetail: selectedRecipe];
        }
        //        [self performSegueWithIdentifier:@"showRecipeDetail" sender:self];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //todo: measure how many rows can be displayed on the screen at one time.
    if(indexPath.row >= 7 && indexPath.row == [self.recipes count] -1 && self.autoLoadMore){
        _pageIndex ++;
        if(self.controllerDelegate){
            [self.controllerDelegate loadMoreRecipe:self.pageIndex + 1];
        }
        //        [self.controllerDelegate requestRecipes];
    }
    
}
@end
