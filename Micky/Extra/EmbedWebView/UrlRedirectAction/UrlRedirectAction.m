//
//  UrlRedirectAction.m
//  NewStock
//
//  Created by Willey on 16/9/5.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "UrlRedirectAction.h"
#import "AppDelegate.h"

#import "WebViewController.h"

#import "Defination.h"

@implementation UrlRedirectAction
SYNTHESIZE_SINGLETON_FOR_CLASS(UrlRedirectAction)


+ (BOOL)redirectActionWithUrl:(NSURL *)url from:(NSString *)fromUrlStr navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",url.relativeString);
    NSLog(@"%@",url.absoluteString);
    NSLog(@"%@",url.parameterString);
    NSLog(@"%@",url.path);
    NSLog(@"%@",url.relativePath);
    NSLog(@"%@",url.query);
    
    NSString *strUrl = url.absoluteString;
    if ([strUrl hasPrefix:@"native://"])
    {
        NSString *subUrl = [strUrl substringFromIndex:9];
        
        if ([subUrl hasPrefix:@"HQ1000"])
        {
            NSLog(@"%@",[subUrl substringFromIndex:7]);
            NSDictionary *dic = [UrlRedirectAction parseURLParams:[subUrl substringFromIndex:7]];
            NSLog(@"%@==%@",[subUrl substringFromIndex:7],dic);

        }
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        if ([strUrl hasPrefix:@"http://"]||[strUrl hasPrefix:@"https://"])
        {
            WebViewController *viewController = [[WebViewController alloc] init];
            viewController.myUrl = url.absoluteString;
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [appDelegate.navigationController pushViewController:viewController animated:YES];
            return NO;
        }
    }
    
    
    NSRange range = [fromUrlStr rangeOfString:url.path];
    if (range.location == NSNotFound)
    {
        NSLog(@"fromUrlStr:%@",fromUrlStr);
        NSLog(@"url.path:%@",url.path);
        
        if(![fromUrlStr isEqualToString:url.absoluteString])
        {
            if ([strUrl hasPrefix:@"http://"]||[strUrl hasPrefix:@"https://"])
            {
                WebViewController *viewController = [[WebViewController alloc] init];
                viewController.myUrl = url.absoluteString;
                
                
                NSRange urlRange = [url.absoluteString rangeOfString:@"comment=true"];
                if (urlRange.length >0)
                {
                    viewController.type = WEB_VIEW_TYPE_COMMENT;
                }
                
                
//                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                [appDelegate.navigationController pushViewController:viewController animated:YES];
                
                return NO;
            }
        }
        
        
    }

    return YES;

}


/**
 * 解析URL参数的工具方法。
 */
+ (NSDictionary *)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:[kv objectAtIndex:0]];
        }
    }
    return params;
}

/*
 * 根据指定的参数名，从URL中找出并返回对应的参数值。
 */
+ (NSString *)getValueStringFromUrl:(NSString *)url forParam:(NSString *)param
{
    NSString * str = nil;
    NSRange start = [url rangeOfString:[param stringByAppendingString:@"="]];
    if (start.location != NSNotFound) {
        NSRange end = [[url substringFromIndex:start.location + start.length] rangeOfString:@"&"];
        NSUInteger offset = start.location+start.length;
        str = end.location == NSNotFound
        ? [url substringFromIndex:offset]
        : [url substringWithRange:NSMakeRange(offset, end.location)];
        str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return str;
}

@end
