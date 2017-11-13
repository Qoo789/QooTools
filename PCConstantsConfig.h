//
//  PCConstantsConfig.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#ifndef PCConstantsConfig_h
#define PCConstantsConfig_h


// 系统版本
// iOS 8以下
#define isBeforeiOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
// iOS 8以上
#define isLateriOS8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
// iOS 9以下
#define isBeforeiOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
// iOS 9以上
#define isLateriOS9  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
// iOS 10以下
#define isBeforeiOS10  ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)
// iOS 10及以上
#define isLateriOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
// iOS 11及以上
#define isLateriOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)


// 分辨率及屏幕尺寸相关
// 是否为高清屏
#define isRetina ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&([UIScreen mainScreen].scale == 2.0))

// 机器型号
#define isiPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define isiPhone4or4sor5or5s ( [UIScreen mainScreen].bounds.size.width == 320)
#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define isiPhone6Plus ([UIScreen mainScreen].bounds.size.height == 736)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define isiPhoneX ([UIScreen mainScreen].bounds.size.height == 812)


// 当前主窗口
#define kWindow [UIApplication sharedApplication].keyWindow


// 页面尺寸相关
// 主屏幕宽,高
#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

// 主控制器页面宽高
#define kMainViewWidth  [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.width
#define kMainViewHeight [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.height

// 当前导航栏高度
#define kCurrentNaviHeight self.navigationController.navigationBar.frame.size.height
// 当前状态栏高度
#define kCurrentStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
// 当前tabbar高度
#define kCurrentTabHeight self.tabBarController.tabBar.frame.size.height

// 状态栏高度(标准值), 适配 iPhone X
#define kStatusBatHeight         (kScreenHeight == 812 ? 44 : 20)
// 导航栏高度(标准值)
#define kNaviHeight              44 // 不加状态栏高度
//#define kNaviHeightAddStatusBar  64
#define kNaviHeightAddStatusBar  (kStatusBatHeight + kNaviHeight)
// HomeIndicator高度, 适配 iPhone X
#define kHomeIndicatorHeight     34
// tabbar高度(标准值), 适配 iPhone X
#define kTabbarHeight            (kScreenHeight == 812 ? (49 + kHomeIndicatorHeight) : 49)

// 比例系数
#define kWidthScale   kScreenWidth / 750
#define kHeightScale  kScreenHeight / 1334
// 812 是 iPhone X 的实际屏幕高度, 667.0表示是 iPhone 8 的高度
//#define kHeightScale  kScreenHeight / 1334 // (kScreenHeight == 812 ? 667.0 / 1334 : kScreenHeight / 1334)
// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view)  if (@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if ([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


// 快捷方法
// RGB颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// HEX颜色
#define HEXCOLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
// 常用颜色
#define PCTabBackColor          RGBCOLOR(255, 255, 255)
#define PCTabTintColor          RGBCOLOR(0, 0, 0)
#define PCNavBackColor          RGBCOLOR(255, 255, 255)
#define PCNavTintColor          RGBCOLOR(0, 0, 0)
#define PCMainColor             HEXCOLOR(0xff781f) // 主题色 #ff781f
#define PCControllerBackColor   RGBCOLOR(255, 255, 255)
#define PCCommonBtnTintColor    RGBCOLOR(255, 255, 255)
#define PCSeparatorColor        HEXCOLOR(0xe7e7e7)
#define PCBlackTextColor        HEXCOLOR(0x000000)
#define PCDisabledColor         HEXCOLOR(0xb0b0b0)
#define PCCommonCellTitleColor  HEXCOLOR(0x4a4a4a)
// ---------------------------------------
#define PCHintLabelColor        RGBCOLOR(117, 117, 117) // 提示label的字体颜色 #757575
#define PCTitleColor            RGBCOLOR(33, 33, 33) // 主要title字体颜色 #212121
#define PCGrayBackColor         RGBCOLOR(247, 247, 248) // 浅灰色背景色 ##f7f7f8
#define PCBackGroundColor       RGBCOLOR(243, 243, 245)

// 设置系统字体字号
#define SystemFont(size) [UIFont systemFontOfSize:size]
// 设置粗体系统字体字号
#define BoldFont(size) [UIFont boldSystemFontOfSize:size]
// 常用字体
#define PCCommonBtnFont SystemFont(17.0f)
#define PCNavItemFont   SystemFont(32 * kWidthScale)

// NSString 转 NSURL
#define URL(_url_) [NSURL URLWithString:_url_]
// 从路径获取图片
#define PCGetImagePath(imageName) [UIImage imagePathed:imageName]


// 本地化存储相关
// 账号信息存储地址
#define kAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAccount.data"]
// 个人信息存储地址
#define kUserInfoFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.data"]
// 是否开启指纹key
#define kFingerprintVerifyKey @"fingerprintVerifyIsOn"
// App 版本号存储key
#define kAppVersionKey @"appVersion"
// 进入后台时间记录key
#define kEnterBackgroundTimeKey @"enterBackgroundTime"


// 第三方服务账号信息相关
// 极光
#define kJPushAppKey @""
#define kJPushAppSecret @""


// 判断非空和空字符串
/**
 *  判断是否是空字符串 非空字符串 ＝ yes
 *  @param string
 *  @return
 */
#define  NotEmptyStr(string)  string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [string isEqualToString: @""] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ? NO : YES

/**
 *  判断是否是空字符串 空字符串 = yes
 *  @param string
 *  @return
 */
#define  IsEmptyStr(string)  string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ? YES : NO


#endif /* PCConstantsConfig_h */
