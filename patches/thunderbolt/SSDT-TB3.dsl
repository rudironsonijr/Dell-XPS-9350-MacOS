DefinitionBlock ("", "SSDT", 2, "hack", "TB3", 0x00000000)
{
    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01.PXSX, DeviceObj)
    External (DTGP, MethodObj)    // 5 Arguments

    Scope (_SB.PCI0.RP01)
    {
        Scope (PXSX)
        {
            // Disable RP01.PXSX
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (Zero)
            }
        }

        Device (UPSB)
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
                Return (SECB) /* \_SB_.PCI0.RP01.UPSB.SECB */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Debug = "_SB.PCI0.RP01.PXSX:_STA()"
                Return (0x0F)
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Debug = "_SB.PCI0.RP01.PXSX:_RMV()"
                Return (One)
            }

            Device (DSB2)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Debug = "_SB.PCI0.RP01.PXSX.DSB2:_STA()"
                    Return (0x0F)
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Debug = "_SB.PCI0.RP01.PXSX.DSB2:_RMV()"
                    Return (Zero)
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    Debug = "_SB.PCI0.RP01.PXSX.DSB2:_DSM()"
                    If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
                    {
                        Local0 = Package (0x02)
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
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Debug = "_SB.PCI0.RP01.PXSX.DSB2.XHC2:_STA()"
                        Return (0x0F)
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Debug = "_SB.PCI0.RP01.PXSX.DSB2.XHC2:_RMV()"
                        Return (Zero)
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Debug = "_SB.PCI0.RP01.PXSX.DSB2.XHC2:_DSM()"
                        If ((Arg2 == Zero))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                             // .
                            })
                        }

                        Local0 = Package (0x06)
                            {
                                "USBBusNumber",
                                Zero,
                                "AAPL,xhci-clock-id",
                                One,
                                "UsbCompanionControllerPresent",
                                Zero
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
                            Return (PCKG) /* \_SB_.PCI0.RP01.UPSB.DSB2.XHC2.RHUB.GPLD.PCKG */
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
                            Return (PCKG) /* \_SB_.PCI0.RP01.UPSB.DSB2.XHC2.RHUB.GUPC.PCKG */
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Debug = "_SB.PCI0.RP01.PXSX.DSB2.XHC2.RHUB:_RMV()"
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
}

