//
//  MainFacesUI.m
//  Facts
//
//  Created by zhoujinhao on 9/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "MainFacesUI.h"

@interface MainFacesUI () <UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *m_tableView;
    UILabel     *m_lableTitle;
    UIBarButtonItem *m_barButtonRefresh;
    UIActivityIndicatorView *m_indicatorView;
    UIToolbar *m_toolBar;
    
}

@property (nonatomic, strong) UITableView   *m_tableView;
@property (nonatomic, strong) UILabel       *m_lableTitle;
@property (nonatomic, strong) UIBarButtonItem   *m_barButtonRefresh;
@property (nonatomic, strong)  UIActivityIndicatorView  *m_indicatorView;
@property (nonatomic, strong)  UIToolbar                *m_toolBar;

- (void)initUI;

- (void)startUpdate;
- (void)stopUpdate;

@end

@implementation MainFacesUI
@synthesize m_tableView;
@synthesize m_lableTitle;
@synthesize m_barButtonRefresh;
@synthesize m_indicatorView;
@synthesize m_toolBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma -
#pragma mark private methods
- (void)startUpdate{
    
    [m_toolBar setItems:nil];
    [m_indicatorView startAnimating];
    
}

- (void)stopUpdate{
    
    [m_indicatorView stopAnimating];
    UIBarButtonItem *_flexiSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [m_toolBar setItems:[NSArray arrayWithObjects:_flexiSpace,m_barButtonRefresh, nil]];
    
}


#pragma -
#pragma mark button actions methods

- (void)refreshButtonClick{
    
    NSLog(@"refreshButtonClick");
    
    [self startUpdate];
    
    [self performSelector:@selector(stopUpdate) withObject:nil afterDelay:1.0];
    
}


#pragma -
#pragma mark private init methods
- (void)initUI{
    
    //tool bar
    UIToolbar *_toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    _toolBar.barStyle = UIBarStyleBlack;
    self.m_toolBar = _toolBar;
    
    //lable title
    UILabel *_labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    self.m_lableTitle = _labelTitle;
    
    
    //refresh button
    UIBarButtonItem *_flexiSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonClick)];
    self.m_barButtonRefresh = _barButton;
    [m_toolBar setItems:[NSArray arrayWithObjects:_flexiSpace,m_barButtonRefresh, nil]];
    [self.view addSubview:_toolBar];
    [m_toolBar addSubview:m_lableTitle];
    
    //indicator
    UIActivityIndicatorView *_indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(320 - 44, 0, 44, 44)];
    [_indicatorView setHidesWhenStopped:YES];
    self.m_indicatorView = _indicatorView;
    [m_toolBar addSubview:m_indicatorView];
    [m_indicatorView stopAnimating];
    
    //table view
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 416) style:UITableViewStylePlain];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.m_tableView = _tableView;
    
    [self.view addSubview:m_tableView];
    
}


#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
	
    return 50;
    
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return 20;
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //use cache self
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //old method
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundView = nil;
    cell.backgroundColor = [UIColor clearColor];
    
    /*
     UIView *_contentView = cell.contentView;
     for(EmailCell *_cell in [_contentView subviews]){
     [_cell removeFromSuperview];
     }
     
     
     CGAffineTransform transform = CGAffineTransformIdentity;
     transform = CGAffineTransformMakeRotation(M_PI/2);
     contentView.transform = transform;
     */
    
    
    cell.textLabel.text = @"hello";
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

- (void)scrollViewDidEndDragging:(UITableView *)scrollView willDecelerate:(BOOL)decelerate {
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
}



@end
