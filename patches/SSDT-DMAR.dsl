/*
 * Replace OEM DMAR table
 *
 * This is a modified DMAR Table without memory regions must be injected instead.
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/00_ACPI/ACPI_Dropping_Tables#example-2-replacing-the-dmar-table-by-a-modified-one
 */

[000h 0000   4]                    Signature : "DMAR"    [DMA Remapping table]
[004h 0004   4]                 Table Length : 000000A6
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 99
[00Ah 0010   6]                       Oem ID : "INTEL "
[010h 0016   8]                 Oem Table ID : "SKL "
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "INTL"
[020h 0032   4]        Asl Compiler Revision : 20200925

[024h 0036   1]           Host Address Width : 26
[025h 0037   1]                        Flags : 03
[026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 00 00

[030h 0048   2]                Subtable Type : 0000 [Hardware Unit Definition]
[032h 0050   2]                       Length : 0018

[034h 0052   1]                        Flags : 00
[035h 0053   1]                     Reserved : 00
[036h 0054   2]           PCI Segment Number : 0000
[038h 0056   8]        Register Base Address : 00000000FED90000

[040h 0064   1]            Device Scope Type : 01 [PCI Endpoint Device]
[041h 0065   1]                 Entry Length : 08
[042h 0066   2]                     Reserved : 0000
[044h 0068   1]               Enumeration ID : 00
[045h 0069   1]               PCI Bus Number : 00

[046h 0070   2]                     PCI Path : 02,00


[048h 0072   2]                Subtable Type : 0000 [Hardware Unit Definition]
[04Ah 0074   2]                       Length : 0030

[04Ch 0076   1]                        Flags : 01
[04Dh 0077   1]                     Reserved : 00
[04Eh 0078   2]           PCI Segment Number : 0000
[050h 0080   8]        Register Base Address : 00000000FED91000

[058h 0088   1]            Device Scope Type : 03 [IOAPIC Device]
[059h 0089   1]                 Entry Length : 08
[05Ah 0090   2]                     Reserved : 0000
[05Ch 0092   1]               Enumeration ID : 02
[05Dh 0093   1]               PCI Bus Number : F0

[05Eh 0094   2]                     PCI Path : 1F,00


[060h 0096   1]            Device Scope Type : 04 [Message-capable HPET Device]
[061h 0097   1]                 Entry Length : 08
[062h 0098   2]                     Reserved : 0000
[064h 0100   1]               Enumeration ID : 00
[065h 0101   1]               PCI Bus Number : 00

[066h 0102   2]                     PCI Path : 1F,00


[068h 0104   1]            Device Scope Type : 05 [Namespace Device]
[069h 0105   1]                 Entry Length : 08
[06Ah 0106   2]                     Reserved : 0000
[06Ch 0108   1]               Enumeration ID : 01
[06Dh 0109   1]               PCI Bus Number : 00

[06Eh 0110   2]                     PCI Path : 15,00


[070h 0112   1]            Device Scope Type : 05 [Namespace Device]
[071h 0113   1]                 Entry Length : 08
[072h 0114   2]                     Reserved : 0000
[074h 0116   1]               Enumeration ID : 02
[075h 0117   1]               PCI Bus Number : 00

[076h 0118   2]                     PCI Path : 15,01


[078h 0120   2]                Subtable Type : 0004 [ACPI Namespace Device Declaration]
[07Ah 0122   2]                       Length : 0017

[07Ch 0124   3]                     Reserved : 000000
[07Fh 0127   1]                Device Number : 01
[080h 0128  15]                  Device Name : "\_SB.PCI0.I2C0"

[08Fh 0143   2]                Subtable Type : 0004 [ACPI Namespace Device Declaration]
[091h 0145   2]                       Length : 0017

[093h 0147   3]                     Reserved : 000000
[096h 0150   1]                Device Number : 02
[097h 0151  15]                  Device Name : "\_SB.PCI0.I2C1"

Raw Table Data: Length 166 (0xA6)

    0000: 44 4D 41 52 A6 00 00 00 01 99 49 4E 54 45 4C 20  // DMAR......INTEL
    0010: 53 4B 4C 20 00 00 00 00 01 00 00 00 49 4E 54 4C  // SKL ........INTL
    0020: 25 09 20 20 26 03 00 00 00 00 00 00 00 00 00 00  // %.  &...........
    0030: 00 00 18 00 00 00 00 00 00 00 D9 FE 00 00 00 00  // ................
    0040: 01 08 00 00 00 00 02 00 00 00 30 00 01 00 00 00  // ..........0.....
    0050: 00 10 D9 FE 00 00 00 00 03 08 00 00 02 F0 1F 00  // ................
    0060: 04 08 00 00 00 00 1F 00 05 08 00 00 01 00 15 00  // ................
    0070: 05 08 00 00 02 00 15 01 04 00 17 00 00 00 00 01  // ................
    0080: 5C 5F 53 42 2E 50 43 49 30 2E 49 32 43 30 00 04  // \_SB.PCI0.I2C0..
    0090: 00 17 00 00 00 00 02 5C 5F 53 42 2E 50 43 49 30  // .......\_SB.PCI0
    00A0: 2E 49 32 43 31 00                                // .I2C1.
