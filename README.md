# Golang package structure performance test

This benchmark compares linear vs nested Go package structures to measure their impact on build performance. Tests run on AMD Ryzen 7 9800X3D with 60GB RAM.

### Structure Example

```
liniear/
  files/
    file_1/
      file_1.go
    file_2/
      file_2.go
    file_3/
      file_3.go
    ...
    file_1000/
      file_1000.go
  go.mod
  main.go
```
vs
```
nested/
  n/
    f1.go
    f2/
      f2.go
      f3/
        f3.go
        ...
        f800/
        f800.go
  go.mod
  main.go
```

### Key Results: 

| Package Structure | Build Time (no cache) | Build Time (cached) | Runtime  |
|-------------------|------------------------|---------------------|----------|
| Linear            | ~1.09s                 | ~0.07s              | ~0.001s  |
| Nested            | ~9.5s                  | ~2.6s               | ~0.001s  |


### Performance Impact:

- Nested packages are \~8.7x slower to build from scratch
- Nested packages are \~37x slower with cache
- Runtime performance is identical (~1ms for both)
- Caching provides significant benefits for both structures, but linear packages benefit more

### Bottom Line:
Linear package structures offer dramatically better build times with minimal impact on runtime performance. If build speed is important for your development workflow, prefer flatter package hierarchies over deeply nested ones.


## Installation
```
git clone https://github.com/enheit/golang-package-structure-performance.git
cd golang-package-structure-performance
```

## Linear package structure test
```
cd linear

chmod +x generate_linear_packages.sh
./generate_linear_packages.sh

time go build main.go
go clean -cache

time go run main.go
go clean -cache

time ./main.go
```

### Linear results

```
➜  linear git:(main) ✗ go clean -cache
linear git:(main) ✗ time go build main.go
go build main.go  3.20s user 0.90s system 376% cpu 1.091 total
➜  linear git:(main) ✗ time go build main.go
go build main.go  0.09s user 0.04s system 185% cpu 0.070 total
➜  linear git:(main) ✗ time go build main.go
go build main.go  0.08s user 0.05s system 191% cpu 0.069 total
➜  linear git:(main) ✗ time go build main.go
go build main.go  0.09s user 0.04s system 171% cpu 0.076 total
➜  linear git:(main) ✗ time go build main.go
go build main.go  0.09s user 0.04s system 183% cpu 0.071 total
➜  linear git:(main) ✗ go clean -cache
➜  linear git:(main) ✗ time go run main.go
go run main.go  3.18s user 0.90s system 374% cpu 1.087 total
➜  linear git:(main) ✗ time go run main.go
go run main.go  0.08s user 0.05s system 173% cpu 0.078 total
➜  linear git:(main) ✗ time go run main.go
go run main.go  0.09s user 0.04s system 172% cpu 0.076 total
➜  linear git:(main) ✗ time go run main.go
go run main.go  0.08s user 0.05s system 199% cpu 0.065 total
➜  linear git:(main) ✗ time go run main.go
go run main.go  0.09s user 0.04s system 174% cpu 0.075 total
➜  linear git:(main) ✗ time ./main
./main  0.00s user 0.00s system 94% cpu 0.001 total
➜  linear git:(main) ✗ time ./main
./main  0.00s user 0.00s system 91% cpu 0.001 total
➜  linear git:(main) ✗ time ./main
./main  0.00s user 0.00s system 90% cpu 0.001 total
➜  linear git:(main) ✗ time ./main
./main  0.00s user 0.00s system 93% cpu 0.001 total
➜  linear git:(main) ✗ time ./main
./main  0.00s user 0.00s system 95% cpu 0.001 total
```

## Nested package structure test
```
cd nested

chmod +x generate_nested_packages.sh
./generate_nested_packages.sh

time go build main.go
go clean -cache

time go run main.go
go clean -cache

time ./main.go
```

### Nested results
```
➜  nested git:(main) ✗ go clean -cache
➜  nested git:(main) ✗ time go build main.go
go build main.go  9.21s user 2.80s system 126% cpu 9.506 total
➜  nested git:(main) ✗ time go build main.go
go build main.go  1.70s user 1.49s system 123% cpu 2.595 total
➜  nested git:(main) ✗ time go build main.go
go build main.go  1.73s user 1.46s system 124% cpu 2.564 total
➜  nested git:(main) ✗ time go build main.go
go build main.go  1.75s user 1.46s system 124% cpu 2.580 total
➜  nested git:(main) ✗ time go build main.go
go build main.go  1.70s user 1.49s system 124% cpu 2.571 total
➜  nested git:(main) ✗ go clean -cache
➜  nested git:(main) ✗ time go run main.go
go run main.go  9.02s user 2.91s system 126% cpu 9.465 total
➜  nested git:(main) ✗ time go run main.go
go run main.go  1.67s user 1.51s system 122% cpu 2.587 total
➜  nested git:(main) ✗ time go run main.go
go run main.go  1.69s user 1.48s system 123% cpu 2.574 total
➜  nested git:(main) ✗ time go run main.go
go run main.go  1.67s user 1.44s system 121% cpu 2.559 total
➜  nested git:(main) ✗ time go run main.go
go run main.go  1.73s user 1.46s system 124% cpu 2.568 total
➜  nested git:(main) ✗ time ./main
./main  0.00s user 0.00s system 93% cpu 0.001 total
➜  nested git:(main) ✗ time ./main
./main  0.00s user 0.00s system 90% cpu 0.001 total
➜  nested git:(main) ✗ time ./main
./main  0.00s user 0.00s system 103% cpu 0.001 total
➜  nested git:(main) ✗ time ./main
./main  0.00s user 0.00s system 89% cpu 0.001 total
➜  nested git:(main) ✗ time ./main
./main  0.00s user 0.00s system 95% cpu 0.001 total
```

## Hardware specification

### CPU

```
➜  ~ lscpu

Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             48 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      8
  On-line CPU(s) list:       0-7
Vendor ID:                   AuthenticAMD
  Model name:                AMD Ryzen 7 9800X3D 8-Core Processor
    CPU family:              26
    Model:                   68
    Thread(s) per core:      1
    Core(s) per socket:      8
    Socket(s):               1
    Stepping:                0
    Frequency boost:         enabled
    CPU(s) scaling MHz:      68%
    CPU max MHz:             5271.6221
    CPU min MHz:             603.3790
    BogoMIPS:                9399.98
    Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat ps
                             e36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
                             rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_ts
                             c cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma
                             cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cm
                             p_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
                             osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfct
                             r_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ib
                             pb stibp ibrs_enhanced vmmcall fsgsbase tsc_adjust bmi1 avx2 smep bm
                             i2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx smap avx512ifm
                             a clflushopt clwb avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec
                             xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local use
                             r_shstk avx_vnni avx512_bf16 clzero irperf xsaveerptr rdpru wbnoinvd
                              cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbya
                             sid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif
                             x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni
                             vaes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid bus
                             _lock_detect movdiri movdir64b overflow_recov succor smca fsrm avx51
                             2_vp2intersect flush_l1d amd_lbr_pmc_freeze
Virtualization features:
  Virtualization:            AMD-V
Caches (sum of all):
  L1d:                       384 KiB (8 instances)
  L1i:                       256 KiB (8 instances)
  L2:                        8 MiB (8 instances)
  L3:                        96 MiB (1 instance)
NUMA:
  NUMA node(s):              1
  NUMA node0 CPU(s):         0-7
Vulnerabilities:
  Gather data sampling:      Not affected
  Ghostwrite:                Not affected
  Indirect target selection: Not affected
  Itlb multihit:             Not affected
  L1tf:                      Not affected
  Mds:                       Not affected
  Meltdown:                  Not affected
  Mmio stale data:           Not affected
  Reg file data sampling:    Not affected
  Retbleed:                  Not affected
  Spec rstack overflow:      Mitigation; IBPB on VMEXIT only
  Spec store bypass:         Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:                Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:                Mitigation; Enhanced / Automatic IBRS; IBPB conditional; STIBP disab
                             led; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                     Not affected
  Tsa:                       Not affected
  Tsx async abort:           Not affected
```
### RAM
```
➜  ~ free -h
               total        used        free      shared  buff/cache   available
Mem:            60Gi        10Gi        41Gi       174Mi       9.5Gi        50Gi
Swap:          4.0Gi          0B       4.0Gi
```

```
➜  ~ cat /proc/meminfo

MemTotal:       63315876 kB
MemFree:        43484992 kB
MemAvailable:   52526372 kB
Buffers:          107096 kB
Cached:          9197744 kB
SwapCached:            0 kB
Active:         11177880 kB
Inactive:        7053900 kB
Active(anon):    9098712 kB
Inactive(anon):     6280 kB
Active(file):    2079168 kB
Inactive(file):  7047620 kB
Unevictable:         108 kB
Mlocked:               0 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Zswap:                 0 kB
Zswapped:              0 kB
Dirty:              2552 kB
Writeback:             0 kB
AnonPages:       8736128 kB
Mapped:          1835704 kB
Shmem:            178356 kB
KReclaimable:     625076 kB
Slab:             864624 kB
SReclaimable:     625076 kB
SUnreclaim:       239548 kB
KernelStack:       35264 kB
PageTables:       101220 kB
SecPageTables:      5712 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    35852236 kB
Committed_AS:   22262448 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      294712 kB
VmallocChunk:          0 kB
Percpu:             9344 kB
HardwareCorrupted:     0 kB
AnonHugePages:   1638400 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:    827392 kB
FilePmdMapped:    622592 kB
CmaTotal:              0 kB
CmaFree:               0 kB
Unaccepted:            0 kB
Balloon:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:     3854072 kB
DirectMap2M:    31332352 kB
DirectMap1G:    30408704 kB
```

## Possible issue
There may be an issue with the folder 386 in the linear output structure. Just delete that folder and remove the related call from the main function.
