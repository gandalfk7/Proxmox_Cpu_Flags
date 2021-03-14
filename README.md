# Proxmox_Cpu_Flags
trying to find minimum cpu flags common to 2 nodes in a cluster

## Usage:
execute lscpu on your proxmox nodes, and take the output of the line "Flags:", for example:

```
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
```
and save the content without the "Flags:" part in the files:
* host1.txt
* host2.txt

I've used host2.txt with the older cpu but it should be the same

Then execute compare.sh, you should have an output similar to:
```
##############################################
cpu-model: test
    flags +fpu;+vme;+de;+pse;+tsc;+msr;+pae;+mce;+cx8;+apic;+sep;+mtrr;+pge;+mca;+cmov;+pat;+pse36;+clflush;+mmx;+fxsr;+sse;+sse2;+ht;+syscall;+nx;+pdpe1gb;+rdtscp;+lm;+constant_tsc;+rep_good;+nopl;+nonstop_tsc;+cpuid;+aperfmperf;+pni;+pclmulqdq;+monitor;+ssse3;+fma;+cx16;+sse4_1;+sse4_2;+movbe;+popcnt;+aes;+xsave;+avx;+f16c;+rdrand;+lahf_lm;+abm;+3dnowprefetch;+ssbd;+ibpb;+fsgsbase;+bmi1;+avx2;+smep;+bmi2;+rdseed;+adx;+smap;+clflushopt;+xsaveopt;+xsavec;+xgetbv1;+xsaves;+arat
    phys-bits host
    hidden 0
    hv-vendor-id proxmox
    reported-model kvm64
##############################################
```

this should be inserted on your proxmox node (one is enough) in the file: /etc/pve/virtual-guest/cpu-models.conf

## Nota bene:
right now it's not working as intended (I'm posting on r/proxmox to ask for help)
