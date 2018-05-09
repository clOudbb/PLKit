//
//  PLKitDefine.h
//  PLKit
//
//  Created by qmtv on 2018/5/3.
//  Copyright © 2018年 clOud. All rights reserved.
//

#ifndef PLKitDefine_h
#define PLKitDefine_h



#define IGNORE_WARNING_PUSH clang diagnostic push
#define IGNORE_WARNING_IGNORED(__v) clang diagnostic ignored (__v)
#define IGNORE_WARNING_POP clang diagnostic pop

static char * const kIGNORE_Wobjc_protocol_property_synthesis = "-Wobjc-protocol-property-synthesis";

#pragma mark - valid 
static inline bool pl_validString(NSString *str)
{
    return (str && [str isKindOfClass:[NSString class]] && ![str isEqualToString:@""] && str.length > 0);
}

static inline bool pl_validArray(NSArray *arr)
{
    return (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0);
}

static inline bool pl_validDictionary(NSDictionary *dic)
{
    return (dic && [dic isKindOfClass:[NSDictionary class]] && dic.allKeys.count > 0);
}

static inline bool pl_validSet(NSSet *set)
{
    return (set && [set isKindOfClass:[NSSet class]] && set.count > 0);
}

#endif /* PLKitDefine_h */
