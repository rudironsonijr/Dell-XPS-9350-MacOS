/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of LPIT-1.aml, Sat Jan 21 09:44:36 2023
 *
 * ACPI Data Table [LPIT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "LPIT"    [Low Power Idle Table]
[004h 0004   4]                 Table Length : 00000094
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : FE
[00Ah 0010   6]                       Oem ID : "INTEL "
[010h 0016   8]                 Oem Table ID : "SKL-ULT"
[018h 0024   4]                 Oem Revision : 00000000
[01Ch 0028   4]              Asl Compiler ID : "MSFT"
[020h 0032   4]        Asl Compiler Revision : 0000005F

[024h 0036   4]                Subtable Type : 00000000 [Native C-state Idle Structure]
[028h 0040   4]                       Length : 00000038
[02Ch 0044   2]                    Unique ID : 0000
[02Eh 0046   2]                     Reserved : 0000
[030h 0048   4]        Flags (decoded below) : 00000000
                              State Disabled : 0
                                  No Counter : 0

[034h 0052  12]                Entry Trigger : [Generic Address Structure]
[034h 0052   1]                     Space ID : 7F [FunctionalFixedHW]
[035h 0053   1]                    Bit Width : 01
[036h 0054   1]                   Bit Offset : 02
[037h 0055   1]         Encoded Access Width : 00 [Undefined/Legacy]
[038h 0056   8]                      Address : 0000000000000060

[040h 0064   4]                    Residency : 00007530
[044h 0068   4]                      Latency : 00000BB8
[048h 0072  12]            Residency Counter : [Generic Address Structure]
[048h 0072   1]                     Space ID : 7F [FunctionalFixedHW]
[049h 0073   1]                    Bit Width : 40
[04Ah 0074   1]                   Bit Offset : 00
[04Bh 0075   1]         Encoded Access Width : 00 [Undefined/Legacy]
[04Ch 0076   8]                      Address : 0000000000000632

[054h 0084   8]            Counter Frequency : 0000000000000000

[05Ch 0092   4]                Subtable Type : 00000000 [Native C-state Idle Structure]
[060h 0096   4]                       Length : 00000038
[064h 0100   2]                    Unique ID : 0001
[066h 0102   2]                     Reserved : 0000
[068h 0104   4]        Flags (decoded below) : 00000000
                              State Disabled : 0
                                  No Counter : 0

[06Ch 0108  12]                Entry Trigger : [Generic Address Structure]
[06Ch 0108   1]                     Space ID : 7F [FunctionalFixedHW]
[06Dh 0109   1]                    Bit Width : 01
[06Eh 0110   1]                   Bit Offset : 02
[06Fh 0111   1]         Encoded Access Width : 00 [Undefined/Legacy]
[070h 0112   8]                      Address : 0000000000000060

[078h 0120   4]                    Residency : 00007530
[07Ch 0124   4]                      Latency : 00000BB8
[080h 0128  12]            Residency Counter : [Generic Address Structure]
[080h 0128   1]                     Space ID : 7F [FunctionalFixedHW]
[081h 0129   1]                    Bit Width : 40
[082h 0130   1]                   Bit Offset : 00
[083h 0131   1]         Encoded Access Width : 00 [Undefined/Legacy]
[084h 0132   8]                      Address : 0000000000000632

[08Ch 0140   8]            Counter Frequency : 0000000000000000


Raw Table Data: Length 148 (0x94)

    0000: 4C 50 49 54 94 00 00 00 01 FE 49 4E 54 45 4C 20  // LPIT......INTEL 
    0010: 53 4B 4C 2D 55 4C 54 00 00 00 00 00 4D 53 46 54  // SKL-ULT.....MSFT
    0020: 5F 00 00 00 00 00 00 00 38 00 00 00 00 00 00 00  // _.......8.......
    0030: 00 00 00 00 7F 01 02 00 60 00 00 00 00 00 00 00  // ........`.......
    0040: 30 75 00 00 B8 0B 00 00 7F 40 00 00 32 06 00 00  // 0u.......@..2...
    0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0060: 38 00 00 00 01 00 00 00 00 00 00 00 7F 01 02 00  // 8...............
    0070: 60 00 00 00 00 00 00 00 30 75 00 00 B8 0B 00 00  // `.......0u......
    0080: 7F 40 00 00 32 06 00 00 00 00 00 00 00 00 00 00  // .@..2...........
    0090: 00 00 00 00                                      // ....
