#ifndef _LINC_MODIQUS_H_
#define _LINC_MODIQUS_H_
    
#include "../lib/modiqus/inc/modiqus.h"

#include <hxcpp.h>

namespace linc 
{
    namespace modiqus 
    {
        extern void start(bool bundle);
        extern void stop();
        extern void test();
        extern void sendMessage(const char* message);     
    }
}

#endif //_LINC_MODIQUS_H_
