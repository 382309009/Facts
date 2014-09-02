//
//  DataCenter.m
//  Facts
//
//  Created by zhoujinhao on 9/2/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "DataCenter.h"
#import "CJSONDeserializer.h"

@interface DataCenter(){
    
    dispatch_queue_t m_facts_update_queue;
    dispatch_queue_t m_facts_image_download_queue;
    
    NSMutableSet     *m_mSet;
    
}

@property (nonatomic, strong) NSMutableSet  *m_mSet;


- (dispatch_queue_t)getUpdateDataQueue;
- (dispatch_queue_t)getImageDownloadQueue;
- (NSMutableSet *)getMSet;
- (NSString *)getImageNameFromURL: (NSString *)_strURL;
- (NSString *)getImageCachePathWithName: (NSString *)_strName;


@end


@implementation DataCenter
@synthesize m_mSet;
///////////////////////////////////////////////////////////////////////////////////////
#pragma mark Shared Object
///////////////////////////////////////////////////////////////////////////////////////

+ (DataCenter *)sharedObject
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (void)getFactsDataWithCallback: (DataBack)_callback{
    
    dispatch_async([self getUpdateDataQueue], ^{
        @autoreleasepool {
            
            NSURL *url = [NSURL URLWithString:BASE_URL];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"GET"];
            
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"error : %@",error);
            
            // Parse JSON results with TouchJSON.  It converts it into a dictionary.
            CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
            NSError *error1 = nil;
            NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:result error:&error1];
            
            NSLog(@"error1 : %@",error1);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _callback(resultsDictionary);
                
            });
            
        }
    });
    
}



- (void)getImageWithURL: (NSString *)_strURL withCallback: (ImageBack)_callback{
    
    dispatch_async([self getImageDownloadQueue], ^{
        @autoreleasepool {
            
            NSString *strURLNew = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge  CFStringRef)_strURL, NULL, NULL, kCFStringEncodingUTF8);
            
            NSString *_strName = [self getImageNameFromURL:strURLNew];
            NSString *_strPath = [self getImageCachePathWithName:_strName];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:_strPath]){
                
                NSData *_dataImage = [[NSData alloc] initWithContentsOfMappedFile:_strPath];
                UIImage *_imageData = [[UIImage alloc] initWithData:_dataImage];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _callback(_imageData);
                    
                });
                
            }
            else{
                
                if(![[self getMSet] containsObject:_strName]){
                    
                    [[self getMSet] addObject:_strName];
                    
                    NSURL *_urlString = [[NSURL alloc] initWithString:strURLNew];
                    NSData *_dataImage = [[NSData alloc] initWithContentsOfURL:_urlString];
                    UIImage *_imageData = [[UIImage alloc] initWithData:_dataImage];
                    
                    if([_dataImage writeToFile:_strPath atomically:YES]){
                        
                        [[self getMSet] removeObject:_strName];
                        
                        dispatch_async(dispatch_get_main_queue(),^{
                            
                            _callback(_imageData);
                            
                        });
                        
                    }

                    
                }
                
            }
            
        }
    });

}


- (dispatch_queue_t)getUpdateDataQueue{
    
    if(!m_facts_update_queue){
        
        NSString *_strBundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        NSString *_strQueueId = [NSString stringWithFormat:@"facts_1_%@",_strBundleIdentifier];
        
        m_facts_update_queue = dispatch_queue_create([_strQueueId cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
        
    }

    return m_facts_update_queue;
    
}

- (dispatch_queue_t)getImageDownloadQueue{
    
    if(!m_facts_image_download_queue){
        
        NSString *_strBundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        NSString *_strQueueId = [NSString stringWithFormat:@"facts_2_%@",_strBundleIdentifier];
        
        m_facts_image_download_queue = dispatch_queue_create([_strQueueId cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_CONCURRENT);
        
    }
    
    return m_facts_image_download_queue;
    
}


- (NSMutableSet *)getMSet{
    
    if(m_mSet == nil){
        
        NSMutableSet *_mSet = [[NSMutableSet alloc] init];
        self.m_mSet = _mSet;
        
    }
    
    return m_mSet;
    
}

- (NSString *)getImageNameFromURL: (NSString *)_strURL{
    
    NSArray *_array = [_strURL componentsSeparatedByString:@"/"];
    if([_array count] > 0){
        
        NSString *_strName = [_array lastObject];
        return _strName;
        
    }
    
    return nil;
    
}

- (NSString *)getImageCachePathWithName: (NSString *)_strName{
    
    NSString *_strPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:_strName];
    
    return _strPath;
    
}


@end
