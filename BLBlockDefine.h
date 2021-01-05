//
//  BLBlockDefine.h
//  ALibTest
//
//  Created by TianQiXuDa on 2021/1/5.
//

#ifndef BLBlockDefine_h
#define BLBlockDefine_h

/**
 block
 */
typedef void (^Block)(void);

typedef void (^BlockArray)(NSArray *arr);

typedef void (^BlockResult)(NSDictionary *dict);

typedef void (^BlockString)(NSString *string);

typedef void (^BlockInteger)(NSInteger index);

typedef void (^BlockCGFloat)(CGFloat value);

typedef void (^BlockTowCGFloat)(CGFloat value1, CGFloat value2);

typedef void (^BlockBool)(BOOL key);

typedef void (^BlockLong)(long value);

typedef void (^BlockKeyValue)(NSString *key, NSString *value);
typedef void (^BlockTwoValue)(NSString *value1, NSString *value2);


typedef void (^BlockIntegerAndArray)(NSInteger index, NSArray *value);

typedef void (^BlockObject)(id object);




#endif /* BLBlockDefine_h */
