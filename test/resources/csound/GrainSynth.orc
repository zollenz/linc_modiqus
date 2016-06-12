/************************/
/* Partikkel instrument */
/************************/

instr 2

; p1 - instrument #
; p2 - start
; p3 - duration
; p4 - wave table
; p5 - IO channels string prefix
; p6 - note amplitude table
; P7 - grain frequency table
; P8 - grain start
; P9 - grain duration
; P10 - grain spatial position

i_InstanceNumber = p1
i_NoteDuration = p3
i_GrainWaveTab = p4
S_ChnPrefix = p5
i_NoteAmpTab = p6
i_GrainDensTab = p7
i_GrainStart = p8
i_GrainDuration = p9
i_NoteAmpMax = 1
i_GrainDensMax = 500

if (i_GrainWaveTab <= 1) then
    i_GrainWaveTab = giDefSample
endif

if (i_NoteAmpTab <= 1) then
    i_NoteAmpTab = giDefGEN07Tab
    i_NoteAmpScale = p6
endif

if (i_GrainDensTab <= 1) then
    i_GrainDensTab = giDefGEN07Tab
    i_DensScale = p7
endif

i_OriginalFreq  = sr / ftlen(i_GrainWaveTab)
k_NoteAmp oscili i_NoteAmpMax, 1 / i_NoteDuration, i_NoteAmpTab
k_GrainDens oscili i_GrainDensMax, 1 / i_NoteDuration, i_GrainDensTab

S_instance sprintf "%f", i_InstanceNumber

S_NoteAmpChn strcat "", S_instance
S_NoteAmpChn strcat S_NoteAmpChn, ".NoteAmplitude"
S_GrainDensChn strcat "", S_instance
S_GrainDensChn strcat S_GrainDensChn, ".GrainDensity"

;puts S_NoteAmpChn, 1
;puts S_GrainDensChn, 1

;prints "Note duration: %f\n", i_NoteDuration
;prints "Grain wave table: %d\n", i_GrainWaveTab
;S_temp strcat "Channel prefix: ", S_ChnPrefix
;puts S_temp, 1
;prints "Note amplitude table: %d\n", i_NoteAmpTab
;prints "Grain density table: %d\n", i_GrainDensTab
;prints "Grain start: %f\n", i_GrainStart
;prints "Grain duration: %d\n", i_GrainDuration

i_Comparison strcmp S_ChnPrefix, ""

if (i_Comparison == 0) then
    chnset 1, S_NoteAmpChn
    chnset 1, S_GrainDensChn
endif

k_NoteAmpChnVal     chnget S_NoteAmpChn
;k_NoteAmpChnVal     lineto k_NoteAmpChnVal, 0.01

k_grain_density_scale   chnget S_GrainDensChn
;k_grain_density_scale   lineto k_grain_density_scale, 0.01

;;;;;;;;;;;;;;;;;;
;                ;
; INITIALIZATION ;
;                ;
;;;;;;;;;;;;;;;;;;

idisttab = -1
ienv_attack = -1
ienv_decay = -1
ienv2tab = giHamming
icosine = giCosine
igainmasks = -1
ichannelmasks = giDefChnMask
iwavfreqstarttab = -1
iwavfreqendtab = -1
ifmamptab = -1
iwaveamptab = -1
imax_grains = 1000

;;;;;;;;;;;;;;;;;;;;;;;
;                     ;
; PERFORMANCE CONTROL ;
;                     ;
;;;;;;;;;;;;;;;;;;;;;;;

kgrainfreq = 1 + k_grain_density_scale * k_GrainDens
async = 0
kdistribution = 0
kenv2amt = 1
ksustain_amount = 0.5
ka_d_ratio = 0.5
kduration = i_GrainDuration
kamp = 0.5 * 0dbfs
kwavfreq = i_OriginalFreq
ksweepshape = 0
awavfm = 0
kfmenv = -1
kTrainCps = kgrainfreq
knumpartials = 3
kchroma = .8
krandommask = -1
kwaveform1 = i_GrainWaveTab
kwaveform2 = i_GrainWaveTab
kwaveform3 = i_GrainWaveTab
kwaveform4 = i_GrainWaveTab
asamplepos1 = i_GrainStart
asamplepos2 = i_GrainStart
asamplepos3 = i_GrainStart
asamplepos4 = i_GrainStart
kwavekey1 = 1
kwavekey2 = 1
kwavekey3 = 1
kwavekey4 = 1

a_PartikkelOutL,a_PartikkelOutR  partikkel kgrainfreq, \
            kdistribution, idisttab, async, kenv2amt, ienv2tab, ienv_attack, \
            ienv_decay, ksustain_amount, ka_d_ratio, kduration, kamp, igainmasks, \
            kwavfreq, ksweepshape, iwavfreqstarttab, iwavfreqendtab, awavfm, \
            ifmamptab, kfmenv, icosine, kTrainCps, knumpartials, kchroma, \
            ichannelmasks, krandommask, kwaveform1, kwaveform2, kwaveform3, \
            kwaveform4, iwaveamptab, asamplepos1, asamplepos2, asamplepos3, \
            asamplepos4, kwavekey1, kwavekey2, kwavekey3, kwavekey4, imax_grains
a_DryOutR = a_PartikkelOutR * k_NoteAmpChnVal * k_NoteAmp
a_DryOutL = a_PartikkelOutL * k_NoteAmpChnVal * k_NoteAmp

a_FilteredOutR butterhp a_DryOutR, 50
a_FilteredOutL butterhp a_DryOutL, 50

chnmix a_FilteredOutR * .3, "ReverbL"
chnmix a_FilteredOutL * .3, "ReverbR"

outs a_FilteredOutR, a_FilteredOutL
;outs a_PartikkelOutR, a_PartikkelOutL
;outs a_DryOutR, a_DryOutL

endin

;Reverb instrument
instr 100
	a_InL chnget "ReverbL"
	a_InR chnget "ReverbR"
	chnclear "ReverbL"
	chnclear "ReverbR"
	
	a_OutL, a_OutR reverbsc a_InL, a_InR, 0.9, 9000
	
    outs a_OutL, a_OutR
endin
