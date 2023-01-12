/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-2.aml, Sat Jan 21 09:44:36 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000248 (584)
 *     Revision         0x02
 *     Checksum         0xF8
 *     OEM ID           "INTEL "
 *     OEM Table ID     "sensrhub"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL ", "sensrhub", 0x00000000)
{
    External (_SB_.GGOV, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.I2C0.DFUD, UnknownObj)
    External (_SB_.SGOV, MethodObj)    // 2 Arguments
    External (BID_, FieldUnitObj)
    External (SDS0, FieldUnitObj)
    External (USBH, FieldUnitObj)

    Scope (\)
    {
        Device (SHAD)
        {
            Name (_HID, EisaId ("INT33D0"))  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _CID: Compatible ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (((SDS0 & One) || (USBH & One)))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Name (PGCE, Zero)
                Name (PGCD, Zero)
                Name (PGCG, 0x2E)
                Name (DFUE, Zero)
                Name (DFUD, Zero)
                Name (OLDV, Zero)
                Name (PGCV, Zero)
                Name (DFUV, Zero)
                If ((Arg0 == ToUUID ("03c868d5-563f-42a8-9f57-9a18d949b7cb") /* Unknown UUID */))
                {
                    If ((BID == 0x20))
                    {
                        PGCG = 0x3A
                    }

                    If ((One == ToInteger (Arg1)))
                    {
                        Switch (ToInteger (Arg2))
                        {
                            Case (Zero)
                            {
                                Return (Buffer (One)
                                {
                                     0x0F                                             // .
                                })
                            }
                            Case (One)
                            {
                                PGCE = DerefOf (Arg3 [Zero])
                                PGCD = DerefOf (Arg3 [One])
                                OLDV = \_SB.GGOV (0x02010016)
                                \_SB.SGOV (0x02010016, PGCE)
                                If ((PGCD > Zero))
                                {
                                    Sleep (PGCD)
                                    \_SB.GGOV (0x02010016)
                                    OLDV
                                }

                                If ((\_SB.GGOV (0x02010016) == One))
                                {
                                    Sleep (0x96)
                                    If ((\_SB.GGOV (0x02010014) == One)){}
                                    Else
                                    {
                                        Notify (\_SB.PCI0.I2C0.DFUD, One) // Device Check
                                    }
                                }

                                Return (Zero)
                            }
                            Case (0x02)
                            {
                                DFUE = DerefOf (Arg3 [Zero])
                                DFUD = DerefOf (Arg3 [One])
                                OLDV = \_SB.GGOV (0x02010014)
                                \_SB.GGOV (0x02010014)
                                DFUE
                                If ((DFUD > Zero))
                                {
                                    Sleep (DFUD)
                                    \_SB.GGOV (0x02010014)
                                    OLDV
                                }

                                Return (Zero)
                            }
                            Case (0x03)
                            {
                                DFUV = \_SB.GGOV (0x02010014)
                                PGCV = \_SB.GGOV (0x02010016)
                                Return (Package (0x02)
                                {
                                    PGCV, 
                                    DFUV
                                })
                            }

                        }

                        Return (Zero)
                    }

                    Return (Zero)
                }

                Return (Zero)
            }
        }
    }
}

