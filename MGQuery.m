//
//  MGQuery.m
//
//  Created by purplesn0w on 1/3/19.
//  Copyright © 2019 xeriviOS Team. All rights reserved.
//

#import "MGQuery.h"
#import <dlfcn.h>


@implementation MGQuery
id (*MGCopyAnswer)(NSString *question);

const char *MGQueryAnswer (char *Question) {

    void *mgdylib = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_LAZY);
    MGCopyAnswer = dlsym(mgdylib, "MGCopyAnswer");
    NSString *q = [[NSString alloc] initWithCString:Question encoding:NSUTF8StringEncoding];
    id answer = MGCopyAnswer(q);
    
    if (!answer)
    {
        return(NULL);
    }
    const char *out = NULL;
 //   printf(object_getClassName(answer));
        if (strcmp(object_getClassName(answer), "__NSCFString")==0)
    {
     //   printf("strin");

        out = [answer cStringUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (strcmp(object_getClassName(answer), "__NSCFBoolean")==0)
    {
      //  printf("b00l");

    NSNumber *ian = answer;
    
    if (ian == kCFBooleanTrue) {
        NSString *ian2 = [[NSString alloc] initWithString:@"true"];
                    out = [ian2 cStringUsingEncoding:NSUTF8StringEncoding];

    }
    if (ian == kCFBooleanFalse) {
NSString *ian2 = [[NSString alloc] initWithString:@"false"];
                    out = [ian2 cStringUsingEncoding:NSUTF8StringEncoding];    }
   

    }
    if (strcmp(object_getClassName(answer), "__NSCFArray")==0)
    {
       // printf("NSArrayData");

            NSString *ian2 = [[NSString alloc] initWithString:[answer description]];
   
            out = [ian2 cStringUsingEncoding:NSUTF8StringEncoding];

    }
    if (strcmp(object_getClassName(answer), "__NSCFDictionary")==0)
    {
       // printf("Dict");

         NSString *ian2 = [[NSString alloc] initWithString:[answer description]];
   
            out = [ian2 cStringUsingEncoding:NSUTF8StringEncoding];


        
        
    } // dict
    if (strcmp(object_getClassName(answer), "__NSCFNumber")==0)
    {
       // printf("Number");

            NSNumber *ian = answer;
            NSString *ian2 = [[NSString alloc] initWithString:ian.stringValue];
   
            out = [ian2 cStringUsingEncoding:NSUTF8StringEncoding];
        

        
    }
    if (strcmp(object_getClassName(answer), "__NSCFData")==0)
    {
        NSMutableString *outputstring = [[NSMutableString alloc] init];
        NSUInteger size = [answer length] / sizeof(unsigned char);
        unsigned char* array = (unsigned char*) [answer bytes];
       char buf[size];
        for(int i=0; i<strlen(array); i++, array++) {
            [outputstring appendString:@" "];
                        sprintf(buf,"%02X", array[i]);

            [outputstring appendString: [[NSString alloc] initWithCString:buf encoding:NSUTF8StringEncoding]];
            
    }
    out = [outputstring cStringUsingEncoding:NSUTF8StringEncoding];
    }

	if (out == NULL) {
	out =  object_getClassName(answer);
}
        return(out);

}
@end
