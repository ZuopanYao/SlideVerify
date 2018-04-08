# SlideVerify

iOS平台的滑动验证码

![](SlideVerify.gif)

## 要求/Requirements
- iOS 9.0+
- Xcode 9.0+

## 安装/Installation

### CocoaPods
```
pod 'SlideVerify'
```

### Carthage
```
github "ZuopanYao/SlideVerify"
```

## 使用/Usage
- 模式一

```
 UIImage *originImage = [UIImage imageNamed:@"my_image_name"];
    
SVSlideVerifyView  *scView = [[SVSlideVerifyView alloc] initWithFrame:CGRectMake(0, 0, originImage.size.width, originImage.size.height)];
scView.image = originImage;
scView.targetColor = [UIColor whiteColor];
scView.interactColor = [UIColor redColor];
[self.view addSubview:scView];
    
scView.compeleted = ^(BOOL isSuccess) {
    
};
```

- 模式二

```
UIImage *originImage = [UIImage imageNamed:@"my_image_name"];
    
SVSlideVerifyView  *scView = [[SVSlideVerifyView alloc] initWithFrame:CGRectMake(0, 0, originImage.size.width, originImage.size.height)];
scView.image = originImage;
scView.targetColor = [UIColor whiteColor];
scView.interactColor = [UIColor redColor];
[self.view addSubview:scView];

SVSlideBarView *slideBarView = [[SVSlideBarView alloc] initWithFrame:CGRectMake(0, 250, 300, 45)];
[self.view addSubview:slideBarView];
 
scView.slideBarView = slideBarView;
scView.compeleted = ^(BOOL isSuccess) {
    
};

```