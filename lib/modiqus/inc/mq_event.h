/* 
 * Copyright (C) 2015 by Martin Dejean
 *
 * This file is part of Modiqus.
 * Modiqus is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Modiqus is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Modiqus.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef __MQ_EVENT_H__
#define __MQ_EVENT_H__

#include "mq_types.h"

// Implementation taken from: http://www.codeproject.com/Articles/35230/Observer-Pattern-as-C-Component

namespace mq
{
    template<typename SourceType, typename EventArgType>
    class Event
    {
        
    protected:
        
        /*
         * Event handler function pointer definition
         * source 		- Subject - the object which fired the event.
         * eventArg 	- The event argument
         * context		- Context information, which a subscriber needs to get with an event notification
         * 					Usually, this can be a pointer to the subscriber object itself.
         */
        typedef void (*EventHandler)(SourceType *source, EventArgType eventArg, void *context);
        
        /*
         * This inner class, for each EventHandler, stores the associated context information -
         * pointer. This context pointer can be used to pass additional informations
         * from the point of subscription to the event handler function.
         * The best use of context pointer is to use the "this" pointer of subscriber itself.
         */
        class SubscriberRecord
        {
            
        private:
            
            EventHandler _handlerProc; // The event handler function pointer
            void* _handlerContext; // pointer to context information
            
            SubscriberRecord(EventHandler handler, void *context = 0) :
            _handlerProc(handler), _handlerContext(context) {}
            
            friend class Event;
        };
        
    protected:
        
        std::vector<SubscriberRecord> _subscribers;
        SourceType* _eventSource;
        
    public:
        
        /*
         * Constructor - sets the Event source
         */
        Event(SourceType* source) : _eventSource(source) {}
        
        /*
         * Virtual destructor - perform clean up if any.
         */
        virtual ~Event() {}
        
        /*
         * Operator used to subscribe a handler C# style event subscription
         */
        void operator +=(EventHandler handler)
        {
            _subscribers.push_back(SubscriberRecord(handler));
        }
        
        /*
         * Operator used to unsubscribe a handler C# style event subscription
         */
        void operator -=(EventHandler handler)
        {
            typename std::vector<SubscriberRecord>::iterator itr = find(_subscribers.begin(),
                                                                        _subscribers.end(), SubscriberRecord(handler));
            if (itr != _subscribers.end())
            {
                _subscribers.erase(itr);
            }
        }
        
        /*
         * Function used to subscribe a handler with optional context information
         */
        void Subscribe(EventHandler handler, void* context = 0)
        {
            _subscribers.push_back(SubscriberRecord(handler, context));
        }
        
        /*
         * Function used to unsubscribe a handler with optional context information
         */
        void Unsubscribe(EventHandler handler, void* context = 0)
        {
            typename std::vector<SubscriberRecord>::iterator itr = find(_subscribers.begin(),
                                                                        _subscribers.end(), SubscriberRecord(handler, context));
            if (itr != _subscribers.end())
            {
                _subscribers.erase(itr);
            }
        }
        
        /*
         * Fire the event and notify all observers with event argument, -
         * source and context information if any provided.
         */
        void FireEvent(EventArgType eventArg)
        {
            for (U32 i = 0; i < _subscribers.size(); i++)
            {
                _subscribers[i]._handlerProc(_eventSource, eventArg, _subscribers[i]._handlerContext);
            }
        }
        
    };
}

#endif //__MQ_EVENT_H__
