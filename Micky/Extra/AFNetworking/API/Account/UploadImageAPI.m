//
//  UploadImageAPI.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UploadImageAPI.h"
#import "Defination.h"

@implementation UploadImageAPI{
    UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"image";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)jsonValidator {
    return @{ @"imageId": [NSString class] };
}

- (NSString *)responseImageId {
    NSDictionary *dict = self.responseJSONObject;
    return dict[@"imageId"];
}


@end
