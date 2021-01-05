//
//  NSString+Util.h
//  ALibTest
//
//  Created by TianQiXuDa on 2021/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Util)

//判断输入的字符串是否全是中文
- (BOOL)isAllChinese:(NSString *)str;

//判断输入的字符串是否有中文
- (BOOL)isHasChinese:(NSString *)str;

/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+ (NSString *)reviseString:(NSString *)str;
/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据 保留2位小数
 */
+ (NSString *)revise2fString:(NSString *)str;

/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据 保留2位小数   避免四舍五入（只舍不入）
 */
+ (NSString *)reviseRoundDownfString:(NSString *)str;

/*!
 @brief 将string转成number 保留1位小数
 @param str 传入接口取到的数据
 @return 修正精度后的数据 保留1位小数
 */
+ (NSNumber *)stringToNumber:(NSString *)str;

/*!
 @brief 将number转成string
 @param number 传入接口取到的数据
 @return 修正精度后的数据
 */
+ (NSString *)numberToString:(NSNumber *)number;


/*!
 @brief 编码字符串
 @param string 需要编码的字符串
 @return 编码后的字符串
 */
+ (NSString *)urlEncodeWithString:(NSString *)string;

/*!
 @brief 解码字符串
 @param encodeString 已经编码的字符串
 @return 解码后的字符串
 */
+ (NSString *)decoderUrlString:(NSString *)encodeString;


@end


NS_ASSUME_NONNULL_END
