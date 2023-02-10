/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of /Users/rudimar.ronsoni.jr/src/Dell-XPS-9350-MacOS/ACPI/BIOS 1.13/TB-Off/FPDT-1.aml, Sun Feb  5 16:01:35 2023
 *
 * ACPI Data Table [FPDT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "FPDT"    [Firmware Performance Data Table]
[004h 0004   4]                 Table Length : 00000044
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : B3
[00Ah 0010   6]                       Oem ID : "DELL  "
[010h 0016   8]                 Oem Table ID : "CBX3   "
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 00010013


[024h 0036   2]                Subtable Type : 0001
[026h 0038   1]                       Length : 10
[027h 0039   1]                     Revision : 01
[028h 0040   4]                     Reserved : 00000000
[02Ch 0044   8]          S3PT Record Address : 00000000722C7730

[034h 0052   2]                Subtable Type : 0000
[036h 0054   1]                       Length : 10
[037h 0055   1]                     Revision : 01
[038h 0056   4]                     Reserved : 00000000
[03Ch 0060   8]     FPDT Boot Record Address : 00000000722C7750

Raw Table Data: Length 68 (0x44)

    0000: 46 50 44 54 44 00 00 00 01 B3 44 45 4C 4C 20 20  // FPDTD.....DELL  
    0010: 43 42 58 33 20 20 20 00 09 20 07 01 41 4D 49 20  // CBX3   .. ..AMI 
    0020: 13 00 01 00 01 00 10 01 00 00 00 00 30 77 2C 72  // ............0w,r
    0030: 00 00 00 00 00 00 10 01 00 00 00 00 50 77 2C 72  // ............Pw,r
    0040: 00 00 00 00                                      // ....
