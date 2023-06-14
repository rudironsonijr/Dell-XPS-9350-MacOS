/*
 * This is my failed attempt to fix TB3 on DSL6340
 *
 * References:
 * [1] https://osy.gitbook.io/hac-mini-guide/details/thunderbolt-3-fix-part-3
 * [2] https://github.com/osy/ThunderboltReset
 * [3] https://github.com/al3xtjames/ThunderboltPkg/blob/master/Docs/FAQ.md
 */
DefinitionBlock ("", "SSDT", 2, "hack", "TYPC", 0x00000000)
{
    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01.PXSX, DeviceObj)
    // External (\_SB.PCI0.GEXP, DeviceObj)
    // External (\_SB.PCI0.PEG1, DeviceObj)
    // External (\_SB.PCI0.PEG2, DeviceObj)

    // External (P8XH, MethodObj)
    // External (ADBG, MethodObj)
    // External (\_SB.PCI0.GEXP.INVC, MethodObj)
    // External (\_SB.PCI0.NHPG, MethodObj)
    // External (\_SB.PCI0.NPME, MethodObj)
    // External (\_SB.PCI0.GFX0.IUEH, MethodObj)
    // External (TRAP, MethodObj)
    // External (\_GPE.TINI, MethodObj)
    // External (EV2_, MethodObj)
    // External (ECG4, MethodObj)
    // External (GENS, MethodObj)
    // External (\_SB.TBFP, MethodObj)

    // External (S0ID, IntObj)
    // External (\_SB.SCGE, IntObj)
    // External (NEXP, IntObj)
    // External (OSCC, IntObj)
    // External (SSMP, IntObj)
    // External (GBSX, IntObj)
    // External (\_PR.DTSE, IntObj)
    // External (TCNT, IntObj)
    // External (OSYS, IntObj)
    // External (NHDA, IntObj)
    // External (\_SB.PCI0.PEG0.PEGP.MLTF, IntObj)
    // External (TBTS, IntObj)
    // External (\_SB.PCI0.RP01.VDID, IntObj)
    // External (\_SB.PCI0.RP02.VDID, IntObj)
    // External (\_SB.PCI0.RP03.VDID, IntObj)
    // External (\_SB.PCI0.RP04.VDID, IntObj)
    // External (\_SB.PCI0.RP05.VDID, IntObj)
    // External (\_SB.PCI0.RP06.VDID, IntObj)
    // External (\_SB.PCI0.RP07.VDID, IntObj)
    // External (\_SB.PCI0.RP08.VDID, IntObj)
    // External (\_SB.PCI0.RP09.VDID, IntObj)
    // External (\_SB.PCI0.RP10.VDID, IntObj)
    // External (\_SB.PCI0.RP11.VDID, IntObj)
    // External (\_SB.PCI0.RP12.VDID, IntObj)
    // External (\_SB.PCI0.RP13.VDID, IntObj)
    // External (\_SB.PCI0.RP14.VDID, IntObj)
    // External (\_SB.PCI0.RP15.VDID, IntObj)
    // External (\_SB.PCI0.RP16.VDID, IntObj)
    // External (\_SB.PCI0.RP17.VDID, IntObj)
    // External (\_SB.PCI0.RP18.VDID, IntObj)
    // External (\_SB.PCI0.RP19.VDID, IntObj)
    // External (\_SB.PCI0.RP20.VDID, IntObj)
    // External (DSTS, IntObj)
    // External (NOHP, IntObj)
    // External (TBSE, IntObj)
    // External (\_SB.PCI0.RP01.PXSX.AVND, IntObj)

    // External (WFEV, EventObj)

    // External (OSUM, MutexObj)

    // OperationRegion (NVID, SystemMemory, 0xE0100000, 0x02)

    // Method (RWAK, 1, Serialized)
    // {
    //     P8XH (One, 0xAB)
    //     ADBG ("_WAK")
    //     \_SB.PCI0.GEXP.INVC ()
    //     If ((S0ID == One))
    //     {
    //         \_SB.SCGE = One
    //     }

    //     If (NEXP)
    //     {
    //         If ((OSCC & 0x02))
    //         {
    //             \_SB.PCI0.NHPG ()
    //         }

    //         If ((OSCC & 0x04))
    //         {
    //             \_SB.PCI0.NPME ()
    //         }
    //     }

    //     If ((Arg0 == 0x03))
    //     {
    //         SSMP = 0x0E
    //     }

    //     If ((Arg0 == 0x03)){}
    //     If (((Arg0 == 0x03) || (Arg0 == 0x04)))
    //     {
    //         If ((GBSX & 0x40))
    //         {
    //             \_SB.PCI0.GFX0.IUEH (0x06)
    //         }

    //         If ((GBSX & 0x80))
    //         {
    //             \_SB.PCI0.GFX0.IUEH (0x07)
    //         }

    //         If (CondRefOf (\_PR.DTSE))
    //         {
    //             If ((\_PR.DTSE && (TCNT > One)))
    //             {
    //                 TRAP (0x02, 0x14)
    //             }
    //         }

    //         Field (NVID, ByteAcc, NoLock, Preserve)
    //         {
    //             VVID,   16
    //         }

    //         If ((OSYS >= 0x07D9))
    //         {
    //             If ((VVID == 0x10DE))
    //             {
    //                 If ((NHDA == One))
    //                 {
    //                     \_SB.PCI0.PEG0.PEGP.MLTF = One
    //                 }
    //                 Else
    //                 {
    //                     \_SB.PCI0.PEG0.PEGP.MLTF = Zero
    //                 }
    //             }
    //         }

    //         If ((TBTS == One))
    //         {
    //             Acquire (OSUM, 0xFFFF)
    //             \_GPE.TINI ()
    //             Release (OSUM)
    //         }

    //         If ((\_SB.PCI0.RP01.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP01, Zero) // Bus Check
    //             //////////////////////////////////////////////////////////////////////
    //             //////////////////////////////////////////////////////////////////////
    //             //////////////////////////////////////////////////////////////////////
    //             ADBG ("[RWAK]: Notify (_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero)")
    //             Notify (\_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero) // TB3 controller
    //             //////////////////////////////////////////////////////////////////////
    //             //////////////////////////////////////////////////////////////////////
    //             //////////////////////////////////////////////////////////////////////
    //         }

    //         If ((\_SB.PCI0.RP02.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP02, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP03.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP03, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP04.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP04, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP05.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP05, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP06.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP06, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP07.VDID != 0xFFFFFFFF))
    //         {
    //             If ((DSTS == Zero))
    //             {
    //                 Notify (\_SB.PCI0.RP07, Zero) // Bus Check
    //             }
    //         }

    //         If ((\_SB.PCI0.RP08.VDID != 0xFFFFFFFF))
    //         {
    //             If ((DSTS == Zero))
    //             {
    //                 Notify (\_SB.PCI0.RP08, Zero) // Bus Check
    //             }
    //         }

    //         If ((\_SB.PCI0.RP09.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP09, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP10.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP10, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP11.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP11, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP12.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP12, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP13.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP13, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP14.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP14, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP15.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP15, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP16.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP16, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP17.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP17, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP18.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP18, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP19.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP19, Zero) // Bus Check
    //         }

    //         If ((\_SB.PCI0.RP20.VDID != 0xFFFFFFFF))
    //         {
    //             Notify (\_SB.PCI0.RP20, Zero) // Bus Check
    //         }
    //     }

    //     If (((Arg0 == 0x03) || (Arg0 == 0x04))){}
    //     EV2 (Arg0, Zero)
    //     If (ECG4 ())
    //     {
    //         GENS (0x1C, One, Zero)
    //     }
    //     Else
    //     {
    //         GENS (0x1C, Zero, Zero)
    //     }

    //     If ((TBTS == One))
    //     {
    //         Signal (WFEV)
    //     }

    //     Return (Package (0x02)
    //     {
    //         Zero,
    //         Zero
    //     })
    // }

    // Scope (\_GPE)
    // {
    //     Method (NTFY, 0, Serialized)
    //     {
    //         ADBG ("NTFY")
    //         If ((NOHP == One))
    //         {
    //             Switch (ToInteger (TBSE))
    //             {
    //                 Case (One)
    //                 {
    //                     ADBG ("Notify RP01")
    //                     Notify (\_SB.PCI0.RP01, Zero) // Bus Check
    //                     //////////////////////////////////////////////////////////////////////
    //                     //////////////////////////////////////////////////////////////////////
    //                     //////////////////////////////////////////////////////////////////////
    //                     ADBG ("[_GPE.NTFY]: Notify (_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero)")
    //                     Notify (\_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero) // TB3 controller
    //                     //////////////////////////////////////////////////////////////////////
    //                     //////////////////////////////////////////////////////////////////////
    //                     //////////////////////////////////////////////////////////////////////
    //                 }
    //                 Case (0x02)
    //                 {
    //                     ADBG ("Notify RP02")
    //                     Notify (\_SB.PCI0.RP02, Zero) // Bus Check
    //                 }
    //                 Case (0x03)
    //                 {
    //                     ADBG ("Notify RP03")
    //                     Notify (\_SB.PCI0.RP03, Zero) // Bus Check
    //                 }
    //                 Case (0x04)
    //                 {
    //                     ADBG ("Notify RP04")
    //                     Notify (\_SB.PCI0.RP04, Zero) // Bus Check
    //                 }
    //                 Case (0x05)
    //                 {
    //                     ADBG ("Notify RP05")
    //                     Notify (\_SB.PCI0.RP05, Zero) // Bus Check
    //                 }
    //                 Case (0x06)
    //                 {
    //                     ADBG ("Notify RP06")
    //                     Notify (\_SB.PCI0.RP06, Zero) // Bus Check
    //                 }
    //                 Case (0x07)
    //                 {
    //                     ADBG ("Notify RP07")
    //                     Notify (\_SB.PCI0.RP07, Zero) // Bus Check
    //                 }
    //                 Case (0x08)
    //                 {
    //                     ADBG ("Notify RP08")
    //                     Notify (\_SB.PCI0.RP08, Zero) // Bus Check
    //                 }
    //                 Case (0x09)
    //                 {
    //                     ADBG ("Notify RP09")
    //                     Notify (\_SB.PCI0.RP09, Zero) // Bus Check
    //                 }
    //                 Case (0x0A)
    //                 {
    //                     ADBG ("Notify RP10")
    //                     Notify (\_SB.PCI0.RP10, Zero) // Bus Check
    //                 }
    //                 Case (0x0B)
    //                 {
    //                     ADBG ("Notify RP11")
    //                     Notify (\_SB.PCI0.RP11, Zero) // Bus Check
    //                 }
    //                 Case (0x0C)
    //                 {
    //                     ADBG ("Notify RP12")
    //                     Notify (\_SB.PCI0.RP12, Zero) // Bus Check
    //                 }
    //                 Case (0x0D)
    //                 {
    //                     ADBG ("Notify RP13")
    //                     Notify (\_SB.PCI0.RP13, Zero) // Bus Check
    //                 }
    //                 Case (0x0E)
    //                 {
    //                     ADBG ("Notify RP14")
    //                     Notify (\_SB.PCI0.RP14, Zero) // Bus Check
    //                 }
    //                 Case (0x0F)
    //                 {
    //                     ADBG ("Notify RP15")
    //                     Notify (\_SB.PCI0.RP15, Zero) // Bus Check
    //                 }
    //                 Case (0x10)
    //                 {
    //                     ADBG ("Notify RP16")
    //                     Notify (\_SB.PCI0.RP16, Zero) // Bus Check
    //                 }
    //                 Case (0x11)
    //                 {
    //                     ADBG ("Notify RP17")
    //                     Notify (\_SB.PCI0.RP17, Zero) // Bus Check
    //                 }
    //                 Case (0x12)
    //                 {
    //                     ADBG ("Notify RP18")
    //                     Notify (\_SB.PCI0.RP18, Zero) // Bus Check
    //                 }
    //                 Case (0x13)
    //                 {
    //                     ADBG ("Notify RP19")
    //                     Notify (\_SB.PCI0.RP19, Zero) // Bus Check
    //                 }
    //                 Case (0x14)
    //                 {
    //                     ADBG ("Notify RP20")
    //                     Notify (\_SB.PCI0.RP20, Zero) // Bus Check
    //                 }
    //                 Case (0x15)
    //                 {
    //                     ADBG ("Notify PEG0")
    //                     Notify (\_SB.PCI0.PEG0, Zero) // Bus Check
    //                 }
    //                 Case (0x16)
    //                 {
    //                     ADBG ("Notify PEG1")
    //                     Notify (\_SB.PCI0.PEG1, Zero) // Bus Check
    //                 }
    //                 Case (0x17)
    //                 {
    //                     ADBG ("Notify PEG2")
    //                     Notify (\_SB.PCI0.PEG2, Zero) // Bus Check
    //                 }

    //             }
    //         }
    //     }
    // }

    // Scope (\_SB.PCI0.RP01)
    // {
    //     Method (_PS0, 0, Serialized)  // _PS0: Power State 0
    //     {
    //         \_SB.TBFP (One)
    //         Local0 = 10000 // 10 seconds
    //         While (Local0 > 0 && \_SB.PCI0.RP01.PXSX.AVND == 0xFFFFFFFF)
    //         {
    //             Sleep (1)
    //             Local0--
    //         }
    //     }
    // }

    Scope (\_SB.PCI0.RP01.PXSX)
    {
        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            If (_OSI ("Darwin"))
            {
                Return (One)
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }

        Device (DSB0)
        {
            Name (_ADR, Zero)  // _ADR: Address

            Device (NHI0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_STR, Unicode ("Thunderbolt"))  // _STR: Description String
            }
        }
        Device (DSB2)
        {
            Name (_ADR, 0x00020000)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                Return (Package (0x02)
                {
                    "PCIHotplugCapable", 
                    Zero
                })
            }

            Device (XHC2)
            {
                Name (_ADR, Zero)  // _ADR: Address

                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (SSP1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF,
                            0x09,
                            Zero,
                            Zero
                        })
                        Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                        {
                            ToPLD (
                                PLD_Revision           = 0x1,
                                PLD_IgnoreColor        = 0x1,
                                PLD_Red                = 0x0,
                                PLD_Green              = 0x0,
                                PLD_Blue               = 0x0,
                                PLD_Width              = 0x0,
                                PLD_Height             = 0x0,
                                PLD_UserVisible        = 0x1,
                                PLD_Dock               = 0x0,
                                PLD_Lid                = 0x0,
                                PLD_Panel              = "UNKNOWN",
                                PLD_VerticalPosition   = "UPPER",
                                PLD_HorizontalPosition = "LEFT",
                                PLD_Shape              = "UNKNOWN",
                                PLD_GroupOrientation   = 0x0,
                                PLD_GroupToken         = 0x0,
                                PLD_GroupPosition      = 0x0,
                                PLD_Bay                = 0x0,
                                PLD_Ejectable          = 0x0,
                                PLD_EjectRequired      = 0x0,
                                PLD_CabinetNumber      = 0x0,
                                PLD_CardCageNumber     = 0x0,
                                PLD_Reference          = 0x0,
                                PLD_Rotation           = 0x0,
                                PLD_Order              = 0x0)

                        })
                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            If ((Arg2 == Zero))
                            {
                                Return (Buffer (One)
                                {
                                     0x03                                             // .
                                })
                            }

                            Return (Package (0x04)
                            {
                                "UsbCPortNumber", 
                                0x02,
                                "UsbCompanionPortPresent", 
                                Zero
                            })
                        }
                    }

                    Device (SSP2)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF,
                            0x09,
                            Zero,
                            Zero
                        })
                        Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                        {
                            ToPLD (
                                PLD_Revision           = 0x1,
                                PLD_IgnoreColor        = 0x1,
                                PLD_Red                = 0x0,
                                PLD_Green              = 0x0,
                                PLD_Blue               = 0x0,
                                PLD_Width              = 0x0,
                                PLD_Height             = 0x0,
                                PLD_UserVisible        = 0x1,
                                PLD_Dock               = 0x0,
                                PLD_Lid                = 0x0,
                                PLD_Panel              = "UNKNOWN",
                                PLD_VerticalPosition   = "UPPER",
                                PLD_HorizontalPosition = "LEFT",
                                PLD_Shape              = "UNKNOWN",
                                PLD_GroupOrientation   = 0x0,
                                PLD_GroupToken         = 0x0,
                                PLD_GroupPosition      = 0x0,
                                PLD_Bay                = 0x0,
                                PLD_Ejectable          = 0x0,
                                PLD_EjectRequired      = 0x0,
                                PLD_CabinetNumber      = 0x0,
                                PLD_CardCageNumber     = 0x0,
                                PLD_Reference          = 0x0,
                                PLD_Rotation           = 0x0,
                                PLD_Order              = 0x0)

                        })
                    }
                }
            }
        }
    }
}

