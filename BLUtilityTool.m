//
//  BLUtilityTool.m
//  ALibTest
//
//  Created by TianQiXuDa on 2021/1/5.
//

#import "BLUtilityTool.h"

@implementation BLUtilityTool

#pragma mark -- 检查数据
+ (BOOL)checkObjectAvailable:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return NO;
    }
    
    if ([object isKindOfClass:[NSString class]])
    {
        if ([object isEqualToString:@""] || [object isEqualToString:@"null"] || [object isEqualToString:@"(null)"]) {
            return NO;
        }
        
        NSString *string = [object stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (string.length == 0) {
            return NO;
        }
        
        return YES;
    }
    else if ([object isKindOfClass:[NSArray class]])
    {
        NSArray *array = (NSArray *)object;
        if (array.count>0) {
            return YES;
        }
    }
    else if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)object;
        if (dict.count>0) {
            return YES;
        }
    }
    else if ([object isKindOfClass:[NSData class]])
    {
        NSData *data = (NSData *)object;
        if (data.length>0) {
            return YES;
        }
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        if (object == nil || [object isEqual:[NSNull null]])
        {
            return NO;
        }
        return YES;
        
    }
    else if ([object isKindOfClass:[NSValue class]])
    {
        if (object == nil || [object isEqual:[NSNull null]]) {
            return NO;
        }
        return YES;
    }
    else if ([object isKindOfClass:[NSObject class]])
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 正则验证
+ (BOOL)checkIdNo:(NSString *)identity
{
    BOOL flag;
    if (identity.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identity];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identity.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identity substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identity substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
            else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
    return NO;
}

+ (BOOL)checkMobileNo:(NSString *)phone forType:(NSInteger)type
{
    if (type == 1) {
        NSString * cm = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[2-478])\\d)\\d{7}$";
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
        if ([regextestcm evaluateWithObject:phone]) {
            return YES;
        }
    }
    else if (type == 2)
    {
        NSString * cu = @"^1(3[0-2]|5[56]|76|8[56])\\d{8}$";
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
        if ([regextestcu evaluateWithObject:phone]) {
            return YES;
        }
    }
    else if (type == 3)
    {
        NSString * ct = @"^1((33|53|7[37]|8[019])[0-9]|349)\\d{7}$";
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
        if ([regextestct evaluateWithObject:phone]) {
            return YES;
        }
    }
    else if (type == 4){
        NSString * mobile = @"^1(3[0-9]|5[0-35-9]|47|7[0-9]|8[0-9])\\d{8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
        if ([regextestmobile evaluateWithObject:phone]) {
            return YES;
        }
    }
    else {
        NSString * mobile = @"^1([0-9])\\d{9}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
        if ([regextestmobile evaluateWithObject:phone]) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)checkMobileNo:(NSString *)phone
{
    if (phone.length == 11){
        if ([[phone substringToIndex:1] isEqualToString:@"1"]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *pattern = @"^1+[345789]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)checkLetterOrNumber:(NSString *)string minLength:(NSString *)minLength maxLength:(NSString *)maxLength
{
    NSString *pattern = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%@,%@}",minLength,maxLength];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


+ (BOOL)checkPassword:(NSString *)password minLength:(NSString *)minLength maxLength:(NSString *)maxLength
{
    NSString *pattern = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{%@,%@}",minLength,maxLength];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)checkUserName:(NSString *)userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

//纯数字
+ (BOOL)checkNumber:(NSString *)number
{
    NSString *pattern = @"^[0-9]*$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

+ (BOOL)checkFloatNumber:(NSString *)number  withLength:(NSString *)length
{
    NSString *pattern = [NSString stringWithFormat:@"^([0-9]*)+(.[0-9]{0,%@})?$",length];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

+ (BOOL)checkNumber:(NSString *)number withLength:(NSString *)length
{
    NSString *pattern = [NSString stringWithFormat:@"^[0-9]{%@}",length];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

+ (BOOL)checkNumber:(NSString *)string minLength:(NSString *)minLength maxLength:(NSString *)maxLength
{
    NSString *pattern = [NSString stringWithFormat:@"^\\d{%@,%@}$",minLength,maxLength];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

+ (BOOL)checkURL:(NSString *)url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

+ (NSString *)getPhoneSeparationFormat:(NSString *)text
{
    NSString *string = @"";
    if (text.length>7) {
        NSString *str1 = [text substringToIndex:3];
        NSString *str2 = [text substringWithRange:NSMakeRange(3, 4)];
        NSString *str3 = [text substringFromIndex:7];
        
        string = [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
    }
    else if (text.length>3)
    {
        NSString *str1 = [text substringToIndex:3];
        NSString *str3 = [text substringFromIndex:3];
        
        string = [NSString stringWithFormat:@"%@ %@",str1,str3];
    }
    return string;
}

+ (NSString *)getPhoneAsteriskFormat:(NSString *)text
{
    NSString *string = @"";
    if (text.length>7) {
        NSString *str1 = [text substringToIndex:3];
//        NSString *str2 = [text substringWithRange:NSMakeRange(3, 4)];
        NSString *str3 = [text substringFromIndex:7];
        
        string = [NSString stringWithFormat:@"%@ **** %@",str1,str3];
    }
    else if (text.length>3)
    {
        NSString *str1 = [text substringToIndex:3];
        NSString *str3 = [text substringFromIndex:3];
        
        string = [NSString stringWithFormat:@"%@ %@",str1,str3];
    }
    return string;
}

+ (NSString *)getBankCardSeparationFormat:(NSString *)text
{
    NSMutableString *showText = [NSMutableString stringWithString:text];
    for (NSInteger i = showText.length; i > 0; i--)
    {
        if (i%4 == 0)
        {
            //插入空格符
            [showText insertString:@" " atIndex:i];
        }
    }
    
    return showText;
}

+ (NSString *)getBankCardAsteriskFormat:(NSString *)text
{
    if (text.length < 9) {
        return text;
    }
    
    NSString *asterisk = @"*********************************";
    asterisk = [asterisk substringToIndex:text.length-8];
    NSString *showText = [text stringByReplacingCharactersInRange:NSMakeRange(4, text.length - 8) withString:asterisk];
    
    
    return showText;
}

//-------------------------货币格式-------------------------------//
+ (NSString *)getRMBCurrencyFormatter:(id )obj
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = nil;
    if ([obj isKindOfClass:[NSNumber class]])
    {
        number = obj;
    }
    else
    {
        number = [formatter numberFromString:[NSString stringWithFormat:@"%@",obj]];
    }
    NSString* formatted = [formatter stringFromNumber:number];
    
    return [NSString stringWithFormat:@"￥%@",formatted];
}

+ (NSString *)getCurrencyFormatter:(id )obj
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = nil;
    if ([obj isKindOfClass:[NSNumber class]])
    {
        number = obj;
    }
    else
    {
        number = [formatter numberFromString:[NSString stringWithFormat:@"%@",obj]];
    }
    NSString* formatted = [formatter stringFromNumber:number];
    
    return formatted;
}
//---------------------------时间处理--------------------------//
#pragma mark - 日期时间
+ (NSString *)getWeekDayFromDateString:(NSString *)datetime formatter:(NSString *)format
{
    NSDate *date = [BLUtilityTool stringToDate:datetime formatter:format];
    
    return [BLUtilityTool getWeekDayFromDate:date];
}

+ (NSString *)getWeekDayFromDate:(NSDate *)date
{
    //待完善
    return nil;
}

+ (NSDate *)stringToDate:(NSString *)datetime formatter:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    //    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [dateFormatter  dateFromString:datetime];
    
    return date;
}


+ (NSString *)dateToString:(NSDate *)datetime formatter:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    //    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [dateFormatter stringFromDate:datetime];
    
    return dateString;
}


+ (NSString *)changeDate:(NSString *)dateStr fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat
{
    NSDate *date = [BLUtilityTool stringToDate:dateStr formatter:fromFormat];
    NSString *dateString = [BLUtilityTool dateToString:date formatter:toFormat];
    
    return dateString;
}


+ (NSString *)timestampToString:(long long )timeInterval formatter:(NSString *)format
{
    return [BLUtilityTool timestampToString:timeInterval formatter:format isMesc:YES];
}

+ (NSString *)timestampToString:(long long)timeInterval formatter:(NSString *)format isMesc:(BOOL)mesc;
{
    NSDate *createTime;
    if (!mesc)
    {
        createTime = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        
    }else
    {
        createTime = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    }
    
    NSString *createDate = [BLUtilityTool dateToString:createTime formatter:format];

    return createDate;;
}

+ (NSString *)getNowStringWithFormatter:(NSString *)format
{
    return [self dateToString:[NSDate date] formatter:format];
}

#pragma mark - 字典取值

+ (NSString *)getStringFromDict:(NSDictionary *)dict withKey:(id)key
{
    NSString *string = @"";
    
    if ([BLUtilityTool checkObjectAvailable:dict]) {
        
        if ([BLUtilityTool checkObjectAvailable:[dict objectForKey:key]])  {
            string = [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
        }
    }

    return string;
}

//补充其它对象取值

+ (NSArray *)getArrayFromDict:(NSDictionary *)dict withKey:(id)key
{
    id object = [dict objectForKey:key];
    if ([object isKindOfClass:[NSArray class]])
    {
        return [NSArray arrayWithArray:object];
    }
    return nil;
}

+ (NSDictionary *)getDictionaryFromDict:(NSDictionary *)dict withKey:(id)key
{
    id object = [dict objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]])
    {
        return [NSDictionary dictionaryWithDictionary:object];
    }
    
    return @{};
}

+ (NSInteger)getIntegerFromDict:(NSDictionary *)dict withKey:(id)key
{
    NSInteger value = 0;
    id object = [dict objectForKey:key];
    if ([BLUtilityTool checkObjectAvailable:object]) {
        value = [object integerValue];
    }
    
    return value;
}

+ (NSInteger)getIntegerNegativeFromDict:(NSDictionary *)dict withKey:(id)key
{
    NSInteger value = -1;
    id object = [dict objectForKey:key];
    if ([BLUtilityTool checkObjectAvailable:object]) {
        value = [object integerValue];
    }
    
    return value;
}

+ (NSNumber *)getNumberFromDict:(NSDictionary *)dict withKey:(id)key
{
    NSNumber *number = [NSNumber numberWithDouble:0];
    
    if ([BLUtilityTool checkObjectAvailable:dict]) {
        
        if ([BLUtilityTool checkObjectAvailable:[dict objectForKey:key]])  {
           NSString  *string = [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
            number = [NSNumber numberWithDouble:[NSString reviseString:string].doubleValue];
        }
    }
    
    return number;
}

#pragma mark - 二维码

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image imageWidth:(CGFloat)imageWidth {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(imageWidth/CGRectGetWidth(extent), imageWidth/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(cs);
    return [UIImage imageWithCGImage:scaledImage];
}

+(UIImage *)getQRImageWithString:(NSString *)qrString imageWidth:(CGFloat)imageWidth
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = qrString;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    UIImage *aImage = [BLUtilityTool createNonInterpolatedUIImageFormCIImage:image imageWidth:imageWidth];
    
    return aImage;
}

#pragma mark - 判断emjio
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if ((0x1d000 <= uc && uc <= 0x1f77f) || (0x1F900 <= uc && uc <=0x1f9ff)){
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }else if (hs == 0x200d){
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}


+ (void)showAlertWithOneOption:(NSString *)optionName
                         title:(NSString *)title
                       message:(NSString *)message
                         event:(Block)eventBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, @"")
                                                                   message:NSLocalizedString(message, @"")
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(optionName, @"")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action)
                               {
                                   if (eventBlock) {
                                       eventBlock();
                                   }
                               }];
    
    [alert addAction:okAction];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertWithTwoOption:(NSString *)opName
                    cancleName:(NSString *)cancleName
                         title:(NSString *)title
                       message:(NSString *)message
                         event:(Block)eventBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, @"")
                                                                   message:NSLocalizedString(message, @"")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(cancleName, @"")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action)  { }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(opName, @"")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action)
                               {
                                   if (eventBlock) {
                                       eventBlock();
                                   }
                               }];
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
