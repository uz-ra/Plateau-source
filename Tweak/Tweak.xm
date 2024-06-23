#import "Tweak.h"
#define ROOTPATH(cPath) (access(cPath, F_OK) == 0) ? cPath : "/var/jb" cPath

static UITapGestureRecognizer *bounceTap = nil;
static SBRootSceneWindow *GrabberView=nil;

BOOL PTexpanded=NO;
CGFloat PTpaddingX = 300;
CGFloat PTheight = 100;
UIColor *PTcolor = [[UIColor scrollViewTexturedBackgroundColor] colorWithAlphaComponent:0.25];

%hook SBHomeGrabberRevealGesturesManager

- (id)init {
    %orig;
    bounceTap = [(id)self valueForKey:@"_bounceTapRecognizer"];
    return self;
}

- (void)_tapRecognized:(UITapGestureRecognizer *)tap {
    if (tap == bounceTap) {
%orig;
NSLog(@"Plateau : home bar tapped");
if(GrabberView != nil){
NSLog(@"Plateau : GrabberView is not nil");
if(!PTexpanded){
NSLog(@"Plateau : Not PTexpanded");
[GrabberView addPTbackgroundView];
[GrabberView PTexpand];
} else {
NSLog(@"Plateau : PTexpanded");
[GrabberView PTdismiss];
}

}

     } else {
         %orig;
     }
 }

%end


%hook SBRootSceneWindow
%property (nonatomic,retain) UIView *PTbackgroundView;
%property (nonatomic,retain) UIView *PTshadowView;
%property (nonatomic,retain) UIVisualEffectView *PTblurView;
%property (nonatomic, strong) UIButton *PTportraitUpButton;
%property (nonatomic, strong) UIButton *PTlandscapeLeftButton;
%property (nonatomic, strong) UIButton *PTlandscapeRightButton;
%property (nonatomic, strong) UIButton *PTdismissButton;

-(void)setFrame:(CGRect)arg1 {
%orig;
GrabberView = self;
}

%new
-(void)addPTbackgroundView{
NSLog(@"Plateau : addPTbackgroundView");
if(self.PTbackgroundView!=nil)return;
NSLog(@"Plateau : addPTbackgroundView didnt return");
self.PTbackgroundView = [[UIView alloc] init];
NSLog(@"Plateau : %@", NSStringFromCGRect(self.contentView.frame));
self.PTbackgroundView.frame = CGRectMake((self.contentView.frame.size.width-PTpaddingX)/2, self.contentView.frame.size.height-50, PTpaddingX, 5);
self.PTbackgroundView.backgroundColor = [UIColor clearColor];
self.PTbackgroundView.layer.shadowOffset = CGSizeMake(0, 2); // 影の向き CGSizeMake(左右, 上下) 右下に影
self.PTbackgroundView.layer.shadowRadius = 25;   // 影の半径
self.PTbackgroundView.layer.shadowOpacity = 0.4; // 影の透明度
self.PTbackgroundView.layer.shadowColor  = [[UIColor blackColor] CGColor];
[self.contentView addSubview:self.PTbackgroundView];
[self addPTblurView];
[self addPTportraitUpButton];
[self addPTlandscapeLeftButton];
[self addPTlandscapeRightButton];
[self addPTdismissButton];
//[self addPTportraitDownButton];
NSLog(@"Plateau : %@", NSStringFromCGRect(self.PTbackgroundView.frame));
//PTexpanded=NO;
}

%new
-(void)addPTblurView{
NSLog(@"Plateau : addPTblurView");
if(self.PTblurView!=nil)return;
NSLog(@"Plateau : addPTblurView didnt return");
	self.PTblurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterial]];
	self.PTblurView.frame = self.PTbackgroundView.bounds;
	self.PTblurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
self.PTblurView.layer.masksToBounds = YES;
self.PTblurView.layer.cornerRadius = PTheight/4;
	[self.PTbackgroundView addSubview:self.PTblurView];
}

%new
-(void)addPTportraitUpButton{
    self.PTportraitUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.PTportraitUpButton setTitle:@"" forState:UIControlStateNormal];
//[self.PTportraitUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.PTportraitUpButton setImage:[UIImage systemImageNamed:@"iphone"] forState:UIControlStateNormal];
self.PTportraitUpButton.imageView.transform = CGAffineTransformScale(self.PTportraitUpButton.imageView.transform, 2, 2);
self.PTportraitUpButton.frame = CGRectMake(0, 0, PTheight*0.6, PTheight*0.6);
self.PTportraitUpButton.center = CGPointMake(((PTpaddingX)/5)*1-15, PTheight/2);
//枠線の色
//    [self.PTportraitUpButton.layer setBorderColor:VXborderColor.CGColor];
    //枠線の太さ
//    [self.PTportraitUpButton.layer setBorderWidth: 0];
	[self.PTportraitUpButton setTintColor:[UIColor whiteColor]];
    [self.PTbackgroundView addSubview:self.PTportraitUpButton];

    self.PTportraitUpButton.backgroundColor = PTcolor;
    self.PTportraitUpButton.layer.cornerRadius = PTheight*0.6/3;

[self.PTportraitUpButton addTarget:self action:@selector(PTorientationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

%new
-(void)addPTlandscapeRightButton{
    self.PTlandscapeRightButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.PTportraitUpButton setTitle:@"" forState:UIControlStateNormal];
//[self.PTportraitUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.PTlandscapeRightButton setImage:[UIImage systemImageNamed:@"iphone.landscape"] forState:UIControlStateNormal];
self.PTlandscapeRightButton.imageView.transform = CGAffineTransformScale(self.PTlandscapeRightButton.imageView.transform, 2, 2);
self.PTlandscapeRightButton.frame = CGRectMake(0, 0, PTheight*0.6, PTheight*0.6);
self.PTlandscapeRightButton.center = CGPointMake(((PTpaddingX)/5)*2-5, PTheight/2);
//枠線の色
//    [self.PTportraitUpButton.layer setBorderColor:VXborderColor.CGColor];
    //枠線の太さ
//    [self.PTportraitUpButton.layer setBorderWidth: 0];
	[self.PTlandscapeRightButton setTintColor:[UIColor whiteColor]];
    [self.PTbackgroundView addSubview:self.PTlandscapeRightButton];

    self.PTlandscapeRightButton.backgroundColor = PTcolor;
    self.PTlandscapeRightButton.layer.cornerRadius = PTheight*0.6/3;

[self.PTlandscapeRightButton addTarget:self action:@selector(PTorientationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


%new
-(void)addPTlandscapeLeftButton{
    self.PTlandscapeLeftButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.PTportraitUpButton setTitle:@"" forState:UIControlStateNormal];
//[self.PTportraitUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.PTlandscapeLeftButton setImage:[UIImage systemImageNamed:@"iphone.landscape"] forState:UIControlStateNormal];
self.PTlandscapeLeftButton.imageView.transform = CGAffineTransformScale(self.PTlandscapeLeftButton.imageView.transform, -2, 2);
self.PTlandscapeLeftButton.frame = CGRectMake(0, 0, PTheight*0.6, PTheight*0.6);
self.PTlandscapeLeftButton.center = CGPointMake(((PTpaddingX)/5)*3+5, PTheight/2);
//枠線の色
//    [self.PTportraitUpButton.layer setBorderColor:VXborderColor.CGColor];
    //枠線の太さ
//    [self.PTportraitUpButton.layer setBorderWidth: 0];
	[self.PTlandscapeLeftButton setTintColor:[UIColor whiteColor]];
    [self.PTbackgroundView addSubview:self.PTlandscapeLeftButton];

    self.PTlandscapeLeftButton.backgroundColor = PTcolor;
    self.PTlandscapeLeftButton.layer.cornerRadius = PTheight*0.6/3;

[self.PTlandscapeLeftButton addTarget:self action:@selector(PTorientationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


%new
-(void)addPTdismissButton{
    self.PTdismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.PTportraitUpButton setTitle:@"" forState:UIControlStateNormal];
//[self.PTportraitUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.PTdismissButton setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateNormal];
self.PTdismissButton.imageView.transform = CGAffineTransformScale(self.PTdismissButton.imageView.transform, 2, 2);
self.PTdismissButton.frame = CGRectMake(0, 0, PTheight*0.6, PTheight*0.6);
self.PTdismissButton.center = CGPointMake(((PTpaddingX)/5)*4+15, PTheight/2);
//枠線の色
//    [self.PTportraitUpButton.layer setBorderColor:VXborderColor.CGColor];
    //枠線の太さ
//    [self.PTportraitUpButton.layer setBorderWidth: 0];
	[self.PTdismissButton setTintColor:[UIColor whiteColor]];
    [self.PTbackgroundView addSubview:self.PTdismissButton];

    self.PTdismissButton.backgroundColor = PTcolor;
    self.PTdismissButton.layer.cornerRadius = PTheight*0.6/3;

[self.PTdismissButton addTarget:self action:@selector(PTdismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

%new
- (void)PTorientationButtonClicked:(UIButton *)sender {
UINotificationFeedbackGenerator *_feedback = [[UINotificationFeedbackGenerator alloc] init];
        [_feedback prepare];
long long target;
if(sender==self.PTportraitUpButton){
target = 1;
} else if(sender==self.PTlandscapeRightButton){
target = 3;
} else if(sender==self.PTlandscapeLeftButton){
target = 4;
} 
if([[%c(SBOrientationLockManager) sharedInstance] isUserLocked] && [[%c(SBOrientationLockManager) sharedInstance] userLockOrientation] == target){
                [_feedback notificationOccurred:UINotificationFeedbackTypeError];

[[%c(SBOrientationLockManager) sharedInstance] unlock];
} else{
                [_feedback notificationOccurred:UINotificationFeedbackTypeSuccess];

//1=Portrait Up, 2 = Portrait Down, 3= Landscape Right, 4= Landscape Left 
[[%c(SBOrientationLockManager) sharedInstance] lock:target];
}


}
%new
- (void)PTdismissButtonClicked{
UINotificationFeedbackGenerator *_feedback = [[UINotificationFeedbackGenerator alloc] init];
        [_feedback prepare];
                [_feedback notificationOccurred:UINotificationFeedbackTypeWarning];
[self PTdismiss];
}
%new
-(void)PTexpand{

[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
self.PTbackgroundView.alpha=1;
} completion:nil];

[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
[self.PTbackgroundView setFrame:CGRectMake(self.PTbackgroundView.frame.origin.x, self.PTbackgroundView.frame.origin.y-PTheight, self.PTbackgroundView.frame.size.width, self.PTbackgroundView.frame.size.height+PTheight)];
} completion:^(BOOL finished) {

NSLog(@"Plateau : expand");
NSLog(@"Plateau : %@", NSStringFromCGRect(self.self.PTblurView.frame));
if(self.PTbackgroundView.hidden){
NSLog(@"Plateau : hidden");
}
}];

PTexpanded=YES;
}

%new
-(void)PTdismiss{
[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
self.PTbackgroundView.alpha=0;
self.PTbackgroundView.frame = CGRectMake((self.contentView.frame.size.width-PTpaddingX)/2, self.contentView.frame.size.height-50, PTpaddingX, 0);

} completion:^(BOOL finished) {

//[self.PTbackgroundView removeFromSuperview];
NSLog(@"Plateau : dismiss");
NSLog(@"Plateau : %@", NSStringFromCGRect(self.PTblurView.frame));
}];
PTexpanded=NO;
}

%end

%hook SBLockHardwareButton
-(void)singlePress:(id)arg1 {
%orig;
[GrabberView PTdismiss];
}
%end

%hook SBHomeHardwareButton
-(void)singlePressUp:(id)arg1{
    if (PTexpanded){
[GrabberView PTdismiss];
}else{
        %orig;
}
}
-(void)doublePressUp:(id)arg1 {
[GrabberView PTdismiss];
%orig;
}
%end

%hook SBGrabberTongue

-(BOOL)gestureRecognizerShouldBegin:(id)arg1 {
if(%orig==YES){
[GrabberView PTdismiss];
}
return %orig;
}
%end

