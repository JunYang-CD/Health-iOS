//
//  RecipeCategoryTableViewController.m
//  Persistence
//
//  Created by Jerry Yang on 10/11/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCategoryTableViewController.h"
#import "RecipeModel.h"
#import "RecipeCategoryCellView.h"
#import "RecipeCategorySectionHeaderView.h"

@interface RecipeCategoryTableViewController ()
@property (nonatomic, readonly) NSArray<RecipeCategory *> *rootCategories;
@property (nonatomic, readonly) NSMutableArray<Category *> *categories;

@end

@implementation RecipeCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self regsiterObserver];
    [self initCategoryViewModel];
    
}

- (void) regsiterObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRootCategory:) name: RecipeModelRecipeCategoryUpdate object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSubCategory:) name: RecipeModelRecipeSubCategoryUpdate object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSectionHeader:) name:@"collapseExpandSection" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCategoryViewModel{
        [[RecipeModel instance] getCategories:nil];
}

- (void)getRootCategory: (NSNotification*) notification{
    
    _rootCategories = notification.userInfo[@"categoryObj"];
    _categories = [NSMutableArray new];
    [self initAllSubCategory];
    
}

- (void)initAllSubCategory{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSubCategory:) name:RecipeModelRecipeCategoryUpdate  object:nil];
    for (RecipeCategory *recipeCategory in _rootCategories) {
        [[RecipeModel instance] getCategories: [(NSNumber*)recipeCategory.ID stringValue]];
    }
}

- (void)getSubCategory: (NSNotification*) notification{
    NSString *rootCategoryID = notification.userInfo[@"categoryID"];
    NSArray<RecipeCategory *> *subCategories = notification.userInfo[@"categoryObj"];
    for (RecipeCategory *recipeCategory in _rootCategories) {
        if([[(NSNumber*)recipeCategory.ID stringValue] isEqualToString: rootCategoryID] ){
            Category *category = [[Category new] initWithRecipeCategory: recipeCategory subCategories: subCategories];
            [_categories addObject: category];
            if([_categories count] == [_rootCategories count]){
                [[_categories objectAtIndex:0] updateCollapseStatus];
                [self setViewModel: _categories];
            }
            break;
        }
    }
    
}

- (void) setViewModel: (NSArray<Category *> *) categories{
    _categoryViewModel = [[RecipeCategoryViewModel new] initWithCategories:categories];
    [self.tableView reloadData];
}

- (void)reloadSectionHeader: (NSNotification *) notification{
    NSNumber *sectionIndex = notification.userInfo[@"sectionIndex"];
    [[self.categoryViewModel.categories objectAtIndex:[sectionIndex integerValue]] updateCollapseStatus];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[sectionIndex integerValue]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = self.categoryViewModel.sectionCount;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowsInSection = [[self.categoryViewModel getSubCategories:section] count];
    return[[self.categoryViewModel.categories objectAtIndex:section] shouldSectionCollapsed] ? 0 : rowsInSection;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RecipeCategorySectionHeaderView *sectionHeader = [[[NSBundle mainBundle] loadNibNamed:@"RecipeCategorySectionHeader" owner:self options:nil] objectAtIndex:0];
    BOOL collapse = [[self.categoryViewModel.categories objectAtIndex:section] shouldSectionCollapsed];
    [sectionHeader setSectionData:[self.categoryViewModel.categories objectAtIndex:section].rootCategory.name sectionIndex: section collapse:collapse];
    return sectionHeader;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCategoryCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCategoryCell"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"RecipeCategoryItem" bundle:nil] forCellReuseIdentifier:@"recipeCategoryCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCategoryCell"];
    }
    
    [cell setData: [[self.categoryViewModel.categories objectAtIndex:indexPath.section].subCategories objectAtIndex:indexPath.row].name];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
