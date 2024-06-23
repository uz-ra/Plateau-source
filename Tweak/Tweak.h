#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <substrate.h>
#import <rootless.h>
#import <objc/runtime.h>

@interface SBHomeGrabberRevealGesturesManager : NSObject
@end

@interface SBOrientationLockManager : NSObject
+ (id)sharedInstance;
-(void)lock:(long long)arg1 ;
-(void)unlock;
-(long long)userLockOrientation;
-(BOOL)isUserLocked;
@end

@interface SBLockHardwareButton : NSObject
@end

@interface SBRootSceneWindow : UIWindow
-(UIView*)contentView;
-(void)setFrame:(CGRect)arg1 ;

@property (nonatomic,retain) UIView *PTbackgroundView;
@property (nonatomic,retain) UIView *pillView;
@property (nonatomic,retain) UIVisualEffectView *PTblurView;
@property (nonatomic,retain) UIView *PTshadowView;
@property (nonatomic, strong) UIButton *PTportraitUpButton;
@property (nonatomic, strong) UIButton *PTportraitDownButton;
@property (nonatomic, strong) UIButton *PTlandscapeLeftButton;
@property (nonatomic, strong) UIButton *PTlandscapeRightButton;
@property (nonatomic, strong) UIButton *PTdismissButton;
-(void)addPTbackgroundView;
-(void)addPTblurView;
-(void)addPTshadowView;
-(void)addPTportraitUpButton;
-(void)addPTlandscapeRightButton;
-(void)addPTlandscapeLeftButton;
-(void)addPTdismissButton;
-(void)PTexpand;
-(void)PTdismiss;
-(void)addPTportraitDownButton;
@end

@interface SBGrabberTongue : NSObject
@end

//2
//34
//1