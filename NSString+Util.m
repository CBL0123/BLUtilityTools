//
//  NSString+Util.m
//  ALibTest
//
//  Created by TianQiXuDa on 2021/1/5.
//

#import "NSString+Util.h"

@implementation NSString (Util)

//1、判断输入的字符串是否全是中文
- (BOOL)isAllChinese:(NSString *)str
{
    NSInteger count = str.length;
    NSInteger result = 0;
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
}

//1、判断输入的字符串是否有中文
- (BOOL)isHasChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            return YES;
        }
    }
    return NO;
}

/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+ (NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据 保留2位小数
 */
+ (NSString *)revise2fString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    NSString *sstring = [NSString stringWithFormat:@"%.2f",decNumber.doubleValue];
    return sstring;
}

/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据 保留2位小数   避免四舍五入（只舍不入）
 */
+ (NSString *)reviseRoundDownfString:(NSString *)str
{
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];

    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:str];
    // 四舍五入（只舍不入）
    NSDecimalNumber *roundUpNumber = [decNumber decimalNumberByRoundingAccordingToBehavior:roundUp];
    
    return [roundUpNumber stringValue];
}

/*!
 @brief 将string转成number 保留1位小数
 @param str 传入接口取到的数据
 @return 修正精度后的数据 保留1位小数
 */
+ (NSNumber *)stringToNumber:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%.1f", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber;
}

/*!
 @brief 将number转成string
 @param number 传入接口取到的数据
 @return 修正精度后的数据
 */
+ (NSString *)numberToString:(NSNumber *)number
{
    NSString *doubleString = [NSString stringWithFormat:@"%lf", number.doubleValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber.stringValue;
}

+ (NSString *)urlEncodeWithString:(NSString *)string
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return upSign;
}

//urlEncode解码
+ (NSString *)decoderUrlString:(NSString *)encodeString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:encodeString];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}

@end
