/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-4.aml, Sat Jan 21 09:44:36 2023
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000BE3 (3043)
 *     Revision         0x02
 *     Checksum         0xCE
 *     OEM ID           "INTEL "
 *     OEM Table ID     "Ther_Rvp"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL ", "Ther_Rvp", 0x00001000)
{
    /*
     * iASL Warning: There were 2 external control methods found during
     * disassembly, but only 0 were resolved (2 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods. Note: SSDTs can be dynamically loaded at
     * runtime and may or may not be available via the host OS.
     *
     * To specify the tables needed to resolve external control method
     * references, the -e option can be used to specify the filenames.
     * Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (_PR_.AAC0, UnknownObj)
    External (_PR_.ACRT, UnknownObj)
    External (_PR_.APSV, UnknownObj)
    External (_PR_.CPU0, UnknownObj)
    External (_PR_.CPU1, UnknownObj)
    External (_PR_.CPU2, UnknownObj)
    External (_PR_.CPU3, UnknownObj)
    External (_PR_.CPU4, UnknownObj)
    External (_PR_.CPU5, UnknownObj)
    External (_PR_.CPU6, UnknownObj)
    External (_PR_.CPU7, UnknownObj)
    External (_PR_.DTS1, IntObj)
    External (_PR_.DTS2, IntObj)
    External (_PR_.DTS3, IntObj)
    External (_PR_.DTS4, IntObj)
    External (_PR_.DTSE, UnknownObj)
    External (_PR_.PDTS, IntObj)
    External (_PR_.PKGA, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.ECAV, IntObj)
    External (_SB_.PCI0.LPCB.H_EC.ECMD, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.ECMT, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.ECRD, IntObj)
    External (_SB_.PCI0.LPCB.H_EC.ECWT, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.PECH, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.PECL, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.PENV, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.PLMX, UnknownObj)
    External (AC0F, MethodObj)    // Warning: Unknown method, guessing 1 arguments
    External (AC1F, MethodObj)    // Warning: Unknown method, guessing 1 arguments
    External (ACT1, UnknownObj)
    External (ACTT, UnknownObj)
    External (CRTT, UnknownObj)
    External (CTYP, UnknownObj)
    External (PSVT, UnknownObj)
    External (TC1V, IntObj)
    External (TC2V, IntObj)
    External (TCNT, UnknownObj)
    External (TSPV, IntObj)
    External (VFN0, UnknownObj)
    External (VFN1, UnknownObj)
    External (VFN2, UnknownObj)
    External (VFN3, UnknownObj)
    External (VFN4, UnknownObj)

    Scope (\_TZ)
    {
        Name (ETMD, One)
        Event (FCET)
        Name (FCRN, Zero)
        Mutex (FCMT, 0x00)
        Name (CVF0, Zero)
        Name (CVF1, Zero)
        Name (CVF2, Zero)
        Name (CVF3, Zero)
        Name (CVF4, Zero)
        Mutex (FMT0, 0x00)
        Mutex (FMT1, 0x00)
        Mutex (FMT2, 0x00)
        Mutex (FMT3, 0x00)
        Mutex (FMT4, 0x00)
        PowerResource (FN00, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT0, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF0 /* \_TZ_.CVF0 */
                    Release (FMT0)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT0, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF0 = One
                    Release (FMT0)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT0, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF0 = Zero
                    Release (FMT0)
                }

                FNCL ()
            }
        }

        Device (FAN0)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN00
            })
        }

        PowerResource (FN01, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT1, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF1 /* \_TZ_.CVF1 */
                    Release (FMT1)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT1, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF1 = One
                    Release (FMT1)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT1, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF1 = Zero
                    Release (FMT1)
                }

                FNCL ()
            }
        }

        Device (FAN1)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN01
            })
        }

        PowerResource (FN02, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT2, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF2 /* \_TZ_.CVF2 */
                    Release (FMT2)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT2, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF2 = One
                    Release (FMT2)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT2, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF2 = Zero
                    Release (FMT2)
                }

                FNCL ()
            }
        }

        Device (FAN2)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN02
            })
        }

        PowerResource (FN03, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT3, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF3 /* \_TZ_.CVF3 */
                    Release (FMT3)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT3, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF3 = One
                    Release (FMT3)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT3, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF3 = Zero
                    Release (FMT3)
                }

                FNCL ()
            }
        }

        Device (FAN3)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN03
            })
        }

        PowerResource (FN04, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT4, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF4 /* \_TZ_.CVF4 */
                    Release (FMT4)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT4, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF4 = One
                    Release (FMT4)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT4, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF4 = Zero
                    Release (FMT4)
                }

                FNCL ()
            }
        }

        Device (FAN4)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN04
            })
        }

        Method (FNCL, 0, NotSerialized)
        {
            Local5 = Acquire (FCMT, 0x03E8)
            If ((Local5 == Zero))
            {
                Local6 = FCRN /* \_TZ_.FCRN */
                Release (FCMT)
            }

            If ((Local6 != Zero))
            {
                Signal (FCET)
                Return (Zero)
            }
            Else
            {
                Local5 = Acquire (FCMT, 0x03E8)
                If ((Local5 == Zero))
                {
                    FCRN = One
                    Release (FCMT)
                }

                Local5 = Zero
                While ((Local5 < 0x04))
                {
                    If ((Wait (FCET, 0x05) != Zero))
                    {
                        Local5 = 0x04
                    }
                    Else
                    {
                        Local5++
                    }
                }

                Local5 = Acquire (FCMT, 0x03E8)
                If ((Local5 == Zero))
                {
                    FCRN = Zero
                    Release (FCMT)
                }
            }

            Local0 = Zero
            Local1 = Zero
            Local2 = Zero
            Local3 = Zero
            Local4 = Zero
            Local5 = Acquire (FMT0, 0x03E8)
            If ((Local5 == Zero))
            {
                Local0 = CVF0 /* \_TZ_.CVF0 */
                Release (FMT0)
            }

            Local5 = Acquire (FMT1, 0x03E8)
            If ((Local5 == Zero))
            {
                Local1 = CVF1 /* \_TZ_.CVF1 */
                Release (FMT1)
            }

            Local5 = Acquire (FMT2, 0x03E8)
            If ((Local5 == Zero))
            {
                Local2 = CVF2 /* \_TZ_.CVF2 */
                Release (FMT2)
            }

            Local5 = Acquire (FMT3, 0x03E8)
            If ((Local5 == Zero))
            {
                Local3 = CVF3 /* \_TZ_.CVF3 */
                Release (FMT3)
            }

            Local5 = Acquire (FMT4, 0x03E8)
            If ((Local5 == Zero))
            {
                Local4 = CVF4 /* \_TZ_.CVF4 */
                Release (FMT4)
            }

            \VFN0 = Local0
            \VFN1 = Local1
            \VFN2 = Local2
            \VFN3 = Local3
            \VFN4 = Local4
            If ((\_SB.PCI0.LPCB.H_EC.ECAV && ETMD))
            {
                Local5 = Acquire (\_SB.PCI0.LPCB.H_EC.ECMT, 0x03E8)
                If ((Local5 == Zero))
                {
                    If (((Local0 != Zero) && (Local1 != Zero)))
                    {
                        \_SB.PCI0.LPCB.H_EC.ECWT
                        AC0F (RefOf (\_SB.PCI0.LPCB.H_EC.PENV))
                    }
                    ElseIf (((Local0 == Zero) && (Local1 != Zero)))
                    {
                        \_SB.PCI0.LPCB.H_EC.ECWT
                        AC1F (RefOf (\_SB.PCI0.LPCB.H_EC.PENV))
                    }
                    Else
                    {
                        \_SB.PCI0.LPCB.H_EC.ECWT
                        Zero
                        RefOf (\_SB.PCI0.LPCB.H_EC.PENV)
                    }

                    \_SB.PCI0.LPCB.H_EC.ECMD
                    0x1A
                    Release (\_SB.PCI0.LPCB.H_EC.ECMT)
                }
            }
        }

        ThermalZone (TZ00)
        {
            Name (PTMP, 0x0BB8)
            Method (_SCP, 1, Serialized)  // _SCP: Set Cooling Policy
            {
                \CTYP = Arg0
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If (CondRefOf (\_PR.ACRT))
                {
                    If ((\_PR.ACRT != Zero))
                    {
                        Return ((0x0AAC + (\_PR.ACRT * 0x0A)))
                    }
                }

                Return ((0x0AAC + (\CRTT * 0x0A)))
            }

            Method (_AC0, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CondRefOf (\_PR.AAC0))
                {
                    If ((\_PR.AAC0 != Zero))
                    {
                        Return ((0x0AAC + (\_PR.AAC0 * 0x0A)))
                    }
                }

                Return ((0x0AAC + (\ACTT * 0x0A)))
            }

            Method (_AC1, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return ((0x0AAC + (\ACT1 * 0x0A)))
            }

            Method (_AC2, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return (((0x0AAC + (\ACT1 * 0x0A)) - 0x32))
            }

            Method (_AC3, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return (((0x0AAC + (\ACT1 * 0x0A)) - 0x64))
            }

            Method (_AC4, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return (((0x0AAC + (\ACT1 * 0x0A)) - 0x96))
            }

            Name (_AL0, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN0
            })
            Name (_AL1, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN1
            })
            Name (_AL2, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN2
            })
            Name (_AL3, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN3
            })
            Name (_AL4, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN4
            })
            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (!ETMD)
                {
                    Return (0x0BB8)
                }

                If (CondRefOf (\_PR.DTSE))
                {
                    If ((\_PR.DTSE == 0x03))
                    {
                        Return ((0x0B10 + (\CRTT * 0x0A)))
                    }
                }

                If (CondRefOf (\_PR.DTSE))
                {
                    If ((\_PR.DTSE == One))
                    {
                        If ((\_PR.PKGA == One))
                        {
                            Local0 = \_PR.PDTS /* External reference */
                            Return ((0x0AAC + (Local0 * 0x0A)))
                        }

                        Local0 = \_PR.DTS1 /* External reference */
                        If ((\_PR.DTS2 > Local0))
                        {
                            Local0 = \_PR.DTS2 /* External reference */
                        }

                        If ((\_PR.DTS3 > Local0))
                        {
                            Local0 = \_PR.DTS3 /* External reference */
                        }

                        If ((\_PR.DTS4 > Local0))
                        {
                            Local0 = \_PR.DTS4 /* External reference */
                        }

                        Return ((0x0AAC + (Local0 * 0x0A)))
                    }
                }

                If (\_SB.PCI0.LPCB.H_EC.ECAV)
                {
                    RefOf (\_SB.PCI0.LPCB.H_EC.PLMX) = \_SB.PCI0.LPCB.H_EC.ECRD /* External reference */
                    Local0
                    Local0 = (0x0AAC + (Local0 * 0x0A))
                    PTMP = Local0
                    Return (Local0)
                }

                Return (0x0BC2)
            }
        }

        ThermalZone (TZ01)
        {
            Name (PTMP, 0x0BB8)
            Method (_SCP, 1, Serialized)  // _SCP: Set Cooling Policy
            {
                \CTYP = Arg0
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If (CondRefOf (\_PR.ACRT))
                {
                    If ((\_PR.ACRT != Zero))
                    {
                        Return ((0x0AAC + (\_PR.ACRT * 0x0A)))
                    }
                }

                Return ((0x0AAC + (\CRTT * 0x0A)))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (!ETMD)
                {
                    Return (0x0BCC)
                }

                If (CondRefOf (\_PR.DTSE))
                {
                    If ((\_PR.DTSE == 0x03))
                    {
                        Return ((0x0B10 + (\CRTT * 0x0A)))
                    }
                }

                If (CondRefOf (\_PR.DTSE))
                {
                    If ((\_PR.DTSE == One))
                    {
                        If ((\_PR.PKGA == One))
                        {
                            Local0 = \_PR.PDTS /* External reference */
                            Return ((0x0AAC + (Local0 * 0x0A)))
                        }

                        Local0 = \_PR.DTS1 /* External reference */
                        If ((\_PR.DTS2 > Local0))
                        {
                            Local0 = \_PR.DTS2 /* External reference */
                        }

                        If ((\_PR.DTS3 > Local0))
                        {
                            Local0 = \_PR.DTS3 /* External reference */
                        }

                        If ((\_PR.DTS4 > Local0))
                        {
                            Local0 = \_PR.DTS4 /* External reference */
                        }

                        Return ((0x0AAC + (Local0 * 0x0A)))
                    }
                }

                If (\_SB.PCI0.LPCB.H_EC.ECAV)
                {
                    RefOf (\_SB.PCI0.LPCB.H_EC.PECH) = \_SB.PCI0.LPCB.H_EC.ECRD /* External reference */
                    Local0
                    Local0 *= 0x0A
                    RefOf (\_SB.PCI0.LPCB.H_EC.PECL) = \_SB.PCI0.LPCB.H_EC.ECRD /* External reference */
                    Local1
                    Local1 >>= 0x02
                    Local1 = ((Local1 * 0x0A) / 0x40)
                    Local0 += Local1
                    Local0 += 0x0AAC
                    PTMP = Local0
                    Return (Local0)
                }

                Return (0x0BD6)
            }

            Method (XPSL, 0, Serialized)
            {
                If ((\TCNT == 0x08))
                {
                    Return (Package (0x08)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3, 
                        \_PR.CPU4, 
                        \_PR.CPU5, 
                        \_PR.CPU6, 
                        \_PR.CPU7
                    })
                }

                If ((\TCNT == 0x04))
                {
                    Return (Package (0x04)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3
                    })
                }

                If ((\TCNT == 0x02))
                {
                    Return (Package (0x02)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }

            Method (XPSV, 0, Serialized)
            {
                If (CondRefOf (\_PR.APSV))
                {
                    If ((\_PR.APSV != Zero))
                    {
                        Return ((0x0AAC + (\_PR.APSV * 0x0A)))
                    }
                }

                Return ((0x0AAC + (\PSVT * 0x0A)))
            }

            Method (XTC1, 0, Serialized)
            {
                Return (\TC1V) /* External reference */
            }

            Method (XTC2, 0, Serialized)
            {
                Return (\TC2V) /* External reference */
            }

            Method (XTSP, 0, Serialized)
            {
                Return (\TSPV) /* External reference */
            }
        }
    }
}

