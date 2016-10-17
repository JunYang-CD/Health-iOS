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
#import "RecipeCategoryTableViewController.h"


@interface RecipesViewController ()
@property (nonatomic, readonly)  NSMutableArray<Recipe *> *recipes;;
@property (weak, nonatomic) IBOutlet UITableView *recipeTable;
@property (weak, nonatomic) IBOutlet UIStackView *selectedCategoryStack;
@property (weak, nonatomic) NSLayoutConstraint *selectedCategoryWidthConstraint;
@property (nonatomic) NSMutableArray<RecipeCategory *> *selectedCategoyItems;
@property (nonatomic) BOOL editSelectedCategories;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recipeTableViewTopConstraint;


@end

@implementation RecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editSelectedCategories = false;
    _recipes = [NSMutableArray new];
    // Do any additional setup after loading the view.
    [self setup];
    //    [[RecipeModel instance] getByID:@"1"];
    //    [[RecipeModel instance] getByName:@"水煮肉片"];
    //    [[RecipeModel instance] getCategories:@"10"];
    //    [[RecipeModel instance] getListByCategory:@"1"];
    
    [self initViewModel];
    
    _recipeTableViewTopConstraint.constant = -30;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup{
    _recipeTable.dataSource = self;
    _recipeTable.delegate = self;
    [self registerObserver];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector( cancleEditSelectedCategory:) ];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)initViewModel{
    [_recipes removeAllObjects];
    if([_selectedCategoyItems count] == 0){
        [[RecipeModel instance] getListByCategory:@"10" pageIndex:2];
    }else{
        for(RecipeCategory* recipeCategory in _selectedCategoyItems){
            [[RecipeModel instance] getListByCategory: recipeCategory.ID pageIndex:2] ;
        }
    }
}



- (void)registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipes:) name:RecipeModelRecipeListUpdate object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipes) name:RecipeModelRecipeUpdate object:nil];
}

- (void)refreshRecipes: (NSNotification *) notification{
    [_recipes addObjectsFromArray: notification.userInfo[@"recipeObj"]];
    if(_recipes){
        [_recipeTable reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.recipes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)setSelectedCategories:(NSArray<RecipeCategory *> *)selectedCategories{
    [_selectedCategoyItems addObjectsFromArray:selectedCategories];
    [self updateRecipeCategoryTopMargin:selectedCategories];
    [self updateSelectedCategoryStackView];
    [self initViewModel];
    
}

- (void) updateRecipeCategoryTopMargin:(NSArray<RecipeCategory *> *)selectedCategories{
    if ([selectedCategories count] > 0){
        if(self.editSelectedCategories){
            _recipeTableViewTopConstraint.constant = 30;
        }else{
            _recipeTableViewTopConstraint.constant = 10;
        }
    }else{
        _recipeTableViewTopConstraint.constant = -30;
    }
    _selectedCategoyItems = [NSMutableArray arrayWithArray:selectedCategories];
    
}

- (void) updateSelectedCategoryStackView{
    for (UIView *view in [self.selectedCategoryStack subviews]){
        [self.selectedCategoryStack removeArrangedSubview:view];
        [view removeFromSuperview];
        
    }
    NSInteger width = 0;
    for (RecipeCategory* recipeCategory in self.selectedCategoyItems){
        
        NSArray<UIView *> *views = [[NSBundle mainBundle] loadNibNamed:@"RecipeCategoryFilterView" owner:self options:nil];
        UIView *view = [views objectAtIndex:0];
        ((UILabel*)[view viewWithTag:1]).text = recipeCategory.name;
        UILongPressGestureRecognizer *gesRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [view addGestureRecognizer:gesRecognizer];
        [view viewWithTag:2].hidden = !self.editSelectedCategories;
        UITapGestureRecognizer *removeCategoryGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCategoryGesture:)];
        [view setUserInteractionEnabled:true];
        [view addGestureRecognizer:removeCategoryGesture];
        
        [self.selectedCategoryStack addArrangedSubview:view];
        width += 40;
    }
    
    self.selectedCategoryWidthConstraint != nil ? [self.selectedCategoryStack removeConstraint: self.selectedCategoryWidthConstraint] : nil;
    self.selectedCategoryWidthConstraint = [self.selectedCategoryStack.widthAnchor constraintEqualToConstant:width];
    self.selectedCategoryWidthConstraint.active = true;
    
}

-(void) handleLongPress:(UILongPressGestureRecognizer*) gusterReconginze{
    if (gusterReconginze.state == UIGestureRecognizerStateBegan) {
        NSLog(@"filter long pressed ");
        if(self.selectedCategoyItems != nil){
            self.editSelectedCategories = true;
        }
        [self updateSelectedCategoryStackView];
    }
    
}
-(void)removeCategoryGesture:(UITapGestureRecognizer*) tapGesture{
    
    if(self.editSelectedCategories){
        NSInteger index = -1;
        NSInteger removeIndex = index;
        for(UIView *view in self.selectedCategoryStack.subviews){
            index ++;
            if(view  == tapGesture.view){
                removeIndex = index;
            }
        }
        if(removeIndex >= 0){
            [self.selectedCategoyItems removeObjectAtIndex: removeIndex];
            [self setSelectedCategories: self.selectedCategoyItems];
        }
    }
}

-(void)cancleEditSelectedCategory:(UITapGestureRecognizer*) tapGesture{
    self.editSelectedCategories = false;
    [self setSelectedCategories:self.selectedCategoyItems];
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.editSelectedCategories = false;
    [(RecipeCategoryTableViewController *)[segue destinationViewController] setDelegate:self];
    [(RecipeCategoryTableViewController *)[segue destinationViewController] setCheckedCategories: self.selectedCategoyItems];
}


@end
