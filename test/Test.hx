class Test 
{   
    static function main() 
    {
        modiqus.Modiqus.start(false);
		// modiqus.Modiqus.test();
        modiqus.Modiqus.sendMessage("i1 0 1 0.5 261.63");
		modiqus.Modiqus.sendMessage("i1 0 1 0.5 293.66");        
		modiqus.Modiqus.sendMessage("i1 0 1 0.5 329.63");

        while(true) {};
        
        modiqus.Modiqus.stop();
    }
}
