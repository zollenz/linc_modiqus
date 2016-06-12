#include "./linc_modiqus.h"

#include <hxcpp.h>

mq::S32 mq::dbgLevel = MQ_LOG_LEVEL_DEBUG;

namespace linc 
{
    namespace modiqus 
    {
    	mq::mqCore* _core;

	    mq::mqCore* core() 
	    {        	
        	if (_core == NULL)
        	{
				_core = new mq::mqCore();
        	}

            return _core; 
        }

        void start() 
        {

        	core()->Start(mq::ENGINE_MODE_GAME);
			core()->getCsoundWrapper()->setChannelControlInput(1.0f, "2.000100.NoteAmplitude");
			core()->getCsoundWrapper()->setChannelControlInput(1.0f, "2.000100.GrainDensity");        	
        }
    }
}
