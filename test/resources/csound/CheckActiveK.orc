instr 5
; k-time instance monitor
k_Active active p4, 0

chnset k_Active, "InstanceMonitor"

printks "Active instances of instrument %d: %d\n", p4, k_Active

endin