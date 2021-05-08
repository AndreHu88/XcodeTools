//___FILEHEADER___

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - Life cycle
- (void)dealloc {
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"<#title#>";
    [self setupSubViews];
    [self setupViewLayouts];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     
}

- (void)setupSubViews {
    
    
}

- (void)setupViewLayouts {
    
    
}

#pragma mark - Events
 
#pragma mark - UITextFieldDelegate
 
#pragma mark - UITableViewDataSource
 
#pragma mark - UITableViewDelegate
 
#pragma mark - UIOtherComponentDelegate
 
#pragma mark - Custom Delegates
 
#pragma mark - Public Methods
 
#pragma mark - Private Methods

#pragma mark - Setter & Getter


@end
