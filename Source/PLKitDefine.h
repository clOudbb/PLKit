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

#define PLKIT_IGNORE_declarations(__v) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"" )\
(__v); \
_Pragma("clang diagnostic pop") \


#ifdef DEBUG
#define PLAssert(__condition, __desc)  NSAssert(__condition, __desc)
#endif

#ifdef DEBUG
#define PLLog(...) NSLog(__VA_ARGS__)
#define PLLOG(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define PLLog(...) {}
#define PLLOG(format, ...) {}
#endif // #ifdef DEBUG

static char * const kIGNORE_Wobjc_protocol_property_synthesis = "-Wobjc-protocol-property-synthesis";


#endif /* PLKitDefine_h */
