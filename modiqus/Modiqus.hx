package modiqus;

@:keep
@:include('linc_modiqus.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('modiqus'))
#end
extern class Modiqus 
{
    //external native function definition
    //can be wrapped in linc::libname or call directly
    //and the header for the lib included in linc_modiqus.h

    @:native('linc::modiqus::set_log_level')
    static function set_log_level(level:LogLevel) : Void;

    @:native('linc::modiqus::start')
    static function start(bundle:Bool) : Int;

    @:native('linc::modiqus::stop')
    static function stop() : Void;

    @:native('linc::modiqus::test')
    static function test() : Void;

    @:native('linc::modiqus::sendMessage')
    static function sendMessage(message:String) : Void;

    @:native('linc::modiqus::setControlChannel')
    static function setControlChannel(channel:String, value:Float) : Void;

    //inline functions can be used as wrappers
    //and can be useful to juggle haxe typing to or from the c++ extern

    static inline function inline_start() : Int 
    {
        return untyped __cpp__('linc::modiqus::start()');
    }

    @:native('linc::modiqus::example')
    private static function _internal_start() : Int;

    static inline function other_inline_start() : Int 
    {
        return _internal_start();
    }
}

@:enum
abstract LogLevel(Int)
from Int to Int 
{
    var MQ_LOG_LEVEL_MUTE   = 1;
    var MQ_LOG_LEVEL_FATAL  = 2;
    var MQ_LOG_LEVEL_ERROR  = 3;
    var MQ_LOG_LEVEL_WARN   = 4;
    var MQ_LOG_LEVEL_INFO   = 5;
    var MQ_LOG_LEVEL_DEBUG  = 6;
}

