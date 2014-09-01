//
//  FacesCell.m
//  Facts
//
//  Created by zhoujinhao on 9/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "FacesCell.h"

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

- (void)setDataWithDict: (NSDictionary *)_dictParam{
    
    NSString *_strTitle = [_dictParam objectForKey:KEY_TITLE];
    NSString *_strDesc = [_dictParam objectForKey:KEY_DESCRIPTION];
    NSString *_strImageHref = [_dictParam objectForKey:KEY_IMAGEHREF];
    
    
    
}


@end
