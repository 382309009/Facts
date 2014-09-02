//
//  FacesCell.m
//  Facts
//
//  Created by zhoujinhao on 9/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "FacesCell.h"
#import "DataCenter.h"

@interface FacesCell(){
    
}

@end


@implementation FacesCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width
{
    CGRect rect;
    
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iosVersion >= 7.0) {
        rect = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    }
    else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
    }

    return rect.size.height;
}



- (void)setDataWithDict: (NSDictionary *)_dictParam{
    
    NSString *_strTitle = [_dictParam objectForKey:KEY_TITLE];
    NSString *_strDesc = [_dictParam objectForKey:KEY_DESCRIPTION];
    NSString *_strImageHref = [_dictParam objectForKey:KEY_IMAGEHREF];
    
    if([_strTitle isKindOfClass:[NSNull class]]){
        _strTitle = @"";
    }
    
    if([_strDesc isKindOfClass:[NSNull class]]){
        _strDesc = @"";
    }
    
    if([_strImageHref isKindOfClass:[NSNull class]]){
        _strImageHref = @"";
    }
 
    UIFont *_fontToUse = [UIFont fontWithName: @"STHeitiTC-Light" size: 15];
    
    //title
    float _fHeight = [self heightFromString:_strTitle withFont:_fontToUse constraintToWidth:300];
    
    UILabel *_lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, _fHeight)];
    _lableTitle.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    _lableTitle.numberOfLines = 10;
    _lableTitle.font = _fontToUse;
    
    [self addSubview:_lableTitle];
    _lableTitle.text = _strTitle;
    
    //desc
    float _fHeightDesc = [self heightFromString:_strDesc withFont:_fontToUse  constraintToWidth:200];
    
    UILabel *_lableDesc = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + _fHeight, 200, _fHeightDesc)];
    _lableDesc.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
    _lableDesc.numberOfLines = 10;
    _lableDesc.font = _fontToUse;
    
    [self addSubview:_lableDesc];
    _lableDesc.text = _strDesc;
    
    self.frame = CGRectMake(0, 0, 320, 35 + _fHeight + _fHeightDesc);
    
    UIImageView *_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(210, _fHeight + 20, 100, _fHeightDesc)];
    [self addSubview:_imageView];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [[DataCenter sharedObject] getImageWithURL:_strImageHref withCallback:^(UIImage *imageBack) {
       
        _imageView.image = imageBack;
        
    }];
    
    
}



@end
