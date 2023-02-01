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

    // Device (TBON)
    // {
    //     Name (_HID, "TBON1000")  // _HID: Hardware ID
    //     Method (_INI, 0, NotSerialized)  // _INI: Initialize
    //     {
    //         Debug = "TBON._INI: Powering TBFP"
    //         \_SB.TBFP (One)
    //     }
    // }

    Method (GPLD, 2, Serialized)
    {
        Name (PCKG, Package (0x01)
        {
            Buffer (0x10){}
        })
        CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
        REV = One
        CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
        VISI = Arg0
        CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
        GPOS = Arg1
        Return (PCKG) /* \_SB_.PCI0.RP01.UPSB.TBL3.TBTU.RHUB.GPLD.PCKG */
    }

    Method (GUPC, 2, Serialized)
    {
        Name (PCKG, Package (0x04)
        {
            Zero,
            0xFF,
            Zero,
            Zero
        })
        PCKG [Zero] = Arg0
        PCKG [One] = Arg1
        Return (PCKG) /* \_SB_.PCI0.RP01.PXSX.DSB2.XHC2.RHUB.GUPC.PCKG */
    }

    Scope (_SB.PCI0.RP01)
    {
        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (Zero)
        }

        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
        {
            // Debug = "RP01.PXSX._PS0: Powering TBFP"
            // \_SB.TBFP (One)
        }

        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
        {
            // Debug = "RP01.PXSX._PS3: de-Powering TBFP"
            \_SB.TBFP (Zero)
        }

    //     Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
    //     {
    //         If (LEqual (Arg2, Zero))
    //         {
    //             Return (Buffer (One)
    //             {
    //                 0x03
    //             })
    //         }

    //         Return (Package (0x02)
    //         {
    //             "reg-ltrovr",
    //             Buffer (0x08)
    //             {
    //                 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    //             }
    //         })
    //     }
    }

    Scope (_SB_.PCI0.RP01.PXSX)
    {
        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
        Field (A1E0, ByteAcc, NoLock, Preserve)
        {
            AVND,   32,
            BMIE,   3,
            Offset (0x18),
            PRIB,   8,
            SECB,   8,
            SUBB,   8,
            Offset (0x1E),
                ,   13,
            MABT,   1
        }

        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
        Field (A1E1, ByteAcc, NoLock, Preserve)
        {
            Offset (0x01),
            Offset (0x02),
            Offset (0x04),
            Offset (0x08),
            Offset (0x0A),
                ,   5,
            TPEN,   1,
            Offset (0x0C),
            SSPD,   4,
                ,   16,
            LACR,   1,
            Offset (0x10),
                ,   4,
            LDIS,   1,
            LRTN,   1,
            Offset (0x12),
            CSPD,   4,
            CWDT,   6,
                ,   1,
            LTRN,   1,
                ,   1,
            LACT,   1,
            Offset (0x14),
            Offset (0x30),
            TSPD,   4
        }

        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
        Field (A1E2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x01),
            Offset (0x02),
            Offset (0x04),
            PSTA,   2
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Debug = "TB:UPSB:_STA()"

            If (OSDW ())
            {
                Return (0xF) // visible for OSX
            }

            Return (Zero) // hidden for others
        }

        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
        {
            Return (SECB) /* \_SB.PCI0.RP01.PXSX.SECB */
        }

        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (One)
        }

        Device (DSB0)
        {
            Name (_ADR, Zero)  // _ADR: Address
            OperationRegion (A1E0, PCI_Config, Zero, 0x40)
            Field (A1E0, ByteAcc, NoLock, Preserve)
            {
                AVND,   32,
                BMIE,   3,
                Offset (0x18),
                PRIB,   8,
                SECB,   8,
                SUBB,   8,
                Offset (0x1E),
                    ,   13,
                MABT,   1
            }

            OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
            Field (A1E1, ByteAcc, NoLock, Preserve)
            {
                Offset (0x01),
                Offset (0x02),
                Offset (0x04),
                Offset (0x08),
                Offset (0x0A),
                    ,   5,
                TPEN,   1,
                Offset (0x0C),
                SSPD,   4,
                    ,   16,
                LACR,   1,
                Offset (0x10),
                    ,   4,
                LDIS,   1,
                LRTN,   1,
                Offset (0x12),
                CSPD,   4,
                CWDT,   6,
                    ,   1,
                LTRN,   1,
                    ,   1,
                LACT,   1,
                Offset (0x14),
                Offset (0x30),
                TSPD,   4
            }

            OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
            Field (A1E2, ByteAcc, NoLock, Preserve)
            {
                Offset (0x01),
                Offset (0x02),
                Offset (0x04),
                PSTA,   2
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (SECB) /* \_SB.PCI0.RP01.PXSX.DSB0.SECB */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }

            Name (IIP3, Zero)
            Name (PRSR, Zero)
            Name (PCIA, One)

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (OSDW ())
                {
                    If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                    {
                        Local0 = Package ()
                            {
                                "PCIHotplugCapable",
                                Zero
                            }
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                }

                Return (Zero)
            }

            Device (NHI0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_STR, Unicode ("Thunderbolt"))  // _STR: Description String
                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32,
                    BMIE,   3,
                    Offset (0x18),
                    PRIB,   8,
                    SECB,   8,
                    SUBB,   8,
                    Offset (0x1E),
                        ,   13,
                    MABT,   1
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    Local0 = Package ()
                        {
                            "TBTDPLowToHigh",
                            Buffer (One)
                            {
                                    0x01, 0x00, 0x00, 0x00
                            },

                            "TBTFlags",
                            Buffer ()
                            {
                                0x03, 0x00, 0x00, 0x00
                            },

                            "sscOffset",
                            Buffer ()
                            {
                                    0x00, 0x07
                            },

                            "linkDetails",
                            Buffer ()
                            {
                                0x08, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
                            },

                            "power-save",
                            One,

                            Buffer (One)
                            {
                                0x00
                            }
                        }
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
        }

        Device (DSB1)
        {
            Name (_ADR, 0x00010000)  // _ADR: Address
        }

        Device (DSB2)
        {
            Name (_ADR, 0x00020000)  // _ADR: Address

            OperationRegion (A1E0, PCI_Config, Zero, 0x40)
            Field (A1E0, ByteAcc, NoLock, Preserve)
            {
                AVND,   32,
                BMIE,   3,
                Offset (0x18),
                PRIB,   8,
                SECB,   8,
                SUBB,   8,
                Offset (0x1E),
                    ,   13,
                MABT,   1
            }

            OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
            Field (A1E1, ByteAcc, NoLock, Preserve)
            {
                Offset (0x01),
                Offset (0x02),
                Offset (0x04),
                Offset (0x08),
                Offset (0x0A),
                    ,   5,
                TPEN,   1,
                Offset (0x0C),
                SSPD,   4,
                    ,   16,
                LACR,   1,
                Offset (0x10),
                    ,   4,
                LDIS,   1,
                LRTN,   1,
                Offset (0x12),
                CSPD,   4,
                CWDT,   6,
                    ,   1,
                LTRN,   1,
                    ,   1,
                LACT,   1,
                Offset (0x14),
                Offset (0x30),
                TSPD,   4
            }

            OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
            Field (A1E2, ByteAcc, NoLock, Preserve)
            {
                Offset (0x01),
                Offset (0x02),
                Offset (0x04),
                PSTA,   2
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (SECB) /* SECB */
            }

            Method (_STA, 0, NotSerialized)
            {
                If (OSDW ())
                {
                    Return (0x0F) // Used in OSX
                }

                Return (0x0F) // hidden for others
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }

            Name (IIP3, Zero)
            Name (PRSR, Zero)
            Name (PCIA, One)

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                {
                    Local0 = Package ()
                        {
                            "PCIHotplugCapable",
                            Zero
                        }
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }

                Return (Zero)
            }

            Device (XHC2)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32,
                    BMIE,   3,
                    Offset (0x18),
                    PRIB,   8,
                    SECB,   8,
                    SUBB,   8,
                    Offset (0x1E),
                        ,   13,
                    MABT,   1
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                                0x03                                             // .
                        })
                    }

                    Local0 = Package (0x0A)
                        {
                            "USBBusNumber",
                            Zero,
                            "UsbCompanionControllerPresent",
                            One,
                            "AAPL,XHCI-clock-id",
                            One,
                            "IOPCIExpressCapabilites",
                            0x02,
                            "IOPCIHPType",
                            0x02
                        }
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }

                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }

                    Device (HSP1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (One, 0x03))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (GPLD (One, One))
                        }
                    }

                    Device (HSP2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (Zero, Zero))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (GPLD (Zero, Zero))
                        }
                    }

                    Device (SSP1)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (One, 0x03))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (GPLD (One, One))
                        }
                    }

                    Device (SSP2)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (Zero, Zero))
                        }

                        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                        {
                            Return (GPLD (Zero, Zero))
                        }
                    }
                }
            }
        }
    }
}

