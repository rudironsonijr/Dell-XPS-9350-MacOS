/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 *
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-5.aml, Sat Jan 21 09:44:36 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000737 (1847)
 *     Revision         0x02
 *     Checksum         0x58
 *     OEM ID           "INTEL"
 *     OEM Table ID     "xh_rvp07"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "XHC", 0x00000000)
{
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS08, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS10, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.USR1, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.USR2, DeviceObj)
    External (BID_, IntObj)

    External (GPLD, MethodObj)
    External (GUPC, MethodObj)
    External (DTGP, MethodObj)

    Scope (\_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                Local0 = Package (0x08)
                    {
                        "kUSBSleepPortCurrentLimit",
                        0x0834,
                        "kUSBWakePortCurrentLimit",
                        0x0834,
                        "kUSBSleepPowerSupply",
                        0x13EC,
                        "kUSBWakePowerSupply",
                        0x13EC
                    }
                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }

        Scope (PCI0.XHC)
        {
            Scope (RHUB)
            {
                Scope (HS01)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (One, 0x03))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (One, One))
                    }
                }

                Scope (HS02)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (One, 0x03))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (One, 0x02))
                    }
                }

                Scope (HS03)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (One, 0xFF))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, 0x03))
                    }
                }

                Scope (HS04)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, 0xFF))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, 0x04))
                    }
                }

                Scope (HS05)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (One, 0xFF))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, 0x05))
                    }

                    Device (WCAM)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Name (UPCP, Package (0x04)
                            {
                                0xFF,
                                0xFF,
                                Zero,
                                Zero
                            })
                            Return (UPCP) /* \_SB_.PCI0.XHC_.RHUB.HS05.WCAM._UPC.UPCP */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Name (PLDP, Package (0x01)
                            {
                                Buffer (0x14)
                                {
                                    /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                    /* 0008 */  0x24, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00,  // $.......
                                    /* 0010 */  0xC8, 0x00, 0xA0, 0x00                           // ....
                                }
                            })
                            Return (PLDP) /* \_SB_.PCI0.XHC_.RHUB.HS05.WCAM._PLD.PLDP */
                        }
                    }
                }

                Scope (HS06)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (HS07)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (HS08)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (HS09)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (HS10)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (USR1)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (USR2)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (SS01)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (One, 0x03))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (One, One))
                    }
                }

                Scope (SS02)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (One, 0x03))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (One, 0x02))
                    }
                }

                Scope (SS03)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (SS04)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (SS05)
                {
                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                    {
                        Return (GUPC (Zero, Zero))
                    }

                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                    {
                        Return (GPLD (Zero, Zero))
                    }
                }

                Scope (SS06)
                {
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

