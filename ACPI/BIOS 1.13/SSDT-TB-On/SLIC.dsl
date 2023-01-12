/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of /Users/rudironsonijr/Desktop/Dell XPS 9350/SSDT_OEM/SLIC.aml, Wed Jan 11 10:29:35 2023
 *
 * ACPI Data Table [SLIC]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "SLIC"    [Software Licensing Description Table]
[004h 0004   4]                 Table Length : 00000176
[008h 0008   1]                     Revision : 03
[009h 0009   1]                     Checksum : 6A
[00Ah 0010   6]                       Oem ID : "DELL  "
[010h 0016   8]                 Oem Table ID : "CBX3   "
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "MSFT"
[020h 0032   4]        Asl Compiler Revision : 00010013

[024h 0036 338] Software Licensing Structure : \
    00 00 00 00 9C 00 00 00 06 02 00 00 00 24 00 00 \
    52 53 41 31 00 04 00 00 01 00 01 00 7F F6 C1 05 \
    BE 5C 57 63 A5 8A 68 F3 6E 8F 06 FA AF B4 9F 68 \
    82 23 EC 50 40 5A 73 7F EC E4 07 CB DC 25 1A 9C \
    E3 E3 66 11 E0 A5 98 06 C5 80 0A FA 42 93 86 98 \
    E7 D5 1B D4 D7 3A A4 0B EE E2 7D BE 5F 5B 15 0C \
    AB D0 21 DE BF E9 B5 6E A4 57 B9 8C 0C D2 BA 3A \
    69 30 76 94 71 A2 64 D7 4C D8 85 BF DF A5 6A C8 \
    DC 45 D5 4D 8C B8 8C 05 2F FC 2E 23 C4 29 C5 6F \
    3F 29 6C 6D 57 79 0E B6 75 ED 21 95 01 00 00 00 \
    B6 00 00 00 00 00 02 00 44 45 4C 4C 20 20 43 42 \
    58 33 20 20 20 00 57 49 4E 44 4F 57 53 20 01 00 \
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
    00 00 7A AB 2D D4 C8 27 C3 2F CB 4C 40 7E 26 1A \
    0B EE 49 FC 48 09 7F F8 12 CC 64 18 35 B3 63 EC \
    48 C2 25 47 53 92 31 30 E1 18 0C 55 ED 57 6A F5 \
    E7 79 01 34 2D 7C FA 3C 30 A1 41 C8 84 31 6F 45 \
    FB B4 CC ED 13 E0 9D 25 78 7C 37 45 CE 29 A2 CC \
    65 84 2E 5F B6 65 F7 EE 27 EE E6 2C B7 41 1D 20 \
    16 AC 9C 7C 95 E3 36 92 19 30 7B B6 A1 75 EA A2 \
    40 4F EA BE 71 92 E5 20 FE C4 70 10 1A 9D DF 78 \
    BA C3 

Raw Table Data: Length 374 (0x176)

    0000: 53 4C 49 43 76 01 00 00 03 6A 44 45 4C 4C 20 20  // SLICv....jDELL  
    0010: 43 42 58 33 20 20 20 00 09 20 07 01 4D 53 46 54  // CBX3   .. ..MSFT
    0020: 13 00 01 00 00 00 00 00 9C 00 00 00 06 02 00 00  // ................
    0030: 00 24 00 00 52 53 41 31 00 04 00 00 01 00 01 00  // .$..RSA1........
    0040: 7F F6 C1 05 BE 5C 57 63 A5 8A 68 F3 6E 8F 06 FA  // .....\Wc..h.n...
    0050: AF B4 9F 68 82 23 EC 50 40 5A 73 7F EC E4 07 CB  // ...h.#.P@Zs.....
    0060: DC 25 1A 9C E3 E3 66 11 E0 A5 98 06 C5 80 0A FA  // .%....f.........
    0070: 42 93 86 98 E7 D5 1B D4 D7 3A A4 0B EE E2 7D BE  // B........:....}.
    0080: 5F 5B 15 0C AB D0 21 DE BF E9 B5 6E A4 57 B9 8C  // _[....!....n.W..
    0090: 0C D2 BA 3A 69 30 76 94 71 A2 64 D7 4C D8 85 BF  // ...:i0v.q.d.L...
    00A0: DF A5 6A C8 DC 45 D5 4D 8C B8 8C 05 2F FC 2E 23  // ..j..E.M..../..#
    00B0: C4 29 C5 6F 3F 29 6C 6D 57 79 0E B6 75 ED 21 95  // .).o?)lmWy..u.!.
    00C0: 01 00 00 00 B6 00 00 00 00 00 02 00 44 45 4C 4C  // ............DELL
    00D0: 20 20 43 42 58 33 20 20 20 00 57 49 4E 44 4F 57  //   CBX3   .WINDOW
    00E0: 53 20 01 00 02 00 00 00 00 00 00 00 00 00 00 00  // S ..............
    00F0: 00 00 00 00 00 00 7A AB 2D D4 C8 27 C3 2F CB 4C  // ......z.-..'./.L
    0100: 40 7E 26 1A 0B EE 49 FC 48 09 7F F8 12 CC 64 18  // @~&...I.H.....d.
    0110: 35 B3 63 EC 48 C2 25 47 53 92 31 30 E1 18 0C 55  // 5.c.H.%GS.10...U
    0120: ED 57 6A F5 E7 79 01 34 2D 7C FA 3C 30 A1 41 C8  // .Wj..y.4-|.<0.A.
    0130: 84 31 6F 45 FB B4 CC ED 13 E0 9D 25 78 7C 37 45  // .1oE.......%x|7E
    0140: CE 29 A2 CC 65 84 2E 5F B6 65 F7 EE 27 EE E6 2C  // .)..e.._.e..'..,
    0150: B7 41 1D 20 16 AC 9C 7C 95 E3 36 92 19 30 7B B6  // .A. ...|..6..0{.
    0160: A1 75 EA A2 40 4F EA BE 71 92 E5 20 FE C4 70 10  // .u..@O..q.. ..p.
    0170: 1A 9D DF 78 BA C3                                // ...x..
