/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of RSDT.aml, Sat Jan 21 09:44:36 2023
 *
 * ACPI Data Table [RSDT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "RSDT"    [Root System Description Table]
[004h 0004   4]                 Table Length : 00000084
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : E2
[00Ah 0010   6]                       Oem ID : "DELL  "
[010h 0016   8]                 Oem Table ID : "CBX3   "
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "MSFT"
[020h 0032   4]        Asl Compiler Revision : 00010013

[024h 0036   4]       ACPI Table Address   0 : 713E51A0
[028h 0040   4]       ACPI Table Address   1 : 714062B0
[02Ch 0044   4]       ACPI Table Address   2 : 71406338
[030h 0048   4]       ACPI Table Address   3 : 71406380
[034h 0052   4]       ACPI Table Address   4 : 71406420
[038h 0056   4]       ACPI Table Address   5 : 71406460
[03Ch 0060   4]       ACPI Table Address   6 : 71406498
[040h 0064   4]       ACPI Table Address   7 : 714067B0
[044h 0068   4]       ACPI Table Address   8 : 71406848
[048h 0072   4]       ACPI Table Address   9 : 71406A90
[04Ch 0076   4]       ACPI Table Address  10 : 71409640
[050h 0080   4]       ACPI Table Address  11 : 7140A228
[054h 0084   4]       ACPI Table Address  12 : 7140A260
[058h 0088   4]       ACPI Table Address  13 : 7140A2B8
[05Ch 0092   4]       ACPI Table Address  14 : 7140A9F0
[060h 0096   4]       ACPI Table Address  15 : 7140AA18
[064h 0100   4]       ACPI Table Address  16 : 7140DFC8
[068h 0104   4]       ACPI Table Address  17 : 7140E010
[06Ch 0108   4]       ACPI Table Address  18 : 7140EE88
[070h 0112   4]       ACPI Table Address  19 : 714129E0
[074h 0116   4]       ACPI Table Address  20 : 71412A38
[078h 0120   4]       ACPI Table Address  21 : 71412BB0
[07Ch 0124   4]       ACPI Table Address  22 : 71412CA0
[080h 0128   4]       ACPI Table Address  23 : 71412D48

Raw Table Data: Length 132 (0x84)

    0000: 52 53 44 54 84 00 00 00 01 E2 44 45 4C 4C 20 20  // RSDT......DELL  
    0010: 43 42 58 33 20 20 20 00 09 20 07 01 4D 53 46 54  // CBX3   .. ..MSFT
    0020: 13 00 01 00 A0 51 3E 71 B0 62 40 71 38 63 40 71  // .....Q>q.b@q8c@q
    0030: 80 63 40 71 20 64 40 71 60 64 40 71 98 64 40 71  // .c@q d@q`d@q.d@q
    0040: B0 67 40 71 48 68 40 71 90 6A 40 71 40 96 40 71  // .g@qHh@q.j@q@.@q
    0050: 28 A2 40 71 60 A2 40 71 B8 A2 40 71 F0 A9 40 71  // (.@q`.@q..@q..@q
    0060: 18 AA 40 71 C8 DF 40 71 10 E0 40 71 88 EE 40 71  // ..@q..@q..@q..@q
    0070: E0 29 41 71 38 2A 41 71 B0 2B 41 71 A0 2C 41 71  // .)Aq8*Aq.+Aq.,Aq
    0080: 48 2D 41 71                                      // H-Aq
