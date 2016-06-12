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

    @:native('linc::modiqus::start')
    static function start() : Int;

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
