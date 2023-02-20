DefinitionBlock ("", "SSDT", 2, "hack", "TYPC", 0x00000000)
{

    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01.PXSX, DeviceObj)

    External (TBSE, FieldUnitObj)                     // TB root port number
    External (TBSF, FieldUnitObj)
    External (TNAT, FieldUnitObj)                    // Native hot plug
    External (TBSF, FieldUnitObj)
    External (SOHP, FieldUnitObj)                    // SMI on Hot Plug
    External (GP5F, FieldUnitObj)
    External (NOHP, FieldUnitObj)                    // Notify HotPlug
    External (WKFN, FieldUnitObj)
    External (TBTS, IntObj)                          // TB enabled
    External (TARS, FieldUnitObj)
    External (FPEN, FieldUnitObj)
    External (UWAB, FieldUnitObj)
    External (USBP, FieldUnitObj)



    External (_SB_.PCI0.GPCB, MethodObj)            // get PCI MMIO base
    External (MMRP, MethodObj)                        // Memory mapped root port
    External (MMTB, MethodObj)                        // Memory mapped TB port
    External (DTGP, MethodObj)    // 5 Arguments
    External (DBG1, MethodObj)    // 1 Arguments
    External (DBG2, MethodObj)    // 2 Arguments
    External (DBG3, MethodObj)    // 3 Arguments

    Scope (\_SB.PCI0.RP01)
    {
        Method (OHPE, 0, NotSerialized)
        {
            Return (One)
        }

        /**
        * Get PCI base address
        * Arg0 = bus, Arg1 = device, Arg2 = function
        */
        Method (MMIO, 3, NotSerialized)
        {
            Local0 = \_SB.PCI0.GPCB () // base address
            Local0 += (Arg0 << 20)
            Local0 += (Arg1 << 15)
            Local0 += (Arg2 << 12)
            Return (Local0)
        }

        Name (R020, Zero) // RP base/limit from UEFI
        Name (R024, Zero) // RP prefetch base/limit from UEFI
        Name (R118, Zero) // UPSB Pri Bus = RP Sec Bus (UEFI)
        Name (R119, Zero) // UPSB Sec Bus = RP Sec Bus + 1
        Name (R11A, Zero) // UPSB Sub Bus = RP Sub Bus (UEFI)
        Name (R11C, Zero) // UPSB IO base/limit = RP IO base/limit (UEFI)
        Name (R120, Zero) // UPSB mem base/limit = RP mem base/limit (UEFI)
        Name (R124, Zero) // UPSB pre base/limit = RP pre base/limit (UEFI)

        Name (R218, Zero) // DSB0 Pri Bus = UPSB Sec Bus
        Name (R219, Zero) // DSB0 Sec Bus = UPSB Sec Bus + 1
        Name (R21A, Zero) // DSB0 Sub Bus = UPSB Sub Bus
        Name (R21C, Zero) // DSB0 IO base/limit = UPSB IO base/limit
        Name (R220, Zero) // DSB0 mem base/limit = UPSB mem base/limit
        Name (R224, Zero) // DSB0 pre base/limit = UPSB pre base/limit

        Name (R318, Zero) // DSB1 Pri Bus = UPSB Sec Bus
        Name (R319, Zero) // DSB1 Sec Bus = UPSB Sec Bus + 2
        Name (R31A, Zero) // DSB1 Sub Bus = no children
        Name (R31C, Zero) // DSB1 disable IO
        Name (R320, Zero) // DSB1 disable mem
        Name (R324, Zero) // DSB1 disable prefetch

        Name (R418, Zero) // DSB2 Pri Bus = UPSB Sec Bus
        Name (R419, Zero) // DSB2 Sec Bus = UPSB Sec Bus + 3
        Name (R41A, Zero) // DSB2 Sub Bus = no children
        Name (R41C, Zero) // DSB2 disable IO
        Name (R420, Zero) // DSB2 disable mem
        Name (R424, Zero) // DSB2 disable prefetch
        Name (RVES, Zero) // DSB2 offset 0x564, unknown

//        Name (R518, Zero) // DSB4 Pri Bus = UPSB Sec Bus
//        Name (R519, Zero) // DSB4 Sec Bus = UPSB Sec Bus + 4
//        Name (R51A, Zero) // DSB4 Sub Bus = no children
//        Name (R51C, Zero) // DSB4 disable IO
//        Name (R520, Zero) // DSB4 disable mem
//        Name (R524, Zero) // DSB4 disable prefetch
        Name (R618, Zero)
        Name (R619, Zero)
        Name (R61A, Zero)
        Name (R61C, Zero)
        Name (R620, Zero)
        Name (R624, Zero)
        Name (RH10, Zero) // NHI0 BAR0 = DSB0 mem base
        Name (RH14, Zero) // NHI0 BAR1 unused


        Name (R028, Zero)
        Name (R02C, Zero)

//        Name (R118, Zero)
//        Name (R119, Zero)
//        Name (R11A, Zero)
//        Name (R11C, Zero)
//        Name (R120, Zero)
//        Name (R124, Zero)
        Name (R128, Zero)
        Name (R12C, Zero)

//        Name (R218, Zero)
//        Name (R219, Zero)
//        Name (R21A, Zero)
//        Name (R21C, Zero)
//        Name (R220, Zero)
//        Name (R224, Zero)
        Name (R228, Zero)
        Name (R22C, Zero)

//        Name (R318, Zero)
//        Name (R319, Zero)
//        Name (R31A, Zero)
//        Name (R31C, Zero)
//        Name (R320, Zero)
//        Name (R324, Zero)
        Name (R328, Zero)
        Name (R32C, Zero)

//        Name (R418, Zero)
//        Name (R419, Zero)
//        Name (R41A, Zero)
//        Name (R41C, Zero)
//        Name (R420, Zero)
//        Name (R424, Zero)
        Name (R428, Zero)
        Name (R42C, Zero)
//        Name (RVES, Zero)

//        Name (R518, Zero)
//        Name (R519, Zero)
//        Name (R51A, Zero)
//        Name (R51C, Zero)
//        Name (R520, Zero)
//        Name (R524, Zero)
//        Name (R528, Zero)
//        Name (R52C, Zero)
//        Name (R618, Zero)
//        Name (R619, Zero)
//        Name (R61A, Zero)
//        Name (R61C, Zero)
//        Name (R620, Zero)
//        Name (R624, Zero)
//        Name (R628, Zero)
//        Name (R62C, Zero)

//        Name (RH10, Zero)
//        Name (RH14, Zero)

//        Name (EICM, Zero)
//        Name (POC0, Zero)

        Name (POC0, Zero)

        // Root port configuration base
        OperationRegion (RPSM, SystemMemory, MMRP(), 0x54)
        Field (RPSM, DWordAcc, NoLock, Preserve)
        {
            RPVD,   32,
            RPR4,   8,
            Offset (0x18),
            RP18,   8,
            RP19,   8,
            RP1A,   8,
            Offset (0x1C),
            RP1C,   16,
            Offset (0x20),
            R_20,   32,
            R_24,   32,
            R_28,   32,
            R_2C,   32,
            Offset (0x52),
                ,   11,
            RPLT,   1,
            Offset (0x54)
        }

        // PXSX (up stream port) configuration base
        OperationRegion (UPSM, SystemMemory, 0x00000000EF000000, 0x0550)
        Field (UPSM, DWordAcc, NoLock, Preserve)
        {
            UPVD,   32,
            UP04,   8,
            Offset (0x08),
            CLRD,   32,
            Offset (0x18),
            UP18,   8,
            UP19,   8,
            UP1A,   8,
            Offset (0x1C),
            UP1C,   16,
            Offset (0x20),
            UP20,   32,
            UP24,   32,
            UP28,   32,
            UP2C,   32,
            Offset (0xD2),
                ,   11,
            UPLT,   1,
            Offset (0xD4),
            Offset (0x544),
            UPMB,   1,
            Offset (0x548),
            T2PR,   32,
            P2TR,   32
        }

        // DSB0 configuration base
        OperationRegion (DNSM, SystemMemory, MMIO (UP19, 0, 0), 0xD4)
        Field (DNSM, DWordAcc, NoLock, Preserve)
        {
            DPVD,   32,
            DP04,   8,
            Offset (0x18),
            DP18,   8,
            DP19,   8,
            DP1A,   8,
            Offset (0x1C),
            DP1C,   16,
            Offset (0x20),
            DP20,   32,
            DP24,   32,
            DP28,   32,
            DP2C,   32,
            Offset (0xD2),
                ,   11,
            DPLT,   1,
            Offset (0xD4)
        }

        // DSB1 configuration base
        OperationRegion (DS3M, SystemMemory, MMIO (UP19, 1, 0), 0x40)
        Field (DS3M, DWordAcc, NoLock, Preserve)
        {
            D3VD,   32,
            D304,   8,
            Offset (0x18),
            D318,   8,
            D319,   8,
            D31A,   8,
            Offset (0x1C),
            D31C,   16,
            Offset (0x20),
            D320,   32,
            D324,   32,
            D328,   32,
            D32C,   32
        }

        // DSB2 configuration base
        OperationRegion (DS4M, SystemMemory, MMIO (UP19, 2, 0), 0x0568)
        Field (DS4M, DWordAcc, NoLock, Preserve)
        {
            D4VD,   32,
            D404,   8,
            Offset (0x18),
            D418,   8,
            D419,   8,
            D41A,   8,
            Offset (0x1C),
            D41C,   16,
            Offset (0x20),
            D420,   32,
            D424,   32,
            D428,   32,
            D42C,   32,
            Offset (0x564),
            DVES,   32
        }

        OperationRegion (NHIM, SystemMemory, MMIO (DP19, Zero, Zero), 0x40)
        Field (NHIM, DWordAcc, NoLock, Preserve)
        {
            NH00,   32,
            NH04,   8,
            Offset (0x10),
            NH10,   32,
            NH14,   32
        }

        OperationRegion (RSTR, SystemMemory, NH10 + 0x39858, 0x0100)
        Field (RSTR, DWordAcc, NoLock, Preserve)
        {
            CIOR,   32,
            Offset (0xB8),
            ISTA,   32,
            Offset (0xEC),
            ICME,   32
        }

        Method (TBTC, 1, Serialized)
        {
            P2TR = Arg0
            Local0 = 0x64
            Local1 = T2PR /* \_SB_.PCI0.RP01.T2PR */
            While (((Local2 = (Local1 & One)) == Zero))
            {
                If ((Local1 == 0xFFFFFFFF))
                {
                    Return (Zero)
                }

                Local0--
                If ((Local0 == Zero))
                {
                    Break
                }

                Local1 = T2PR /* \_SB_.PCI0.RP01.T2PR */
                Sleep (0x32)
            }

            P2TR = Zero
        }

        Method (UPCK, 0, Serialized)
        {
            If (((UPVD & 0xFFFF) == 0x8086))
            {
                Return (One)
            }
            Else
            {
                Return (Zero)
            }
        }

        Name (IIP3, Zero)
        Name (PRSR, Zero)
        Name (PCIA, One)
        Method (PCEU, 0, Serialized)
        {
            \_SB.PCI0.RP01.PRSR = Zero
            If ((\_SB.PCI0.RP01.PSTA != Zero))
            {
                \_SB.PCI0.RP01.PRSR = One
                \_SB.PCI0.RP01.PSTA = Zero
            }

            If ((\_SB.PCI0.RP01.LDXX == One))
            {
                \_SB.PCI0.RP01.PRSR = One
                \_SB.PCI0.RP01.LDXX = Zero
            }
        }

        Method (PCDA, 0, Serialized)
        {
            If ((\_SB.PCI0.RP01.POFF () != Zero))
            {
                \_SB.PCI0.RP01.PCIA = Zero
                \_SB.PCI0.RP01.PSTA = 0x03
                \_SB.PCI0.RP01.LDXX = One
                Local5 = (Timer + 0x00989680)
                While ((Timer <= Local5))
                {
                    If ((\_SB.PCI0.RP01.LACR == One))
                    {
                        If ((\_SB.PCI0.RP01.LACT == Zero))
                        {
                            Break
                        }
                    }
                    ElseIf ((\_SB.PCI0.RP01.PXSX.AVND == 0xFFFFFFFF))
                    {
                        Break
                    }

                    Sleep (0x0A)
                }

                \_SB.PCI0.RP01.GPCI = Zero
                \_SB.PCI0.RP01.UGIO ()
            }
            Else
            {
            }

            \_SB.PCI0.RP01.IIP3 = One
        }

        Method (POFF, 0, Serialized)
        {
            Return ((!\_SB.PCI0.RP01.RTBT && !\_SB.PCI0.RP01.RUSB))
        }

        Name (GPCI, One)
        Name (GNHI, One)
        Name (GXCI, One)
        Name (RTBT, One)
        Name (RUSB, One)
        Name (CTPD, Zero)
        Method (CTBT, 0, Serialized)
        {
            If ((\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
            {
                Local2 = \_SB.PCI0.RP01.PXSX.CRMW (0x3C, Zero, 0x02, 0x04000000, 0x04000000)
                If ((Local2 == Zero))
                {
                    \_SB.PCI0.RP01.CTPD = One
                }
            }
        }

        Method (UGIO, 0, Serialized)
        {
            Local0 = (\_SB.PCI0.RP01.GNHI || \_SB.PCI0.RP01.RTBT)
            Local1 = (\_SB.PCI0.RP01.GXCI || \_SB.PCI0.RP01.RUSB)
            DBG3 ("UGIO", Local0, Local1)
            If ((\_SB.PCI0.RP01.GPCI != Zero))
            {
                If (((Local0 == Zero) && (Local1 == Zero)))
                {
                    Local0 = One
                    Local1 = One
                }
            }

            Local2 = Zero
            If ((Local0 != Zero))
            {
                If (Zero)
                {
                    Local2 = One
                    \_SB.PCI0.RP01.CTPD = Zero
                }
            }

            If ((Local1 != Zero))
            {
                If (Zero)
                {
                    Local2 = One
                }
            }

            If ((Local2 != Zero))
            {
                Sleep (0x01F4)
            }

            Local3 = Zero
            If ((Local0 == Zero))
            {
                If (Zero)
                {
                    \_SB.PCI0.RP01.CTBT ()
                    If ((\_SB.PCI0.RP01.CTPD != Zero))
                    {
                        Local3 = One
                    }
                }
            }

            If ((Local1 == Zero))
            {
                If (Zero)
                {
                    Local3 = One
                }
            }

            If ((Local3 != Zero))
            {
                Sleep (0x64)
            }

            DBG3 ("UGIO finish", Local2, Local3)
            Return (Local2)
        }

        /**
        * Thunderbolt status
        */
        Method (TBST, 0, Serialized)
        {
            Debug = Concatenate ("TB:TBST - MDUV: ", \_SB.PCI0.RP01.PXSX.MDUV)
            Debug = Concatenate ("TB:TBST - NHI: ", \_SB.PCI0.RP01.NH00)
            Debug = Concatenate ("TB:TBST - Root port: ", \_SB.PCI0.RP01.RPVD)
            Debug = Concatenate ("TB:TBST - Upstream port: ", \_SB.PCI0.RP01.UPVD)
            Debug = Concatenate ("TB:TBST - DSB0: ", \_SB.PCI0.RP01.DPVD)
            Debug = Concatenate ("TB:TBST - DSB1: ", \_SB.PCI0.RP01.D3VD)
            Debug = Concatenate ("TB:TBST - DSB2: ", \_SB.PCI0.RP01.D4VD)
        }

        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
        {
            PCEU ()
        }

        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
        {
            If ((\_SB.PCI0.RP01.POFF () != Zero))
            {
                \_SB.PCI0.RP01.CTBT ()
            }

            PCDA ()
        }

        Method (UTLK, 2, Serialized)
        {
            Local0 = Zero
            If (Zero)
            {
                \_SB.PCI0.RP01.PSTA = Zero
                While (One)
                {
                    If ((\_SB.PCI0.RP01.LDXX == One))
                    {
                        \_SB.PCI0.RP01.LDXX = Zero
                    }

                    Local1 = Zero
                    Local2 = (Timer + 0x00989680)
                    While ((Timer <= Local2))
                    {
                        If ((\_SB.PCI0.RP01.LACR == Zero))
                        {
                            If ((\_SB.PCI0.RP01.LTRN != One))
                            {
                                Break
                            }
                        }
                        ElseIf (((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One)))
                        {
                            Break
                        }

                        Sleep (0x0A)
                    }

                    Sleep (Arg1)
                    While ((Timer <= Local2))
                    {
                        If ((\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
                        {
                            Local1 = One
                            Break
                        }

                        Sleep (0x0A)
                    }

                    If ((Local1 == One))
                    {
                        \_SB.PCI0.RP01.MABT = One
                        Break
                    }

                    If ((Local0 == 0x04))
                    {
                        Break
                    }

                    Local0++
                    Sleep (0x03E8)
                }
            }
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

        OperationRegion (HD94, PCI_Config, 0x0D94, 0x08)
        Field (HD94, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04),
            PLEQ,   1,
            Offset (0x08)
        }

        OperationRegion (A1E1, PCI_Config, 0x40, 0x40)
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
            LDXX,   1,
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

        OperationRegion (A1E2, PCI_Config, 0xA0, 0x08)
        Field (A1E2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x01),
            Offset (0x02),
            Offset (0x04),
            PSTA,   2
        }

        Method (TGPE, 0, Serialized)
        {
            Debug = "TB:TGPE"

            Notify (\_SB.PCI0.RP01, 0x02) // Device Wake
        }

        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (Zero)
        }

//        Method (_INI, 0, NotSerialized)
//        {
//            Concatenate("TB:INIT: TBSF - Thunderbolt(TM) SMI Function Number: ", TBSF, Debug)
//            Concatenate("TB:INIT: SOHP - SMI on Hot Plug for TBT devices: ", SOHP, Debug)
//            // Concatenate("TB:INIT: TWIN - TbtWin10Support: ", TWIN, Debug)
//            Concatenate("TB:INIT: GP5F - Gpio filter to detect USB Hotplug event: ", GP5F, Debug)
//            Concatenate("TB:INIT: NOHP - Notify on Hot Plug for TBT devices: ", NOHP, Debug)
//            Concatenate("TB:INIT: TBSE - Thunderbolt(TM) Root port selector: ", TBSE, Debug)
//            Concatenate("TB:INIT: WKFN - WAK Finished: ", WKFN, Debug)
//            Concatenate("TB:INIT: TBTS - Thunderbolt support: ", TBTS, Debug)
//            Concatenate("TB:INIT: TARS - TbtAcpiRemovalSupport: ", TARS, Debug)
//            Concatenate("TB:INIT: FPEN - TbtFrcPwrEn: ", FPEN, Debug)
//            // Concatenate("TB:INIT: FPG1 - TbtFrcPwrGpioNo: ", FPG1, Debug)
//            // Concatenate("TB:INIT: FP1L - TbtFrcPwrGpioLevel: ", FP1L, Debug)
//            // Concatenate("TB:INIT: CPG1 - TbtCioPlugEventGpioNo: ", CPG1, Debug)
//            // Concatenate("TB:INIT: TRWA - Titan Ridge Osup command: ", TRWA, Debug)
//            // Concatenate("TB:INIT: TBOD - Rtd3TbtOffDelay TBT RTD3 Off Delay: ", TBOD, Debug)
//            // Concatenate("TB:INIT: TSXW - TbtSxWakeSwitchLogicEnable Set True if TBT_WAKE_N will be routed to PCH WakeB at Sx entry point. HW logic is required: ", TSXW, Debug)
//            // Concatenate("TB:INIT: RTBT - Enable Rtd3 support for TBT: ", RTBT, Debug)
//            // Concatenate("TB:INIT: RTBC - Enable TBT RTD3 CLKREQ mask: ", RTBC, Debug)
//            // Concatenate("TB:INIT: TBCD - TBT RTD3 CLKREQ mask delay: ", TBCD, Debug)

//            Concatenate("TB:INIT: USBP - Allow USB2 PHY Core Power Gating (ALLOW_USB2_CORE_PG): ", USBP, Debug)
//            Concatenate("TB:INIT: UWAB - USB2 Workaround Available: ", UWAB, Debug)
//            // Concatenate("TB:INIT: USME - Disables HS01/HS01@XHC2 & Switches SSP1/SSP2@XHC2 -> 0x0A (maybe like U2OP?) ???: ", USME, Debug)
//            // Concatenate("TB:INIT: USTC - USBC-if enabled (UBTC) ???: ", USTC, Debug)
//            // Concatenate("TB:INIT: TBAS - Enables HS03/04@XHC1 ???: ", TBAS, Debug)
//            Concatenate("TB:INIT: MMRP(): ", MMRP(), Debug)

//            Debug = "TB:INIT: TB enabled"
//            Debug = "TB:INIT: TB native mode enabled"
//            Debug = "TB:INIT - Save Ridge Config on Boot ICM"

//            R020 = R_20 /* \_SB.PCI0.RP01.R_20 */
//            R024 = R_24 /* \_SB.PCI0.RP01.R_24 */
//            R028 = R_28 /* \_SB.PCI0.RP01.R_28 */
//            R02C = R_2C /* \_SB.PCI0.RP01.R_2C */

//            R118 = UP18 /* \_SB.PCI0.RP01.UP18 */
//            R119 = UP19 /* \_SB.PCI0.RP01.UP19 */
//            R11A = UP1A /* \_SB.PCI0.RP01.UP1A */
//            R11C = UP1C /* \_SB.PCI0.RP01.UP1C */
//            R120 = UP20 /* \_SB.PCI0.RP01.UP20 */
//            R124 = UP24 /* \_SB.PCI0.RP01.UP24 */
//            R128 = UP28 /* \_SB.PCI0.RP01.UP28 */
//            R12C = UP2C /* \_SB.PCI0.RP01.UP2C */

//            R218 = DP18 /* \_SB.PCI0.RP01.DP18 */
//            R219 = DP19 /* \_SB.PCI0.RP01.DP19 */
//            R21A = DP1A /* \_SB.PCI0.RP01.DP1A */
//            R21C = DP1C /* \_SB.PCI0.RP01.DP1C */
//            R220 = DP20 /* \_SB.PCI0.RP01.DP20 */
//            R224 = DP24 /* \_SB.PCI0.RP01.DP24 */
//            R228 = DP28 /* \_SB.PCI0.RP01.DP28 */

//            R318 = D318 /* \_SB.PCI0.RP01.D318 */
//            R319 = D319 /* \_SB.PCI0.RP01.D319 */
//            R31A = D31A /* \_SB.PCI0.RP01.D31A */
//            R31C = D31C /* \_SB.PCI0.RP01.D31C */
//            R320 = D320 /* \_SB.PCI0.RP01.D320 */
//            R324 = D324 /* \_SB.PCI0.RP01.D324 */
//            R328 = D328 /* \_SB.PCI0.RP01.D328 */
//            R32C = D32C /* \_SB.PCI0.RP01.D32C */

//            R418 = D418 /* \_SB.PCI0.RP01.D418 */
//            R419 = D419 /* \_SB.PCI0.RP01.D419 */
//            R41A = D41A /* \_SB.PCI0.RP01.D41A */
//            R41C = D41C /* \_SB.PCI0.RP01.D41C */
//            R420 = D420 /* \_SB.PCI0.RP01.D420 */
//            R424 = D424 /* \_SB.PCI0.RP01.D424 */
//            R428 = D428 /* \_SB.PCI0.RP01.D428 */
//            R42C = D42C /* \_SB.PCI0.RP01.D42C */

//            RVES = DVES /* \_SB.PCI0.RP01.DVES */

//            RH10 = NH10 /* \_SB.PCI0.RP01.NH10 */
//            RH14 = NH14 /* \_SB.PCI0.RP01.NH14 */
//            Debug = "TB:INIT - Store Complete"

//            Sleep (One)

//            ICMD ()
//        }

        /**
        * ICM Disable

        * Disable ICM to allow the OSX-driver to take control
        *
        * #define REG_FW_STS			        0x39944
        * #define REG_FW_STS_NVM_AUTH_DONE	    BIT(31)
        * #define REG_FW_STS_CIO_RESET_REQ	    BIT(30)
        * #define REG_FW_STS_ICM_EN_CPU		BIT(2)
        * #define REG_FW_STS_ICM_EN_INVERT	    BIT(1)
        * #define REG_FW_STS_ICM_EN		    BIT(0)
        *
        * Source: https://github.com/torvalds/linux/blob/master/drivers/thunderbolt/nhi.h
        */
        Method (ICMD, 0, NotSerialized)
        {
            Debug = "TB:ICMD - Disable ICM "
            \_SB.PCI0.RP01.POC0 = One
            Debug = Concatenate ("TB:ICMD - ICME 1: ", \_SB.PCI0.RP01.ICME)
            If (\_SB.PCI0.RP01.ICME != 0x800001A3)
            {
                If (\_SB.PCI0.RP01.CNHI ())
                {
                    Debug = Concatenate ("TB:ICMD - ICME 2: ", \_SB.PCI0.RP01.ICME)
                    If (\_SB.PCI0.RP01.ICME != 0xFFFFFFFF)
                    {
                        \_SB.PCI0.RP01.WTLT ()
                        Debug = Concatenate ("TB:ICMD - ICME 3: ", \_SB.PCI0.RP01.ICME)
                        If (!Local0 = (\_SB.PCI0.RP01.ICME & 0x80000000)) // NVM started means we need reset
                        {
                            Debug = "TB:ICMD - NVM already started, resetting"
                            // \_SB.PCI0.RP01.ICME = 0x102 // REG_FW_STS_ICM_EN_INVERT
                            \_SB.PCI0.RP01.ICME |= 0x06 // invert EN | enable CPU

                            Local0 = 1000
                            While ((Local1 = (\_SB.PCI0.RP01.ICME & 0x80000000)) == Zero)
                            {
                                Local0--
                                If (Local0 == Zero)
                                {
                                    Break
                                }

                                Sleep (One)
                            }

                            Debug = Concatenate ("TB:ICMD - ICME 4: ", \_SB.PCI0.RP01.ICME)

                            Sleep (1000)
                        }
                    }
                }
            }

            \_SB.PCI0.RP01.POC0 = Zero
        }

        // /**
        //  * Plug detection for Windows
        //  */
        // Method (CMPE, 0, Serialized)
        // {
        //     Debug = "TB:CMPE"

        //     Notify (\_SB.PCI0.RP01, Zero) // Bus Check
        // }

        Method (CNHI, 0, Serialized)
        {
            Debug = "TB:CNHI"

            Local0 = 10

            Debug = "TB:CNHI - Configure root port"
            While (Local0)
            {
                R_20 = R020 // Memory Base/Limit
                R_24 = R024 // Prefetch Base/Limit
                R_28 = R028 /* \_SB.PCI0.RP01.R028 */
                R_2C = R02C /* \_SB.PCI0.RP01.R02C */
                RPR4 = 0x07 // Command

                If (R020 == R_20) // read back check
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (R020 != R_20) // configure root port failed
            {
                Debug = "TB:CNHI - Error: configure root port failed"

                Return (Zero)
            }

            Local0 = 10

            Debug = "TB:CNHI - Configure UPSB"
            While (Local0)
            {

                UP18 = R118 // UPSB Pri Bus
                UP19 = R119 // UPSB Sec Bus
                UP1A = R11A // UPSB Sub Bus
                UP1C = R11C // UPSB IO Base/Limit
                UP20 = R120 // UPSB Memory Base/Limit
                UP24 = R124 // UPSB Prefetch Base/Limit
                UP28 = R128 /* \_SB.PCI0.RP01.R128 */
                UP2C = R12C /* \_SB.PCI0.RP01.R12C */
                UP04 = 0x07 // Command

                If (R119 == UP19) // read back check
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (R119 != UP19) // configure UPSB failed
            {
                Debug = "TB:CNHI - Error: configure UPSB failed"

                Return (Zero)
            }

            Debug = "TB:CNHI - Wait for link training"
            If (WTLT () != One)
            {
                Debug = "TB:CNHI - Error: Wait for link training failed"

                Return (Zero)
            }

            Local0 = 10

            // Configure DSB0
            Debug = "TB:CNHI - Configure DSB"
            While (Local0)
            {
                DP18 = R218 // Pri Bus
                DP19 = R219 // Sec Bus
                DP1A = R21A // Sub Bus
                DP1C = R21C // IO Base/Limit
                DP20 = R220 // Memory Base/Limit
                DP24 = R224 // Prefetch Base/Limit
                DP28 = R228 /* \_SB.PCI0.RP01.R228 */
                DP2C = R22C /* \_SB.PCI0.RP01.R22C */
                DP04 = 0x07 // Command
                Debug = "TB:CNHI - Configure NHI Dp 0 done"

                D318 = R318 // Pri Bus
                D319 = R319 // Sec Bus
                D31A = R31A // Sub Bus
                D31C = R31C // IO Base/Limit
                D320 = R320 // Memory Base/Limit
                D324 = R324 // Prefetch Base/Limit
                D328 = R328 /* \_SB.PCI0.RP01.R328 */
                D32C = R32C /* \_SB.PCI0.RP01.R32C */
                D304 = 0x07 // Command
                Debug = "TB:CNHI - Configure NHI Dp 3 done"

                D418 = R418 // Pri Bus
                D419 = R419 // Sec Bus
                D41A = R41A // Sub Bus
                D41C = R41C // IO Base/Limit
                D420 = R420 // Memory Base/Limit
                D424 = R424 // Prefetch Base/Limit
                D428 = R428 /* \_SB.PCI0.RP01.R428 */
                D42C = R42C /* \_SB.PCI0.RP01.R42C */
                DVES = RVES // DSB2 0x564
                D404 = 0x07 // Command
                Debug = "TB:CNHI - Configure NHI Dp 4 done"

                // D518 = R518 // Pri Bus
                // D519 = R519 // Sec Bus
                // D51A = R51A // Sub Bus
                // D51C = R51C // IO Base/Limit
                // D520 = R520 // Memory Base/Limit
                // D524 = R524 // Prefetch Base/Limit
                // D528 = R528 /* \_SB.PCI0.RP01.R528 */
                // D52C = R52C /* \_SB.PCI0.RP01.R52C */
                // D504 = 0x07 // Command
                // Debug = "TB:CNHI - Configure NHI Dp 5 done"

                If (R219 == DP19)
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (R219 != DP19) // configure DSB failed
            {
                Debug = "TB:CNHI - Error: configure DSB failed"

                Return (Zero)
            }

            If (WTDL () != One)
            {
                Debug = "TB:CNHI - Error: Configure NHI DPs failed"

                Return (Zero)
            }

            // Configure NHI
            Debug = "TB:CNHI - Configure NHI"

            Local0 = 100

            While (Local0)
            {
                NH10 = RH10 // NHI BAR 0
                NH14 = RH14 // NHI BAR 1
                NH04 = 0x07 // NHI Command

                If (RH10 == NH10)
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (RH10 != NH10) // configure failed
            {
                Debug = "TB:CNHI - Error: Configure NHI failed"

                Return (Zero)
            }

            Debug = "TB:CNHI - Configure NHI0 done"

            Return (One)
        }

        /**
        * Wait for downlink training
        */
        Method (WTDL, 0, Serialized)
        {
            // Debug = "TB:WTDL"

            Local0 = 2000
            Local1 = Zero
            While (Local0)
            {
                If (RPR4 == 0x07)
                {
                    If (DLTC ())
                    {
                        If (UPCK ())
                        {
                            Local1 = One
                            Break
                        }
                    }
                }

                Sleep (One)
                Local0--
            }

            Return (Local1)
        }

        /**
        * Wait for link training
        */
        Method (WTLT, 0, Serialized)
        {
            Debug = "TB:WTLT"

            Local0 = 2000
            Local1 = Zero

            While (Local0)
            {
                If (RPR4 == 0x07)
                {
                    If (ULTC ())
                    {
                        If (UPCK ())
                        {
                            Local1 = One
                            Break
                        }
                    }
                }

                Sleep (One)
                Local0--
            }

            Return (Local1)
        }

        /**
        * Downlink training check
        */
        Method (DLTC, 0, Serialized)
        {
            Debug = "TB:DLTC"

            If (RPLT == Zero)
            {
                If (UPLT == Zero)
                {
                    If (DPLT == Zero)
                    {
                        Return (One)
                    }
                }
            }

            Return (Zero)
        }

        /**
        * Uplink training check
        */
        Method (ULTC, 0, Serialized)
        {
            Debug = "TB:ULTC"

            If (RPLT == Zero)
            {
                If (UPLT == Zero)
                {
                    Return (One)
                }
            }

            Return (Zero)
        }

        Scope (PXSX)
        {
            Name (MDUV, One) // plug status
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
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
                Return (SECB) /* \_SB_.PCI0.RP01.PXSX.SECB */
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (One)
            }

                        /**
             * Hotplug notify
             * Called by ACPI
             */
            Method (AMPE, 0, Serialized)
            {
                Notify (\_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero) // Bus Check
            }

            Method (PCED, 0, Serialized)
            {
                \_SB.PCI0.RP01.GPCI = One
                If ((\_SB.PCI0.RP01.UGIO () != Zero))
                {
                    \_SB.PCI0.RP01.PRSR = One
                }

                Local0 = Zero
                Local1 = Zero
                If ((Local1 == Zero))
                {
                    If ((\_SB.PCI0.RP01.IIP3 != Zero))
                    {
                        \_SB.PCI0.RP01.PRSR = One
                        Local0 = One
                        \_SB.PCI0.RP01.LDXX = One
                    }
                }

                Local5 = (Timer + 0x00989680)
                If ((\_SB.PCI0.RP01.PRSR != Zero))
                {
                    Sleep (0x1E)
                    If (((Local0 != Zero) || (Local1 != Zero)))
                    {
                        \_SB.PCI0.RP01.TSPD = One
                        If ((Local1 != Zero)){}
                        ElseIf ((Local0 != Zero))
                        {
                            \_SB.PCI0.RP01.LDXX = Zero
                        }

                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP01.LACR == Zero))
                            {
                                If ((\_SB.PCI0.RP01.LTRN != One))
                                {
                                    Break
                                }
                            }
                            ElseIf (((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One)))
                            {
                                Break
                            }

                            Sleep (0x0A)
                        }

                        Sleep (0x78)
                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
                            {
                                Break
                            }

                            Sleep (0x0A)
                        }

                        \_SB.PCI0.RP01.TSPD = 0x03
                        \_SB.PCI0.RP01.LRTN = One
                    }

                    Local5 = (Timer + 0x00989680)
                    While ((Timer <= Local5))
                    {
                        If ((\_SB.PCI0.RP01.LACR == Zero))
                        {
                            If ((\_SB.PCI0.RP01.LTRN != One))
                            {
                                Break
                            }
                        }
                        ElseIf (((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One)))
                        {
                            Break
                        }

                        Sleep (0x0A)
                    }

                    Sleep (0xFA)
                }

                \_SB.PCI0.RP01.PRSR = Zero
                While ((Timer <= Local5))
                {
                    If ((\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
                    {
                        Break
                    }

                    Sleep (0x0A)
                }

                If ((\_SB.PCI0.RP01.CSPD != 0x03))
                {
                    If ((\_SB.PCI0.RP01.SSPD == 0x03))
                    {
                        If ((\_SB.PCI0.RP01.PXSX.SSPD == 0x03))
                        {
                            If ((\_SB.PCI0.RP01.TSPD != 0x03))
                            {
                                \_SB.PCI0.RP01.TSPD = 0x03
                            }

                            If ((\_SB.PCI0.RP01.PXSX.TSPD != 0x03))
                            {
                                \_SB.PCI0.RP01.PXSX.TSPD = 0x03
                            }

                            \_SB.PCI0.RP01.LRTN = One
                            Local2 = (Timer + 0x00989680)
                            While ((Timer <= Local2))
                            {
                                If ((\_SB.PCI0.RP01.LACR == Zero))
                                {
                                    If (((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)))
                                    {
                                        \_SB.PCI0.RP01.PCIA = One
                                        Local1 = One
                                        Break
                                    }
                                }
                                ElseIf ((((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One)) &&
                                    (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)))
                                {
                                    \_SB.PCI0.RP01.PCIA = One
                                    Local1 = One
                                    Break
                                }

                                Sleep (0x0A)
                            }
                        }
                        Else
                        {
                            \_SB.PCI0.RP01.PCIA = One
                        }
                    }
                    Else
                    {
                        \_SB.PCI0.RP01.PCIA = One
                    }
                }
                Else
                {
                    \_SB.PCI0.RP01.PCIA = One
                }

                \_SB.PCI0.RP01.IIP3 = Zero
            }

            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                PCED ()
                \_SB.PCI0.RP01.PXSX.CRMW (0x013E, Zero, 0x02, 0x0200, 0x0200)
                \_SB.PCI0.RP01.PXSX.CRMW (0x023E, Zero, 0x02, 0x0200, 0x0200)
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
                If ((\_SB.PCI0.RP01.UPCK () == Zero))
                {
                    \_SB.PCI0.RP01.UTLK (One, 0x03E8)
                }

                \_SB.PCI0.RP01.TBTC (0x05)
            }

            OperationRegion (H530, PCI_Config, 0x0530, 0x0C)
            Field (H530, DWordAcc, Lock, Preserve)
            {
                DWIX,   13,
                PORT,   6,
                SPCE,   2,
                CMD0,   1,
                CMD1,   1,
                CMD2,   1,
                    ,   6,
                PROG,   1,
                TMOT,   1,
                WDAT,   32,
                RDAT,   32
            }

            Method (CIOW, 4, Serialized)
            {
                WDAT = Arg3
                DWIX = Arg0
                PORT = Arg1
                SPCE = Arg2
                CMD0 = One
                CMD1 = Zero
                CMD2 = Zero
                TMOT = Zero
                PROG = One
                Local1 = One
                Local0 = 0x2710
                While ((Zero < Local0))
                {
                    If ((PROG == Zero))
                    {
                        Local1 = Zero
                        Break
                    }

                    Stall (0x19)
                    Local0--
                }

                If ((Local1 == Zero))
                {
                    Local1 = TMOT /* \_SB_.PCI0.RP01.PXSX.TMOT */
                }

                Return (Local1)
            }

            Method (CIOR, 3, Serialized)
            {
                RDAT = Zero
                DWIX = Arg0
                PORT = Arg1
                SPCE = Arg2
                CMD0 = Zero
                CMD1 = Zero
                CMD2 = Zero
                TMOT = Zero
                PROG = One
                Local1 = One
                Local0 = 0x2710
                While ((Zero < Local0))
                {
                    If ((PROG == Zero))
                    {
                        Local1 = Zero
                        Break
                    }

                    Stall (0x19)
                    Local0--
                }

                If ((Local1 == Zero))
                {
                    Local1 = TMOT /* \_SB_.PCI0.RP01.PXSX.TMOT */
                }

                If ((Local1 == Zero))
                {
                    Return (Package (0x02)
                    {
                        Zero,
                        RDAT
                    })
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        One,
                        RDAT
                    })
                }
            }

            Method (CRMW, 5, Serialized)
            {
                Local1 = One
                If ((\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
                {
                    Local3 = Zero
                    While ((Local3 <= 0x04))
                    {
                        Local2 = CIOR (Arg0, Arg1, Arg2)
                        If ((DerefOf (Local2 [Zero]) == Zero))
                        {
                            Local2 = DerefOf (Local2 [One])
                            Local2 &= ~Arg4
                            Local2 |= Arg3
                            Local2 = CIOW (Arg0, Arg1, Arg2, Local2)
                            If ((Local2 == Zero))
                            {
                                Local2 = CIOR (Arg0, Arg1, Arg2)
                                If ((DerefOf (Local2 [Zero]) == Zero))
                                {
                                    Local2 = DerefOf (Local2 [One])
                                    Local2 &= Arg4
                                    If ((Local2 == Arg3))
                                    {
                                        Local1 = Zero
                                        Break
                                    }
                                }
                            }
                        }

                        Local3++
                        Sleep (0x64)
                    }
                }

                DBG3 ("CRMW", Arg0, Local1)
                Return (Local1)
            }

            Device (DSB0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
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

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

                Name (IIP3, Zero)
                Name (PRSR, Zero)
                Name (PCIA, One)
                Method (PCEU, 0, Serialized)
                {
                    \_SB.PCI0.RP01.PXSX.DSB0.PRSR = Zero
                    If ((\_SB.PCI0.RP01.PXSX.DSB0.PSTA != Zero))
                    {
                        \_SB.PCI0.RP01.PXSX.DSB0.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB0.PSTA = Zero
                    }

                    If ((\_SB.PCI0.RP01.PXSX.DSB0.LDIS == One))
                    {
                        \_SB.PCI0.RP01.PXSX.DSB0.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB0.LDIS = Zero
                    }
                }

                Method (PCDA, 0, Serialized)
                {
                    If ((\_SB.PCI0.RP01.PXSX.DSB0.POFF () != Zero))
                    {
                        \_SB.PCI0.RP01.PXSX.DSB0.PCIA = Zero
                        \_SB.PCI0.RP01.PXSX.DSB0.PSTA = 0x03
                        \_SB.PCI0.RP01.PXSX.DSB0.LDIS = One
                        Local5 = (Timer + 0x00989680)
                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP01.PXSX.DSB0.LACR == One))
                            {
                                If ((\_SB.PCI0.RP01.PXSX.DSB0.LACT == Zero))
                                {
                                    Break
                                }
                            }
                            ElseIf ((\_SB.PCI0.RP01.PXSX.DSB0.NHI0.AVND == 0xFFFFFFFF))
                            {
                                Break
                            }

                            Sleep (0x0A)
                        }

                        \_SB.PCI0.RP01.GNHI = Zero
                        \_SB.PCI0.RP01.UGIO ()
                    }
                    Else
                    {
                    }

                    \_SB.PCI0.RP01.PXSX.DSB0.IIP3 = One
                }

                Method (POFF, 0, Serialized)
                {
                    Return (!\_SB.PCI0.RP01.RTBT)
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    PCEU ()
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    PCDA ()
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
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
                        Offset (0x10),
                        BAR1,   32,
                        Offset (0x18),
                        PRIB,   8,
                        SECB,   8,
                        SUBB,   8,
                        Offset (0x1E),
                            ,   13,
                        MABT,   1
                    }

                    Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                    {
                        PCED ()
                        \_SB.PCI0.RP01.CTBT ()
                    }

                    Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                    {
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Local0 = Package (0x03)
                        {
                            "power-save",
                            One,
                            Buffer (One)
                            {
                                    0x00                                             // .
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
                Name (_SUN, One)  // _SUN: Slot User Number
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

                Device (UPS0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (One)
                    }

                    Device (DSB0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (One)
                        }

                        Device (DEV0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                Return (0x0F)
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                Return (One)
                            }
                        }
                    }

                    Device (DSB3)
                    {
                        Name (_ADR, 0x00030000)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (One)
                        }

                        Device (UPS0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                Return (One)
                            }

                            Device (DSB0)
                            {
                                Name (_ADR, Zero)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }
                                }
                            }

                            Device (DSB3)
                            {
                                Name (_ADR, 0x00030000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }
                                }
                            }

                            Device (DSB4)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (UPS0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }
                                }
                            }

                            Device (DSB5)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }
                            }

                            Device (DSB6)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }
                            }
                        }
                    }

                    Device (DSB4)
                    {
                        Name (_ADR, 0x00040000)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (One)
                        }

                        Device (UPS0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                Return (One)
                            }

                            Device (DSB0)
                            {
                                Name (_ADR, Zero)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }
                                }
                            }

                            Device (DSB3)
                            {
                                Name (_ADR, 0x00030000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }
                                }
                            }

                            Device (DSB4)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }
                                }
                            }

                            Device (DSB5)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }
                            }

                            Device (DSB6)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }
                            }
                        }
                    }

                    Device (DSB5)
                    {
                        Name (_ADR, 0x00050000)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (One)
                        }
                    }

                    Device (DSB6)
                    {
                        Name (_ADR, 0x00060000)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (One)
                        }
                    }
                }
            }

            Device (DSB2)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
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

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

                Name (IIP3, Zero)
                Name (PRSR, Zero)
                Name (PCIA, One)
                Method (PCEU, 0, Serialized)
                {
                    \_SB.PCI0.RP01.PXSX.DSB2.PRSR = Zero
                    If ((\_SB.PCI0.RP01.PXSX.DSB2.PSTA != Zero))
                    {
                        \_SB.PCI0.RP01.PXSX.DSB2.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB2.PSTA = Zero
                    }

                    If ((\_SB.PCI0.RP01.PXSX.DSB2.LDIS == One))
                    {
                        \_SB.PCI0.RP01.PXSX.DSB2.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB2.LDIS = Zero
                    }
                }

                Method (PCDA, 0, Serialized)
                {
                    If ((\_SB.PCI0.RP01.PXSX.DSB2.POFF () != Zero))
                    {
                        \_SB.PCI0.RP01.PXSX.DSB2.PCIA = Zero
                        \_SB.PCI0.RP01.PXSX.DSB2.PSTA = 0x03
                        \_SB.PCI0.RP01.PXSX.DSB2.LDIS = One
                        Local5 = (Timer + 0x00989680)
                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP01.PXSX.DSB2.LACR == One))
                            {
                                If ((\_SB.PCI0.RP01.PXSX.DSB2.LACT == Zero))
                                {
                                    Break
                                }
                            }
                            ElseIf ((\_SB.PCI0.RP01.PXSX.DSB2.XHC2.AVND == 0xFFFFFFFF))
                            {
                                Break
                            }

                            Sleep (0x0A)
                        }

                        \_SB.PCI0.RP01.GXCI = Zero
                        \_SB.PCI0.RP01.UGIO ()
                    }
                    Else
                    {
                    }

                    \_SB.PCI0.RP01.PXSX.DSB2.IIP3 = One
                }

                Method (POFF, 0, Serialized)
                {
                    Return (!\_SB.PCI0.RP01.RUSB)
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    PCEU ()
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    PCDA ()
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
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

                    Method (PCED, 0, Serialized)
                    {
                        \_SB.PCI0.RP01.GXCI = One
                        If ((\_SB.PCI0.RP01.UGIO () != Zero))
                        {
                            \_SB.PCI0.RP01.PXSX.DSB2.PRSR = One
                        }

                        Local0 = Zero
                        Local1 = Zero
                        Local5 = (Timer + 0x00989680)
                        If ((\_SB.PCI0.RP01.PXSX.DSB2.PRSR != Zero))
                        {
                            Local5 = (Timer + 0x00989680)
                            While ((Timer <= Local5))
                            {
                                If ((\_SB.PCI0.RP01.PXSX.DSB2.LACR == Zero))
                                {
                                    If ((\_SB.PCI0.RP01.PXSX.DSB2.LTRN != One))
                                    {
                                        Break
                                    }
                                }
                                ElseIf (((\_SB.PCI0.RP01.PXSX.DSB2.LTRN != One) && (\_SB.PCI0.RP01.PXSX.DSB2.LACT == One)))
                                {
                                    Break
                                }

                                Sleep (0x0A)
                            }

                            Sleep (0x96)
                        }

                        \_SB.PCI0.RP01.PXSX.DSB2.PRSR = Zero
                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP01.PXSX.DSB2.XHC2.AVND != 0xFFFFFFFF))
                            {
                                \_SB.PCI0.RP01.PXSX.DSB2.PCIA = One
                                Break
                            }

                            Sleep (0x0A)
                        }

                        \_SB.PCI0.RP01.PXSX.DSB2.IIP3 = Zero
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        Local0 = Package (0x04)
                        {
                            "USBBusNumber",
                            Zero,
                            "AAPL,xhci-clock-id",
                            One
                        }

                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }

                    Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                    {
                        Debug = "TB:DSB2:XHC2:_PS0"

                        Sleep (0xC8)
                        PCED ()
                    }

                    Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                    {
                        Debug = "TB:DSB2:XHC2:_PS3"

                        Sleep (0xC8)
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address

                        Name (PCKG, Package (0x04)
                        {
                                0xFF,
                                0x03,
                                Zero,
                                Zero
                        })

                        Method (GUPC, 2, Serialized)
                        {

                            PCKG [Zero] = Arg0
                            PCKG [One] = Arg1
                            Return (PCKG) /* \GUPC.PCKG */
                        }

                        Device (HSP1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (One, 0x03))
                            }
                        }

                        Device (HSP2)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Device (SSP1)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (One, 0x03))
                            }
                        }

                        Device (SSP2)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address
                            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }
                    }
                }
            }
        }
    }
}