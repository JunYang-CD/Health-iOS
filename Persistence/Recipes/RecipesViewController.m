//
//  RecipesViewController.m
//  Persistence
//
//  Created by Jerry Yang on 9/28/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipesViewController.h"
#import "RecipeCellView.h"
#import "RecipeCellViewModel.h"
#import "RecipeModel.h"


@interface RecipesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *recipeTable;

@end

@implementation RecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
//    [[RecipeModel instance] getByID:@"1"];
//    [[RecipeModel instance] getByName:@"豆腐"];
//    [[RecipeModel instance] getCategories];
    [[RecipeModel instance] getListByCategory:@"1"];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup{
    _recipeTable.dataSource = self;
    _recipeTable.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"RecipeItem" bundle:nil] forCellReuseIdentifier:@"recipeCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    }
    
    
    RecipeCellViewModel *recipeCellViewModel = [RecipeCellViewModel recipeCellViewModelWithNameImage:[NSString stringWithFormat:@"%d", (int)indexPath.row] imageUrl:nil];
    [cell setData:recipeCellViewModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
