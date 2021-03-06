//
//  UITextField+ASTextField.m
//  ASTextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import "ASTextField.h"
#import "QDTool.h"
#define kLeftPadding 10
#define kVerticalPadding 12
#define kHorizontalPadding 10

#define kAccount  @"account"
#define kPassword  @"password"
#define kPasswordDis  @"passwordDis"

@interface ASTextField (){
    ASTextFieldType _type;
}

@end

@implementation ASTextField

//-(void)drawPlaceholderInRect:(CGRect)rect
//{
////    [[QDTool getColorWithKey:QDCOLOR_NEWLOGIN_TEXTFIELDPLACEHOLDERFONT] setFill];
//    if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
//    {
//        [[QDTool hexStringToColor:@"#656b6e"] setFill];
//
//    }
//    else
//    {
//        [[QDTool hexStringToColor:@"#898989"] setFill];
//    }
//    [[self placeholder]drawInRect:rect withFont:[UIFont systemFontOfSize:17]];
//}

- (CGRect)textRectForBounds:(CGRect)bounds {
    UIEdgeInsets edge = [self edgeInsetsForType:_type];
    
    CGFloat x = bounds.origin.x + edge.left +kLeftPadding;
    CGFloat y = bounds.origin.y + kVerticalPadding;
    
    
    return CGRectMake(x,y,bounds.size.width - kHorizontalPadding*2, bounds.size.height - kVerticalPadding*2);
    
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)setupTextFieldWithIconName:(NSString *)name{
    //    [self setupTextFieldWithType:ASTextFieldTypeAccount withIconName:name];
}
- (void)setupTextFieldWithType:(ASTextFieldType)type delegate:(id)fromDelegate withIconName:(NSString *)name{
    
    self.asDelegate = fromDelegate;
    
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    NSString *imageName = [self backgroundImageNameForType:type];
    CGRect imageViewFrame = [self iconImageViewRectForType:type];
    _type = type;
    
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:edge];
    
    
    
    UIImage *icon = [UIImage imageNamed:name];
    UIColor *normalTitleColor=nil;
    UIColor *selectTtileColor=nil;
    self.backgroundColor = [UIColor whiteColor];
    if(_type==ASTextFieldTypeAccount )
    {
        icon=[UIImage imageNamed:@"t1_user_name_icon"];
    }
    else if(_type==ASTextFieldTypePassWord)
    {
        icon=[UIImage imageNamed:@"t1_password_icon"];
    }
    else if(_type==ASTextFieldTypeTraderPassWord)
    {
        icon=[UIImage imageNamed:@"t1_password_icon"];
    }
    if ([name isEqualToString:@"black_icon_account_2"]) {
        icon=[UIImage imageNamed:@"black_icon_account_2"];
    } else if([name isEqualToString:@"black_icon_passwd_2"]) {
        icon=[UIImage imageNamed:@"black_icon_passwd_2"];
    }
    
    if(_type==ASTextFieldTypeAccount || _type==ASTextFieldTypePassWord|| _type==ASTextFieldTypeTraderPassWord)
    {
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth=1.0f;
        
    }
    else
    {
        self.backgroundColor=[UIColor clearColor];
    }
    
    
    selectTtileColor=[UIColor blackColor];
    
    
    
    //make an imageview to show an icon on the left side of textfield
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [iconImage setImage:icon];
    iconImage.frame = CGRectMake(5, 0, 15, 15);
    
    
    [iconImage setContentMode:UIViewContentModeScaleAspectFill];
    iconImage.clipsToBounds = NO;
    
    UIView *iconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 15)];
    
    [iconView addSubview:iconImage];
    
    self.leftView = iconView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    CGRect btnFrame = [self iconImageViewRectForRight:type];
    NSString * groupID = kAccount;
    if (_type == ASTextFieldTypeAccount) {
        groupID = kAccount;
    }
    else if (_type == ASTextFieldTypePassWord){
        groupID = kPassword;
    }
    else if (_type == ASTextFieldTypeTraderPassWord){
        groupID = kPasswordDis;
    }
    if (_type == ASTextFieldTypeAccount ) {
        QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:groupID];
        radio1.frame = btnFrame;
        
        self.radio1 = radio1;
        [radio1 setTitleColor:normalTitleColor forState:UIControlStateNormal];
        [radio1 setTitleColor:selectTtileColor forState:UIControlStateSelected];
        [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [radio1 setTitle:NSLocalizedString(@"记住", @"") forState:UIControlStateNormal];
        [self addSubview:radio1];
        [radio1 setChecked:NO];
        
        self.rightView = radio1;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else if (_type == ASTextFieldTypePassWord ){
        QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:groupID];
        radio1.frame = btnFrame;
        
        self.radio1 = radio1;
        [radio1 setTitleColor:normalTitleColor forState:UIControlStateNormal];
        [radio1 setTitleColor:selectTtileColor forState:UIControlStateSelected];
        [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [radio1 setTitle:NSLocalizedString(@"可见", @"") forState:UIControlStateNormal];
        [self addSubview:radio1];
        [radio1 setChecked:NO];
        
        self.rightView = radio1;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else if (_type == ASTextFieldTypeTraderPassWord ){
        QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:groupID];
        radio1.frame = btnFrame;
        
        self.radio1 = radio1;
        [radio1 setTitleColor:normalTitleColor forState:UIControlStateNormal];
        [radio1 setTitleColor:selectTtileColor forState:UIControlStateSelected];
        [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [radio1 setTitle:NSLocalizedString(@"保存", @"") forState:UIControlStateNormal];
        [self addSubview:radio1];
        [radio1 setChecked:self.radio1.selected];
        
        self.rightView = radio1;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    
    
    
    [self setNeedsDisplay]; //force reload for updated editing rect for bound to take effect.
}

- (void)setupTextFieldWithType:(ASTextFieldType)type delegate:(id)fromDelegate withIconName:(NSString *)name withRadioSelected:(BOOL)selected
{
    self.asDelegate = fromDelegate;
    
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    NSString *imageName = [self backgroundImageNameForType:type];
    CGRect imageViewFrame = [self iconImageViewRectForType:type];
    _type = type;
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:edge];
    
    UIImage *icon = [UIImage imageNamed:name];
    UIColor *normalTitleColor=nil;
    UIColor *selectTtileColor=nil;
    self.backgroundColor = [UIColor whiteColor];
    if(_type==ASTextFieldTypeAccount )
    {
        icon=[UIImage imageNamed:@"t1_user_name_icon"];
    }
    else if(_type==ASTextFieldTypePassWord)
    {
        icon=[UIImage imageNamed:@"t1_password_icon"];
    }
    else if(_type==ASTextFieldTypeTraderPassWord)
    {
        icon=[UIImage imageNamed:@"t1_password_icon"];
    }
    if ([name isEqualToString:@"black_icon_account_2"]) {
        icon=[UIImage imageNamed:@"black_icon_account_2"];
    } else if([name isEqualToString:@"black_icon_passwd_2"]) {
        icon=[UIImage imageNamed:@"black_icon_passwd_2"];
    }
    
    if(_type==ASTextFieldTypeAccount || _type==ASTextFieldTypePassWord|| _type==ASTextFieldTypeTraderPassWord)
    {
        //边框形状颜色
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth=1.0f;
        self.layer.borderColor=[QDTool hexStringToColor:@"#2d6ab0"].CGColor;
    }
    else
    {
        self.backgroundColor=[UIColor clearColor];
    }
    
    //make an imageview to show an icon on the left side of textfield
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [iconImage setImage:icon];
    iconImage.frame = CGRectMake(5, 0, 15, 15);
    
    
    [iconImage setContentMode:UIViewContentModeScaleAspectFill];
    iconImage.clipsToBounds = NO;
    
    UIView *iconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 15)];
    
    [iconView addSubview:iconImage];
    
    self.leftView = iconView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    CGRect btnFrame = [self iconImageViewRectForRight:type];
    NSString * groupID = kAccount;
    if (_type == ASTextFieldTypeAccount) {
        groupID = kAccount;
    }
    else if (_type == ASTextFieldTypePassWord){
        groupID = kPassword;
    }
    else if (_type == ASTextFieldTypeTraderPassWord){
        groupID = kPasswordDis;
    }
    
    
    if (_type == ASTextFieldTypeAccount ) {
        QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:groupID];
        radio1.frame = btnFrame;
        
        self.radio1 = radio1;
        [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [radio1 setTitle:NSLocalizedString(@"记住", @"") forState:UIControlStateNormal];
        [self addSubview:radio1];
        [radio1 setChecked:selected];
        self.rightView = radio1;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else if (_type == ASTextFieldTypePassWord ){
        QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:groupID];
        radio1.frame = btnFrame;
        
        self.radio1 = radio1;
        [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [radio1 setTitle:NSLocalizedString(@"可见", @"") forState:UIControlStateNormal];
        [self addSubview:radio1];
        [radio1 setChecked:selected];
        self.rightView = radio1;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else if (_type == ASTextFieldTypeTraderPassWord ){
        QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:groupID];
        radio1.frame = btnFrame;
        
        self.radio1 = radio1;
        [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [radio1 setTitle:NSLocalizedString(@"保存", @"") forState:UIControlStateNormal];
        [self addSubview:radio1];
        [radio1 setChecked:selected];
        self.rightView = radio1;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    //button的选中与非选中颜色
    normalTitleColor=[QDTool hexStringToColor:@"#898989"];
    selectTtileColor=[UIColor blackColor];
    
    [self.radio1 setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self.radio1 setTitleColor:selectTtileColor forState:UIControlStateSelected];
    [self setNeedsDisplay];
}

- (CGRect)iconImageViewRectForType:(ASTextFieldType) type{
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    
    return CGRectMake(0, 0, edge.left*2, self.frame.size.height); //to put the icon inside
}

- (CGRect)iconImageViewRectForRight:(ASTextFieldType) type{
    
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    
    return CGRectMake(self.frame.size.width - edge.left*4.5, 3, edge.left*4.5, self.frame.size.height-6); //to put the icon inside
}

- (UIEdgeInsets)edgeInsetsForType:(ASTextFieldType) type{
    return UIEdgeInsetsMake(13, 13, 13, 13);
    
}


-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 2;
    return iconRect;
}


- (NSString *)backgroundImageNameForType:(ASTextFieldType) type{
    
    return @"Login_border";
}


- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId select:(BOOL)selected{
    
    if (groupId.length <= 0) {
        return;
    }
    
    if ([groupId compare:kAccount] == NSOrderedSame) {
        
        if ([self.asDelegate respondsToSelector:@selector(selectAccount:)]) {
            
            [self.asDelegate selectAccount:selected];
        }
        
    }else if ([groupId compare:kPassword] == NSOrderedSame){
        
        if (selected == NO) {
            self.secureTextEntry = YES;
        }else{
            self.secureTextEntry = NO;
        }
    }
    else if ([groupId compare:kPasswordDis] == NSOrderedSame){
        if ([self.asDelegate respondsToSelector:@selector(selectAccount:)]) {
            
            [self.asDelegate selectAccount:selected];
        }
        self.secureTextEntry = YES;
        
    }
    
}


-(void)resetSkinColor
{
    UIImage *icon = nil;
    UIColor *normalTitleColor=nil;
    UIColor *selectTtileColor=nil;
    CGRect imageViewFrame = [self iconImageViewRectForType:_type];
    self.backgroundColor = [UIColor whiteColor];
    if(_type==ASTextFieldTypeAccount )
    {
        icon=[UIImage imageNamed:@"t1_user_name_icon"];
    }
    else if(_type==ASTextFieldTypePassWord)
    {
        icon=[UIImage imageNamed:@"t1_password_icon"];
    }
    
    if(_type==ASTextFieldTypeAccount || _type==ASTextFieldTypePassWord)
    {
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth=1.0f;
    }
    else
    {
        self.backgroundColor=[UIColor clearColor];
    }
    
    selectTtileColor=[UIColor blackColor];
    
    
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [iconImage setImage:icon];
    [iconImage setContentMode:UIViewContentModeCenter];
    self.leftView = iconImage;
    
    [self.radio1 setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self.radio1 setTitleColor:selectTtileColor forState:UIControlStateSelected];
    [self.radio1 resetSkinColor];
}
@end
