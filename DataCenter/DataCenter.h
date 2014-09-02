//
//  DataCenter.h
//  Facts
//
//  Created by zhoujinhao on 9/2/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DataBack)(NSDictionary* dictData);
typedef void (^ImageBack)(UIImage *imageBack);

@interface DataCenter : NSObject{
    
}

+ (DataCenter *)	sharedObject ;

- (void)getFactsDataWithCallback: (DataBack)_callback;
- (void)getImageWithURL: (NSString *)_strURL withCallback: (ImageBack)_callback;


@end
