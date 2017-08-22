//
//  UploadImageAPI.h
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface UploadImageAPI : APIRequest

- (id)initWithImage:(UIImage *)image;

- (NSString *)responseImageId;

@end
