class Test 
{   
    static function main() 
    {
        modiqus.Modiqus.start(false);
		// modiqus.Modiqus.test();

		modiqus.Modiqus.setControlChannel('1.000001.NoteAmplitude', 0.9);
		modiqus.Modiqus.setControlChannel('1.000002.NoteAmplitude', 0.9);
		modiqus.Modiqus.setControlChannel('1.000003.NoteAmplitude', 0.9);

        modiqus.Modiqus.sendMessage("i1.000001 0 1 0.5 261.63");
		modiqus.Modiqus.sendMessage("i1.000002 0 1 0.5 293.66");        
		modiqus.Modiqus.sendMessage("i1.000003 0 1 0.5 329.63");

        while(true) {};


        
        modiqus.Modiqus.stop();
    }
}
