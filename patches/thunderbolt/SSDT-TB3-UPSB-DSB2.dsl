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

                    Method (GUPC, 1, Serialized)
                    {
                        Name (PCKG, Package (0x04)
                        {
                            Zero,
                            0xFF,
                            Zero,
                            Zero
                        })
                        PCKG [Zero] = Arg0
                        Return (PCKG) /* \_SB_.PCI0.RP01.UPSB.TBL3.TBTU.RHUB.GUPC.PCKG */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }

                    Device (HSP1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                        {
                            Return (GUPC (0x09))
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
                            Return (GUPC (Zero))
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
                            Return (GUPC (0x09))
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
                            Return (GUPC (Zero))
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
