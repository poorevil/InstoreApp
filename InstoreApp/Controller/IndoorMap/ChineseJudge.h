//
//  ChineseJudge.h
//  MBSMapSample
//
//  Created by sunyifei on 11/15/12.
//
//

#import <Foundation/Foundation.h>

@interface ChineseJudge : NSObject

+ (BOOL)stringHasChinese:(NSString*)oriString andConvertTo:(NSMutableString *)outString;
+ (unichar)getFirstChineseLetter:(unichar) ch;
@end
