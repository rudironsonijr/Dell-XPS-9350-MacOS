/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT2.aml, Wed Jan 11 10:33:57 2023
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
    External (_SB_.GGOV, MethodObj)    // Warning: Unknown method, guessing 0 arguments
    External (_SB_.PCI0.I2C0.DFUD, UnknownObj)
    External (_SB_.SGOV, MethodObj)    // Warning: Unknown method, guessing 2 arguments
    External (BID_, UnknownObj)
    External (SDS0, UnknownObj)
    External (USBH, UnknownObj)

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
                                0x02010016 = \_SB.GGOV ()
                                OLDV
                                \_SB.SGOV (0x02010016, PGCE)
                                If ((PGCD > Zero))
                                {
                                    Sleep (PGCD)
                                    \_SB.GGOV ()
                                    0x02010016
                                    OLDV
                                }

                                If ((\_SB.GGOV () == 0x02010016))
                                {
                                    One
                                    Sleep (0x96)
                                    If ((\_SB.GGOV () == 0x02010014))
                                    {
                                        One
                                    }
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
                                0x02010014 = \_SB.GGOV ()
                                OLDV
                                \_SB.GGOV ()
                                0x02010014
                                DFUE
                                If ((DFUD > Zero))
                                {
                                    Sleep (DFUD)
                                    \_SB.GGOV ()
                                    0x02010014
                                    OLDV
                                }

                                Return (Zero)
                            }
                            Case (0x03)
                            {
                                0x02010014 = \_SB.GGOV ()
                                DFUV
                                0x02010016 = \_SB.GGOV ()
                                PGCV
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

