/*****************/
/* Sample player */
/*****************/

instr 3

iFt = giDefSample

if (p4 != 0) then
    iFt = p4
endif

i_Freq  = sr / ftlen(iFt)

a_sig loscil .8, 1, iFt, 1
			
outs a_sig, a_sig

endin
