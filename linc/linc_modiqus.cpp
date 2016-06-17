#include "./linc_modiqus.h"

#include <hxcpp.h>

mq::S32 mq::dbgLevel = MQ_LOG_LEVEL_DEBUG;

namespace linc 
{
    namespace modiqus 
    {
    	mq::mqCsoundWrapper* _csound;

	    mq::mqCsoundWrapper* csound() 
	    {        	
        	if (_csound == NULL)
        	{
				_csound = new mq::mqCsoundWrapper();
        	}

            return _csound; 
        }

        void start() 
        {
        	// bool blah = csound()->start();

            if (!csound()->start())
            {
                MQ_LOG_FATAL("Modiqus engine failed initialization")
                csound()->stop();
                exit(EXIT_FAILURE);
            }
            else
            {
                // MQ_LOG_INFO( "Modiqus engine initialized")
            }

            csound()->sendMessage("i1 0 1");

            while(1);
        }

        void stop()
        {
            csound()->stop();
        }
    }
}
