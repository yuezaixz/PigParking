//
//  PPHistoryViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPHistoryViewController.h"
#import "PPHistoryTableViewCell.h"
#import "PPHistoryModel.h"
#import "PPHistoryDB.h"

@interface PPHistoryViewController ()

@property (nonatomic, strong) IBOutlet UITableView *historyTableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) PPHistoryDB *db;

@end

@implementation PPHistoryViewController

- (void)dealloc
{
    self.historyTableView = nil;
    self.data = nil;
    self.db = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"历史记录";
        self.data = [NSMutableArray array];
        self.db = [[PPHistoryDB alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                                         target:self
                                                                                         action:@selector(btnBackClick:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemClear
                                                                                          target:self
                                                                                          action:@selector(btnClearClick:)];
    
    [self.data addObjectsFromArray:[_db fetchAll]];
    
    if (_data.count)
    {
        [self.view addSubview:_historyTableView];
        _historyTableView.dataSource = self;
        _historyTableView.delegate = self;
    }
    
    self.navigationItem.rightBarButtonItem.enabled = _data.count != 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PPHistoryTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"h-cell"];
    
    if (!cell)
    {
        cell = [[PPHistoryTableViewCell alloc] initWithReuseIdentifier:@"h-cell"];
    }
    
    cell.chargeLabel.text = [NSString stringWithFormat:@"费用:%@", _data[indexPath.row][@"charge"]];
    cell.parkingCountLabel.text = [NSString stringWithFormat:@"车位:%@个", _data[indexPath.row][@"parkingCount"]];
    cell.addressLabel.text = [NSString stringWithFormat:@"地址:%@", _data[indexPath.row][@"address"]];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSDictionary *d = _data[indexPath.row];
        [_db remove:d[@"id"]];
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -

- (IBAction)btnGotoUseClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnClearClick:(id)sender
{
    [_db removeAll];
    [_data removeAllObjects];
    [_historyTableView reloadData];
    [_historyTableView removeFromSuperview];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark -

- (void)loadList
{
    
}

@end
