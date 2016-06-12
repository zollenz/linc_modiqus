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
ksmps = 32 
nchnls = 2 
0dbfs  = 1

; GLOBALS
#include "Globals.orc"

; TURNOFF (INSTRUMENT 1)
#include "Turnoff.orc"

; GRAIN SYNTHESIZER (INSTRUMENT 2)
#include "GrainSynth.orc"

; SAMPLE PLAYER (INSTRUMENT 3)
#include "SamplePlayer.orc"

; I-RATE INSTANCE CHECKER (INSTRUMENT 4)
;#include "CheckActiveI.orc"

; K-RATE INSTANCE CHECKER (INSTRUMENT 5)
;#include "CheckActiveK.orc"

; TABLE MORPHER (INSTRUMENT 6)
;#include "TableMorph.orc"

; TABLE PRINTER (INSTRUMENT 7)
;#include "PrintTable.orc"

; SINE (INSTRUMENT 1000)
#include "Sine.orc"

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>