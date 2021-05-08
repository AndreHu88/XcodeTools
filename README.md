# XcodeTools

#### Code Snippet是Xcode中的代码块，可以将一些常用的代码添加为Snippet

`@property (nonatomic, copy) <#returnType#>(^<#blockName#>)(<#arguments#>);`

`@property (nonatomic, copy) <#returnType#>(^<#blockName#>)(<#arguments#>);`

常用的高频代码等等

Xcode的Snippet 的目录 `~/Library/Developer/Xcode/UserData/CodeSnippets` 

将Clone下来的项目中的Code Snippet中的文件拖入 `~/Library/Developer/Xcode/UserData/CodeSnippets`中即可

#### FileTemplate
可以自定义我们新建文件的模板，使我们的文件可以快速初始化成我们固定的模板

```
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

```

 Xcode的代码模板路径
 
 `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File Templates/iOS/Source/Cocoa Touch Class.xctemplate`
 
 将Clone下来的项目中的FileTemplate中的文件拖入 该目录即可
 
#### OC Extension
 该目录中存放一些OC中常用的扩展类
 
#### Swift Extension
该目录中存放一些Swift中常用的扩展类

#### Utils
该目录中存放一些项目中常用的工具类