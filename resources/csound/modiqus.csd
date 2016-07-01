<CsoundSynthesizer>

/***********/
/* Options */
/***********/

<CsOptions>
-o dac -+rtaudio=auhal
</CsOptions>
<CsInstruments>

/*********************/
/* Header statements */
/*********************/

sr = 44100
kr = 4410    
ksmps = 10
nchnls = 2
0dbfs = 1

giSine		ftgen 1, 0, 4096, 10, 1

instr 1

SInstance 	sprintf "%f", p1
SNAmpChn 	strcat "", SInstance
SNAmpChn 	strcat SNAmpChn, ".NoteAmplitude"

puts SNAmpChn, 1

kNAmpChn	chnget SNAmpChn

prints "kNAmpChn: %f\n", kNAmpChn

asound oscili p4, p5, 1
outs asound * kNAmpChn, asound * kNAmpChn
endin

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>