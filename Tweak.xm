#import "ThirdLoginModel.h"

@interface AVUser : NSObject

+(id)currentUser;
-(void)updateValue:(id)arg1 forKey:(id)arg2 ;
@end

typedef void(^callBackType)(NSDictionary *, ThirdLoginModel *,NSDictionary *);

//%hook XTGithubLoginViewController
//
//-(NSDictionary *)onAuthCompleted:(id)arg1 {
//  HBLogInfo(@"%s", __func__);
//  NSDictionary *result = %orig;
//  NSMutableDictionary *dict = [result mutableCopy];
//  for (NSString *key in result.allKeys) {
//    if ([result[key] isKindOfClass:[NSNull class]]) {
//      HBLogInfo(@"%s key: %@", __func__, key);
//      [dict removeObjectForKey:key];
//    }
//  }
//  HBLogInfo(@"result: %@", dict);
//  return dict;
//}
//
//-(callBackType)callBack {
//  callBackType block = ^(NSDictionary *dic1, ThirdLoginModel *model, NSDictionary *dic2) {
//    HBLogInfo(@"dic1: %@, model: %@, dic2: %@", dic1, [model debugDescription], dic2);
//  };
//  return block;
//}
//%end // end hook

%hook AVUser
+(id)currentUser {
  AVUser *user = %orig;
  id descri = [user valueForKey: @"self_description"];
  if ([descri isKindOfClass: [NSNull class]]) {
    HBLogWarn(@"the value for key: self_description is null");
    [user updateValue: @"" forKey: @"self_description"];
  }
  return user;
}

%end
