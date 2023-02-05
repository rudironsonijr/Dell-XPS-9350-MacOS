/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 *
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLyceyaG.aml, Wed Jan 25 13:23:56 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000002D2 (722)
 *     Revision         0x02
 *     Checksum         0x79
 *     OEM ID           "hack"
 *     OEM Table ID     "TYPC"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160422 (538313762)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "TYPC", 0x00000000)
{
    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01.PXSX, DeviceObj)
    External (GPRW, MethodObj)
    External (DTGP, MethodObj)
    External (OSDW, MethodObj) // 0 Arguments
    External (_SB_.TBFP, MethodObj)    // 1 Arguments

    Scope (_SB_.PCI0.RP01.PXSX)
    {
        Device (DSB1)
        {
            Name (_ADR, 0x00010000)  // _ADR: Address
        }
    }
}

