#include "./linc_modiqus.h"

#include <hxcpp.h>

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

        void set_log_level(int level) 
        {   
            csound()->set_log_level(level);
        }

        void start(bool bundle) 
        {
            if (!csound()->start(bundle))
            {
                MQ_LOG_FATAL("Modiqus engine failed initialization")
                csound()->stop();
                exit(EXIT_FAILURE);
            }
            else
            {
                MQ_LOG_INFO( "Modiqus engine initialized")
            }
        }

        void stop()
        {
            csound()->stop();
        }

        void test()
        {
            csound()->sendMessage("i1 0 1 0.5 440");
        }

        void sendMessage(const char* message)
        {
            csound()->sendMessage(message); 
        }

        void setControlChannel(const char* channel, float value)
        {
            csound()->setChannelControlInput(value, channel);
        }
    }
}
