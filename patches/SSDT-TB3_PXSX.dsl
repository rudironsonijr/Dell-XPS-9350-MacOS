/*
 * This is my failed attempt to fix TB3 on DSL6340
 *
 * References:
 * [1] https://osy.gitbook.io/hac-mini-guide/details/thunderbolt-3-fix-part-3
 * [2] https://github.com/osy/ThunderboltReset
 * [3] https://github.com/al3xtjames/ThunderboltPkg/blob/master/Docs/FAQ.md
 */
DefinitionBlock ("", "SSDT", 2, "hack", "TB3", 0x00000000)
{
    /* Patching existing devices */
    External (\_SB_.PCI0.RP01, DeviceObj)
    External (\_SB_.PCI0.RP01.PXSX, DeviceObj)
    External (\_SB.PCI0.RP01.PXSX.TBDU, DeviceObj)
    External (\_SB.PCI0.XHC, DeviceObj)

    External (DTGP, MethodObj)
    External (OSDW, MethodObj)                        // OS Is Darwin?
    External (DBG1, MethodObj)
    External (DBG2, MethodObj)
    External (DBG3, MethodObj)
    External (XE42, MethodObj)
    External (\_SB.TBFP, MethodObj)
    External (XWAK, MethodObj)

    Name (U2OP, Zero) // use companion controller
    Name (IIP3, Zero)
    Name (PRSR, Zero)
    Name (PCIA, One)

    Scope (\_GPE)
    {
        Method (_E42, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
        {
            DBG1 ("Start of patched _E42")
            If (!_OSI ("Darwin"))
            {
                If (\_SB.PCI0.RP01.POC0 == One)
                {
                    Return
                }

                Sleep (400)
                If (\_SB.PCI0.RP01.WTLT () == One)
                {
                    \_SB.PCI0.RP01.ICMS ()
                }
                Else // force power off
                {
                    //\_SB.SGOV (0x01070004, Zero)
                    //\_SB.SGDO (0x01070004)
                }

                If (\_SB.PCI0.RP01.UPMB)
                {
                    \_SB.PCI0.RP01.UPMB = Zero
                    Sleep (One)
                }

                \_SB.PCI0.RP01.CMPE ()
            }
            /*
            ElseIf (\_SB.GGII (0x01070015) == One)
            {
                \_SB.SGII (0x01070015, Zero)
            }
            Else
            {
                \_SB.SGII (0x01070015, One)
            }
            */
            Else
            {
                \_SB.PCI0.RP01.PXSX.AMPE ()
            }
            DBG1 ("End of patched _E42")
            //XE42 ()
        }
    }

    Method (RWAK, 1, Serialized)
    {

        XWAK (Arg0)

        If (((Arg0 == 0x03) || (Arg0 == 0x04)))
        {
            If ((\_SB.PCI0.RP01.VDID != 0xFFFFFFFF))
            {
                Notify (\_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero) // TB3 controller
            }
        }

        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Scope (\_SB.PCI0.RP01)
    {
        External (MMRP, MethodObj)                        // Memory mapped root port
        External (MMTB, MethodObj)                        // Memory mapped TB port
        External (TBSE, FieldUnitObj)                     // TB root port number
        External (\_SB.PCI0.GPCB, MethodObj)              // get PCI MMIO base
        External (\_SB.PCI0.RP01.XINI, MethodObj)         // original _INI patched by OC

        Name (EICM, Zero)
        Name (R020, Zero) // RP base/limit from UEFI
        Name (R024, Zero) // RP prefetch base/limit from UEFI
        Name (R118, Zero) // PXSX Pri Bus = RP Sec Bus (UEFI)
        Name (R119, Zero) // PXSX Sec Bus = RP Sec Bus + 1
        Name (R11A, Zero) // PXSX Sub Bus = RP Sub Bus (UEFI)
        Name (R11C, Zero) // PXSX IO base/limit = RP IO base/limit (UEFI)
        Name (R120, Zero) // PXSX mem base/limit = RP mem base/limit (UEFI)
        Name (R124, Zero) // PXSX pre base/limit = RP pre base/limit (UEFI)
        Name (R218, Zero) // DSB0 Pri Bus = PXSX Sec Bus
        Name (R219, Zero) // DSB0 Sec Bus = PXSX Sec Bus + 1
        Name (R21A, Zero) // DSB0 Sub Bus = PXSX Sub Bus
        Name (R21C, Zero) // DSB0 IO base/limit = PXSX IO base/limit
        Name (R220, Zero) // DSB0 mem base/limit = PXSX mem base/limit
        Name (R224, Zero) // DSB0 pre base/limit = PXSX pre base/limit
        Name (R318, Zero) // DSB1 Pri Bus = PXSX Sec Bus
        Name (R319, Zero) // DSB1 Sec Bus = PXSX Sec Bus + 2
        Name (R31A, Zero) // DSB1 Sub Bus = no children
        Name (R31C, Zero) // DSB1 disable IO
        Name (R320, Zero) // DSB1 disable mem
        Name (R324, Zero) // DSB1 disable prefetch
        Name (R418, Zero) // DSB2 Pri Bus = PXSX Sec Bus
        Name (R419, Zero) // DSB2 Sec Bus = PXSX Sec Bus + 3
        Name (R41A, Zero) // DSB2 Sub Bus = no children
        Name (R41C, Zero) // DSB2 disable IO
        Name (R420, Zero) // DSB2 disable mem
        Name (R424, Zero) // DSB2 disable prefetch
        Name (RVES, Zero) // DSB2 offset 0x564, unknown
        Name (R518, Zero) // DSB4 Pri Bus = PXSX Sec Bus
        Name (R519, Zero) // DSB4 Sec Bus = PXSX Sec Bus + 4
        Name (R51A, Zero) // DSB4 Sub Bus = no children
        Name (R51C, Zero) // DSB4 disable IO
        Name (R520, Zero) // DSB4 disable mem
        Name (R524, Zero) // DSB4 disable prefetch
        Name (R618, Zero)
        Name (R619, Zero)
        Name (R61A, Zero)
        Name (R61C, Zero)
        Name (R620, Zero)
        Name (R624, Zero)
        Name (RH10, Zero) // NHI0 BAR0 = DSB0 mem base
        Name (RH14, Zero) // NHI0 BAR1 unused
        Name (POC0, Zero)
        Name (IIP3, Zero)
        Name (PRSR, Zero)
        Name (PCIA, One)

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

        // Root port configuration base
        OperationRegion (RPSM, SystemMemory, MMRP (), 0x54)
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
            Offset (0x52),
                ,   11,
            RPLT,   1,
            Offset (0x54)
        }

        // PXSX (up stream port) configuration base
        OperationRegion (UPSM, SystemMemory, MMTB (), 0x0550)
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
            D324,   32
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
            Offset (0x564),
            DVES,   32
        }

        // DSB4 configuration base
        OperationRegion (DS5M, SystemMemory, MMIO (UP19, 4, 0), 0x40)
        Field (DS5M, DWordAcc, NoLock, Preserve)
        {
            D5VD,   32,
            D504,   8,
            Offset (0x18),
            D518,   8,
            D519,   8,
            D51A,   8,
            Offset (0x1C),
            D51C,   16,
            Offset (0x20),
            D520,   32,
            D524,   32
        }

        OperationRegion (NHIM, SystemMemory, MMIO (DP19, 0, 0), 0x40)
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

        OperationRegion (XHCM, SystemMemory, MMIO (D519, 0, 0), 0x40)
        Field (XHCM, DWordAcc, NoLock, Preserve)
        {
            XH00,   32,
            XH04,   8,
            Offset (0x10),
            XH10,   32,
            XH14,   32
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (!_OSI ("Darwin"))
            {
                DBG3 ("RP", RPVD, R_20)
                R020 = R_20 /* \_SB_.PCI0.RP01.R_20 */
                R024 = R_24 /* \_SB_.PCI0.RP01.R_24 */

                R118 = UP18 /* \_SB_.PCI0.RP01.UP18 */
                R119 = UP19 /* \_SB_.PCI0.RP01.UP19 */
                R11A = UP1A /* \_SB_.PCI0.RP01.UP1A */
                R11C = UP1C /* \_SB_.PCI0.RP01.UP1C */
                R120 = UP20 /* \_SB_.PCI0.RP01.UP20 */
                R124 = UP24 /* \_SB_.PCI0.RP01.UP24 */

                R218 = DP18 /* \_SB_.PCI0.RP01.DP18 */
                R219 = DP19 /* \_SB_.PCI0.RP01.DP19 */
                R21A = DP1A /* \_SB_.PCI0.RP01.DP1A */
                R21C = DP1C /* \_SB_.PCI0.RP01.DP1C */
                R220 = DP20 /* \_SB_.PCI0.RP01.DP20 */
                R224 = DP24 /* \_SB_.PCI0.RP01.DP24 */

                R318 = D318 /* \_SB_.PCI0.RP01.D318 */
                R319 = D319 /* \_SB_.PCI0.RP01.D319 */
                R31A = D31A /* \_SB_.PCI0.RP01.D31A */
                R31C = D31C /* \_SB_.PCI0.RP01.D31C */
                R320 = D320 /* \_SB_.PCI0.RP01.D320 */
                R324 = D324 /* \_SB_.PCI0.RP01.D324 */

                R418 = D418 /* \_SB_.PCI0.RP01.D418 */
                R419 = D419 /* \_SB_.PCI0.RP01.D419 */
                R41A = D41A /* \_SB_.PCI0.RP01.D41A */
                R41C = D41C /* \_SB_.PCI0.RP01.D41C */
                R420 = D420 /* \_SB_.PCI0.RP01.D420 */
                R424 = D424 /* \_SB_.PCI0.RP01.D424 */
                RVES = DVES /* \_SB_.PCI0.RP01.DVES */
                R518 = D518 /* \_SB_.PCI0.RP01.D518 */
                R519 = D519 /* \_SB_.PCI0.RP01.D519 */
                R51A = D51A /* \_SB_.PCI0.RP01.D51A */
                R51C = D51C /* \_SB_.PCI0.RP01.D51C */
                R520 = D520 /* \_SB_.PCI0.RP01.D520 */
                R524 = D524 /* \_SB_.PCI0.RP01.D524 */
                RH10 = NH10 /* \_SB_.PCI0.RP01.NH10 */
                RH14 = NH14 /* \_SB_.PCI0.RP01.NH14 */
                Sleep (One)
                ICMS ()
            }
        }

        Method (ICMS, 0, NotSerialized)
        {
            \_SB.PCI0.RP01.POC0 = One
            DBG2 ("ICME", \_SB.PCI0.RP01.ICME)
            If (\_SB.PCI0.RP01.ICME != 0x800001A6 && \_SB.PCI0.RP01.ICME != 0x800000A6)
            {
                If (\_SB.PCI0.RP01.CNHI ())
                {
                    DBG2 ("ICME", \_SB.PCI0.RP01.ICME)
                    If (\_SB.PCI0.RP01.ICME != 0xFFFFFFFF)
                    {
                        //SGDI (0x01070004)
                        \_SB.PCI0.RP01.WTLT ()
                        DBG2 ("ICME", \_SB.PCI0.RP01.ICME)
                        If (!Local0 = (\_SB.PCI0.RP01.ICME & 0x80000000)) // NVM started means we need reset
                        {
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
                            DBG2 ("ICME", \_SB.PCI0.RP01.ICME)
                            //\_SB.SGOV (0x01070004, Zero)
                            //\_SB.SGDO (0x01070004)
                        }
                    }
                }
            }

            \_SB.PCI0.RP01.POC0 = Zero

            // disable USB force power
            //SGOV (0x01070007, Zero)
            //SGDO (0x01070007)
        }

        /**
            * Send TBT command
            */
        Method (TBTC, 1, Serialized)
        {
            P2TR = Arg0
            Local0 = 100
            Local1 = T2PR /* \_SB_.PCI0.RP01.T2PR */
            While ((Local2 = (Local1 & One)) == Zero)
            {
                If (Local1 == 0xFFFFFFFF)
                {
                    Return
                }

                Local0--
                If (Local0 == Zero)
                {
                    Break
                }

                Local1 = T2PR /* \_SB_.PCI0.RP01.T2PR */
                Sleep (50)
            }

            P2TR = Zero
        }

        /**
            * Plug detection for Windows
            */
        Method (CMPE, 0, Serialized)
        {
            Notify (\_SB.PCI0.RP01, Zero) // Bus Check
        }

        /**
            * Configure NHI device
            */
        Method (CNHI, 0, Serialized)
        {
            Local0 = 10

            // Configure root port
            DBG1 ("Configure root")
            While (Local0)
            {
                R_20 = R020 // Memory Base/Limit
                R_24 = R024 // Prefetch Base/Limit
                RPR4 = 0x07 // Command
                If (R020 == R_20) // read back check
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (R020 != R_20) // configure failed
            {
                Return (Zero)
            }

            // Configure PXSX
            DBG1 ("Configure PXSX")
            Local0 = 10
            While (Local0)
            {
                UP18 = R118 // PXSX Pri Bus
                UP19 = R119 // PXSX Sec Bus
                UP1A = R11A // PXSX Sub Bus
                UP1C = R11C // PXSX IO Base/Limit
                UP20 = R120 // PXSX Memory Base/Limit
                UP24 = R124 // PXSX Prefetch Base/Limit
                UP04 = 0x07 // PXSX Command
                If (R119 == UP19) // read back check
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (R119 != UP19) // configure failed
            {
                Return (Zero)
            }

            DBG1 ("Wait for link training")
            If (WTLT () != One)
            {
                Return (Zero)
            }

            // Configure DSB0
            DBG1 ("Configure DSB")
            Local0 = 10
            While (Local0)
            {
                DP18 = R218 // Pri Bus
                DP19 = R219 // Sec Bus
                DP1A = R21A // Sub Bus
                DP1C = R21C // IO Base/Limit
                DP20 = R220 // Memory Base/Limit
                DP24 = R224 // Prefetch Base/Limit
                DP04 = 0x07 // Command
                D318 = R318 // Pri Bus
                D319 = R319 // Sec Bus
                D31A = R31A // Sub Bus
                D31C = R31C // IO Base/Limit
                D320 = R320 // Memory Base/Limit
                D324 = R324 // Prefetch Base/Limit
                D304 = 0x07 // Command
                D418 = R418 // Pri Bus
                D419 = R419 // Sec Bus
                D41A = R41A // Sub Bus
                D41C = R41C // IO Base/Limit
                D420 = R420 // Memory Base/Limit
                D424 = R424 // Prefetch Base/Limit
                DVES = RVES // DSB2 0x564
                D404 = 0x07 // Command
                D518 = R518 // Pri Bus
                D519 = R519 // Sec Bus
                D51A = R51A // Sub Bus
                D51C = R51C // IO Base/Limit
                D520 = R520 // Memory Base/Limit
                D524 = R524 // Prefetch Base/Limit
                D504 = 0x07 // Command
                If (R219 == DP19) // read back check
                {
                    Break
                }

                Sleep (One)
                Local0--
            }

            If (R219 != DP19) // configure failed
            {
                Return (Zero)
            }

            DBG1 ("Wait for down link")
            If (WTDL () != One)
            {
                Return (Zero)
            }

            // Configure NHI
            DBG1 ("Configure NHI")
            Local0 = 100
            While (Local0)
            {
                NH10 = RH10 // NHI BAR 0
                NH14 = RH14 // NHI BAR 1
                NH04 = 0x07 // NHI Command
                If (RH10 == NH10) // read back check
                {
                    Break
                }

                Sleep (One)
                Local0--
            }
            DBG2 ("NHI BAR", NH10)

            If (RH10 != NH10) // configure failed
            {
                Return (Zero)
            }

            DBG1 ("CNHI done")

            Return (One)
        }

        /**
            * Uplink check
            */
        Method (UPCK, 0, Serialized)
        {
            If ((UPVD & 0xFFFF) == 0x8086)
            {
                Return (One)
            }
            Else
            {
                Return (Zero)
            }
        }

        /**
            * Uplink training check
            */
        Method (ULTC, 0, Serialized)
        {
            If (RPLT == Zero)
            {
                If (UPLT == Zero)
                {
                    Return (One)
                }
            }

            Return (Zero)
        }

        /**
            * Wait for link training
            */
        Method (WTLT, 0, Serialized)
        {
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
            * Wait for downlink training
            */
        Method (WTDL, 0, Serialized)
        {
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
         * Bring up PCI link
         * Train downstream link
         */
        Method (PCEU, 0, Serialized)
        {
            \_SB.PCI0.RP01.PRSR = Zero
            If (\_SB.PCI0.RP01.PSTA != Zero)
            {
                \_SB.PCI0.RP01.PRSR = One
                \_SB.PCI0.RP01.PSTA = Zero
            }

            If (\_SB.PCI0.RP01.LDXX == One)
            {
                \_SB.PCI0.RP01.PRSR = One
                \_SB.PCI0.RP01.LDXX = Zero
            }
        }

        /**
         * Bring down PCI link
         */
        Method (PCDA, 0, Serialized)
        {
            If (\_SB.PCI0.RP01.POFF () != Zero)
            {
                \_SB.PCI0.RP01.PCIA = Zero
                \_SB.PCI0.RP01.PSTA = 0x03
                \_SB.PCI0.RP01.LDXX = One
                Local5 = (Timer + 10000000)
                While (Timer <= Local5)
                {
                    If (\_SB.PCI0.RP01.LACR == One)
                    {
                        If (\_SB.PCI0.RP01.LACT == Zero)
                        {
                            Break
                        }
                    }
                    ElseIf (\_SB.PCI0.RP01.PXSX.AVND == 0xFFFFFFFF)
                    {
                        Break
                    }

                    Sleep (10)
                }

                \_SB.PCI0.RP01.GPCI = Zero
                \_SB.PCI0.RP01.UGIO ()
            }
            Else
            {
            }

            \_SB.PCI0.RP01.IIP3 = One
        }

        /**
         * Returns true if both TB and TB-USB are idle
         */
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

        /**
         * Send power down ack to CP
         */
        Method (CTBT, 0, Serialized)
        {
            //If ((GGDV (0x01070004) == One) && (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
            If (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)
            {
                Local2 = \_SB.PCI0.RP01.PXSX.CRMW (0x3C, Zero, 0x02, 0x04000000, 0x04000000)
                If (Local2 == Zero)
                {
                    \_SB.PCI0.RP01.CTPD = One
                }
            }
        }

        /**
         * Toggle controller power
         * Power controllers either up or down depending on the request.
         * On Macs, there's two GPIO signals for controlling TB and XHC
         * separately. If such signals exist, we need to find it. Otherwise
         * we lose the power saving capabilities.
         * Returns if controller is powered up
         */
        Method (UGIO, 0, Serialized)
        {
            // Which controller is requested to be on?
            Local0 = (\_SB.PCI0.RP01.GNHI || \_SB.PCI0.RP01.RTBT) // TBT
            Local1 = (\_SB.PCI0.RP01.GXCI || \_SB.PCI0.RP01.RUSB) // USB
            DBG3 ("UGIO", Local0, Local1)
            If (\_SB.PCI0.RP01.GPCI != Zero)
            {
                // if neither are requested to be on but the NHI controller
                // needs to be up, then we go ahead and power it on anyways
                If ((Local0 == Zero) && (Local1 == Zero))
                {
                    Local0 = One
                    Local1 = One
                }
            }

            Local2 = Zero

            /**
             * Force power to CIO
             */
            If (Local0 != Zero)
            {
                // TODO: check if CIO power is forced
                //If (GGDV (0x01070004) == Zero)
                If (Zero)
                {
                    // TODO: force CIO power
                    //SGDI (0x01070004)
                    Local2 = One
                    \_SB.PCI0.RP01.CTPD = Zero
                }
            }

            /**
             * Force power to USB
             */
            If (Local1 != Zero)
            {
                // TODO: check if USB power is forced
                //If (GGDV (0x01070007) == Zero)
                If (Zero)
                {
                    // TODO: force USB power
                    //SGDI (0x01070007)
                    Local2 = One
                }
            }

            // if we did power on
            If (Local2 != Zero)
            {
                Sleep (500)
            }

            Local3 = Zero

            /**
             * Disable force power to CIO
             */
            If (Local0 == Zero)
            {
                // TODO: check if CIO power is off
                //If (GGDV (0x01070004) == One)
                If (Zero)
                {
                    \_SB.PCI0.RP01.CTBT ()
                    If (\_SB.PCI0.RP01.CTPD != Zero)
                    {
                        // TODO: force power off CIO
                        //SGOV (0x01070004, Zero)
                        //SGDO (0x01070004)
                        Local3 = One
                    }
                }
            }

            /**
             * Disable force power to USB
             */
            If (Local1 == Zero)
            {
                //If (GGDV (0x01070007) == One)
                If (Zero)
                {
                    // TODO: force power off USB
                    //SGOV (0x01070007, Zero)
                    //SGDO (0x01070007)
                    Local3 = One
                }
            }

            // if we did power down, wait for things to settle
            If (Local3 != Zero)
            {
                Sleep (100)
            }
            DBG3 ("UGIO finish", Local2, Local3)

            Return (Local2)
        }

        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
        {
            If (_OSI ("Darwin"))
            {
                PCEU ()

                \_SB.TBFP (One)
                Local0 = 10000 // 10 seconds
                While (Local0 > 0 && \_SB.PCI0.RP05.PXSX.AVND == 0xFFFFFFFF)
                {
                    Sleep (1)
                    Local0--
                }
            }
        }

        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
        {
            If (_OSI ("Darwin"))
            {
                If (\_SB.PCI0.RP01.POFF () != Zero)
                {
                    \_SB.PCI0.RP01.CTBT ()
                }

                PCDA ()
            }
        }

        Method (UTLK, 2, Serialized)
        {
            Local0 = Zero
            // if CIO force power is zero
            //If ((GGOV (0x01070004) == Zero) && (GGDV (0x01070004) == Zero))
            If (Zero)
            {
                \_SB.PCI0.RP01.PSTA = Zero
                While (One)
                {
                    If (\_SB.PCI0.RP01.LDXX == One)
                    {
                        \_SB.PCI0.RP01.LDXX = Zero
                    }

                    // here, we force CIO power on
                    //SGDI (0x01070004)
                    Local1 = Zero
                    Local2 = (Timer + 10000000)
                    While (Timer <= Local2)
                    {
                        If (\_SB.PCI0.RP01.LACR == Zero)
                        {
                            If (\_SB.PCI0.RP01.LTRN != One)
                            {
                                Break
                            }
                        }
                        ElseIf ((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One))
                        {
                            Break
                        }

                        Sleep (10)
                    }

                    Sleep (Arg1)
                    While (Timer <= Local2)
                    {
                        If (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)
                        {
                            Local1 = One
                            Break
                        }

                        Sleep (10)
                    }

                    If (Local1 == One)
                    {
                        \_SB.PCI0.RP01.MABT = One
                        Break
                    }

                    If (Local0 == 0x04)
                    {
                        Break
                    }

                    Local0++
                    // CIO force power back to 0
                    //SGOV (0x01070004, Zero)
                    //SGDO (0x01070004)
                    Sleep (1000)
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

        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (Zero)
        }

        /**
         * PXSX replaced by PXSX
         */
        Scope (PXSX)
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

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (SECB) /* \_SB_.PCI0.RP01.PXSX.SECB */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F) // visible for everyone
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (_OSI ("Darwin"))
                {
                    If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                    {
                        Local0 = Package (0x02)
                            {
                                "PCI-Thunderbolt",
                                One
                            }
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                }

                Return (Zero)
            }

            /**
             * Enable downstream link
             */
            Method (PCED, 0, Serialized)
            {
                \_SB.PCI0.RP01.GPCI = One
                // power up the controller
                If (\_SB.PCI0.RP01.UGIO () != Zero)
                {
                    \_SB.PCI0.RP01.PRSR = One
                }

                Local0 = Zero
                Local1 = Zero
                If (Local1 == Zero)
                {
                    If (\_SB.PCI0.RP01.IIP3 != Zero)
                    {
                        \_SB.PCI0.RP01.PRSR = One
                        Local0 = One
                        \_SB.PCI0.RP01.LDXX = One
                    }
                }

                Local5 = (Timer + 10000000)
                If (\_SB.PCI0.RP01.PRSR != Zero)
                {
                    Sleep (30)
                    If ((Local0 != Zero) || (Local1 != Zero))
                    {
                        \_SB.PCI0.RP01.TSPD = One
                        If (Local1 != Zero) {}
                        ElseIf (Local0 != Zero)
                        {
                            \_SB.PCI0.RP01.LDXX = Zero
                        }

                        While (Timer <= Local5)
                        {
                            If (\_SB.PCI0.RP01.LACR == Zero)
                            {
                                If (\_SB.PCI0.RP01.LTRN != One)
                                {
                                    Break
                                }
                            }
                            ElseIf ((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One))
                            {
                                Break
                            }

                            Sleep (10)
                        }

                        Sleep (120)
                        While (Timer <= Local5)
                        {
                            If (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)
                            {
                                Break
                            }

                            Sleep (10)
                        }

                        \_SB.PCI0.RP01.TSPD = 0x03
                        \_SB.PCI0.RP01.LRTN = One
                    }

                    Local5 = (Timer + 10000000)
                    While (Timer <= Local5)
                    {
                        If (\_SB.PCI0.RP01.LACR == Zero)
                        {
                            If (\_SB.PCI0.RP01.LTRN != One)
                            {
                                Break
                            }
                        }
                        ElseIf ((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One))
                        {
                            Break
                        }

                        Sleep (10)
                    }

                    Sleep (250)
                }

                \_SB.PCI0.RP01.PRSR = Zero
                While (Timer <= Local5)
                {
                    If (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)
                    {
                        Break
                    }

                    Sleep (10)
                }

                If (\_SB.PCI0.RP01.CSPD != 0x03)
                {
                    If (\_SB.PCI0.RP01.SSPD == 0x03)
                    {
                        If (\_SB.PCI0.RP01.PXSX.SSPD == 0x03)
                        {
                            If (\_SB.PCI0.RP01.TSPD != 0x03)
                            {
                                \_SB.PCI0.RP01.TSPD = 0x03
                            }

                            If (\_SB.PCI0.RP01.PXSX.TSPD != 0x03)
                            {
                                \_SB.PCI0.RP01.PXSX.TSPD = 0x03
                            }

                            \_SB.PCI0.RP01.LRTN = One
                            Local2 = (Timer + 10000000)
                            While (Timer <= Local2)
                            {
                                If (\_SB.PCI0.RP01.LACR == Zero)
                                {
                                    If ((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
                                    {
                                        \_SB.PCI0.RP01.PCIA = One
                                        Local1 = One
                                        Break
                                    }
                                }
                                ElseIf (((\_SB.PCI0.RP01.LTRN != One) && (\_SB.PCI0.RP01.LACT == One)) &&
                                    (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF))
                                {
                                    \_SB.PCI0.RP01.PCIA = One
                                    Local1 = One
                                    Break
                                }

                                Sleep (10)
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

            /**
             * Hotplug notify
             * Called by ACPI
             */
            Method (AMPE, 0, Serialized)
            {
                DBG1 ("AMPE")
                DBG1 ("Notify _SB.PCI0.RP01.PXSX.DSB0.NHI0")
                Notify (\_SB.PCI0.RP01.PXSX.DSB0.NHI0, Zero) // Bus Check
            }

            /**
             * Hotplug notify
             * MUST called by NHI driver indicating cable plug-in
             * This passes the message to the XHC driver
             */
            Method (UMPE, 0, Serialized)
            {
                Notify (\_SB.PCI0.RP01.PXSX.DSB2.XHC2, Zero) // Bus Check
                Notify (\_SB.PCI0.XHC, Zero) // Bus Check
            }

            Name (MDUV, One) // plug status

            /**
             * Cable status callback
             * Called from NHI driver on hotplug
             */
            Method (MUST, 1, Serialized)
            {
                DBG2 ("MUST", Arg0)
                If (_OSI ("Darwin"))
                {
                    If (MDUV != Arg0)
                    {
                        MDUV = Arg0
                        UMPE ()
                    }
                }

                Return (Zero)
            }

            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                If (_OSI ("Darwin"))
                {
                    PCED () // enable downlink
                    // some magical commands to CIO
                    \_SB.PCI0.RP01.PXSX.CRMW (0x013E, Zero, 0x02, 0x0200, 0x0200)
                    \_SB.PCI0.RP01.PXSX.CRMW (0x023E, Zero, 0x02, 0x0200, 0x0200)
                }
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
                If (!_OSI ("Darwin"))
                {
                    If (\_SB.PCI0.RP01.UPCK () == Zero)
                    {
                        \_SB.PCI0.RP01.UTLK (One, 1000)
                    }

                    \_SB.PCI0.RP01.TBTC (0x05)
                }
            }

            OperationRegion (H548, PCI_Config, 0x0548, 0x20)
            Field (H548, DWordAcc, Lock, Preserve)
            {
                T2PC,   32,
                PC2T,   32
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

            /**
             * CIO write
             */
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
                While (Zero < Local0)
                {
                    If (PROG == Zero)
                    {
                        Local1 = Zero
                        Break
                    }

                    Stall (0x19)
                    Local0--
                }

                If (Local1 == Zero)
                {
                    Local1 = TMOT /* \_SB_.PCI0.RP01.PXSX.TMOT */
                }

                Return (Local1)
            }

            /**
             * CIO read
             */
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
                While (Zero < Local0)
                {
                    If (PROG == Zero)
                    {
                        Local1 = Zero
                        Break
                    }

                    Stall (0x19)
                    Local0--
                }

                If (Local1 == Zero)
                {
                    Local1 = TMOT /* \_SB_.PCI0.RP01.PXSX.TMOT */
                }

                If (Local1 == Zero)
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

            /**
             * CIO Read Modify Write
             */
            Method (CRMW, 5, Serialized)
            {
                Local1 = One
                //If (((GGDV (0x01070004) == One) || (GGDV (0x01070007) == One)) &&
                If (\_SB.PCI0.RP01.PXSX.AVND != 0xFFFFFFFF)
                {
                    Local3 = Zero
                    While (Local3 <= 0x04)
                    {
                        Local2 = CIOR (Arg0, Arg1, Arg2)
                        If (DerefOf (Local2 [Zero]) == Zero)
                        {
                            Local2 = DerefOf (Local2 [One])
                            Local2 &= ~Arg4
                            Local2 |= Arg3
                            Local2 = CIOW (Arg0, Arg1, Arg2, Local2)
                            If (Local2 == Zero)
                            {
                                Local2 = CIOR (Arg0, Arg1, Arg2)
                                If (DerefOf (Local2 [Zero]) == Zero)
                                {
                                    Local2 = DerefOf (Local2 [One])
                                    Local2 &= Arg4
                                    If (Local2 == Arg3)
                                    {
                                        Local1 = Zero
                                        Break
                                    }
                                }
                            }
                        }

                        Local3++
                        Sleep (100)
                    }
                }

                DBG3 ("CRMW", Arg0, Local1)
                Return (Local1)
            }

            /**
             * Not used anywhere AFAIK
             */
            Method (LSTX, 2, Serialized)
            {
                If (T2PC != 0xFFFFFFFF)
                {
                    Local0 = Zero
                    If ((T2PC & One) && One)
                    {
                        Local0 = One
                    }

                    If (Local0 == Zero)
                    {
                        Local1 = 0x2710
                        While (Zero < Local1)
                        {
                            If (T2PC == Zero)
                            {
                                Break
                            }

                            Stall (0x19)
                            Local1--
                        }

                        If (Zero == Local1)
                        {
                            Local0 = One
                        }
                    }

                    If (Local0 == Zero)
                    {
                        Local1 = One
                        Local1 |= 0x14
                        Local1 |= (Arg0 << 0x08)
                        Local1 |= (Arg1 << 0x0C)
                        Local1 |= 0x00400000
                        PC2T = Local1
                    }

                    If (Local0 == Zero)
                    {
                        Local1 = 0x2710
                        While (Zero < Local1)
                        {
                            If (T2PC == 0x15)
                            {
                                Break
                            }

                            Stall (0x19)
                            Local1--
                        }

                        If (Zero == Local1)
                        {
                            Local0 = One
                        }
                    }

                    PC2T = Zero
                }
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
                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB0.SECB */
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
                Method (PCEU, 0, Serialized)
                {
                    \_SB.PCI0.RP01.PXSX.DSB0.PRSR = Zero
                    If (\_SB.PCI0.RP01.PXSX.DSB0.PSTA != Zero)
                    {
                        \_SB.PCI0.RP01.PXSX.DSB0.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB0.PSTA = Zero
                    }

                    If (\_SB.PCI0.RP01.PXSX.DSB0.LDIS == One)
                    {
                        \_SB.PCI0.RP01.PXSX.DSB0.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB0.LDIS = Zero
                    }
                }

                Method (PCDA, 0, Serialized)
                {
                    If (\_SB.PCI0.RP01.PXSX.DSB0.POFF () != Zero)
                    {
                        \_SB.PCI0.RP01.PXSX.DSB0.PCIA = Zero
                        \_SB.PCI0.RP01.PXSX.DSB0.PSTA = 0x03
                        \_SB.PCI0.RP01.PXSX.DSB0.LDIS = One
                        Local5 = (Timer + 10000000)
                        While (Timer <= Local5)
                        {
                            If (\_SB.PCI0.RP01.PXSX.DSB0.LACR == One)
                            {
                                If (\_SB.PCI0.RP01.PXSX.DSB0.LACT == Zero)
                                {
                                    Break
                                }
                            }
                            ElseIf (\_SB.PCI0.RP01.PXSX.DSB0.NHI0.AVND == 0xFFFFFFFF)
                            {
                                Break
                            }

                            Sleep (10)
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
                    If (_OSI ("Darwin"))
                    {
                        PCEU ()
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    If (_OSI ("Darwin"))
                    {
                        PCDA ()
                    }
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (_OSI ("Darwin"))
                    {
                        If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                        {
                            Local0 = Package (0x02)
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

                    /**
                     * Enable downstream link
                     */
                    Method (PCED, 0, Serialized)
                    {
                        \_SB.PCI0.RP01.GNHI = One
                        // we should not need to force power since
                        // UPSX init should already have done so!
                        If (\_SB.PCI0.RP01.UGIO () != Zero)
                        {
                            \_SB.PCI0.RP01.PXSX.DSB0.PRSR = One
                        }

                        // Do some link training

                        Local0 = Zero
                        Local1 = Zero
                        Local5 = (Timer + 10000000)
                        If (\_SB.PCI0.RP01.PXSX.DSB0.PRSR != Zero)
                        {
                            Local5 = (Timer + 10000000)
                            While (Timer <= Local5)
                            {
                                If (\_SB.PCI0.RP01.PXSX.DSB0.LACR == Zero)
                                {
                                    If (\_SB.PCI0.RP01.PXSX.DSB0.LTRN != One)
                                    {
                                        Break
                                    }
                                }
                                ElseIf ((\_SB.PCI0.RP01.PXSX.DSB0.LTRN != One) && (\_SB.PCI0.RP01.PXSX.DSB0.LACT == One))
                                {
                                    Break
                                }

                                Sleep (10)
                            }

                            Sleep (150)
                        }

                        \_SB.PCI0.RP01.PXSX.DSB0.PRSR = Zero
                        While (Timer <= Local5)
                        {
                            If (\_SB.PCI0.RP01.PXSX.DSB0.NHI0.AVND != 0xFFFFFFFF)
                            {
                                \_SB.PCI0.RP01.PXSX.DSB0.PCIA = One
                                Break
                            }

                            Sleep (10)
                        }

                        \_SB.PCI0.RP01.PXSX.DSB0.IIP3 = Zero
                    }

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

                    /**
                     * Run Time Power Check
                     * Called by NHI driver when link is idle.
                     * Once both XHC and NHI idle, we can power down.
                     */
                    Method (RTPC, 1, Serialized)
                    {
                        If (_OSI ("Darwin"))
                        {
                            If (Arg0 <= One)
                            {
                                \_SB.PCI0.RP01.RTBT = Arg0
                            }
                        }

                        Return (Zero)
                    }

                    /**
                     * Cable detection callback
                     * Called by NHI driver on hotplug
                     */
                    Method (MUST, 1, Serialized)
                    {
                        Return (\_SB.PCI0.RP01.PXSX.MUST (Arg0))
                    }

                    Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                    {
                        If (_OSI ("Darwin"))
                        {
                            PCED ()
                            \_SB.PCI0.RP01.CTBT ()
                        }
                    }

                    Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                    {
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (_OSI ("Darwin"))
                        {
                            Local0 = Package (0x03)
                                {
                                    "power-save",
                                    One,
                                    Buffer (One)
                                    {
                                         0x00                                             /* . */
                                    }
                                }
                            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                            Return (Local0)
                        }

                        Return (Zero)
                    }

                    /**
                     * Late sleep force power
                     * NHI driver sends a sleep cmd to TB controller
                     * But we might be sleeping at this time. So this will
                     * force the power on right before sleep.
                     */
                    Method (SXFP, 1, Serialized)
                    {
                        DBG2 ("SXFP", Arg0)
                        If (Arg0 == Zero)
                        {
                            //If (GGDV (0x01070007) == One)
                            //{
                            //    SGOV (0x01070007, Zero)
                            //    SGDO (0x01070007)
                            //    Sleep (0x64)
                            //}
                            //SGOV (0x01070004, Zero)
                            //SGDO (0x01070004)
                        }
                    }
                }
            }

            Device (DSB1)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Name (_SUN, One)  // _SUN: Slot User Number
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
                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.SECB */
                }

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
                    OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                    Field (ARE0, ByteAcc, NoLock, Preserve)
                    {
                        AVND,   16
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (One)
                        }

                        Return (Zero)
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
                            MABT,   1,
                            Offset (0x3E),
                                ,   6,
                            SBRS,   1
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB0.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (One)
                            }

                            Return (Zero)
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
                                If (_OSI ("Darwin"))
                                {
                                    Return (One)
                                }

                                Return (Zero)
                            }
                        }
                    }

                    Device (DSB3)
                    {
                        Name (_ADR, 0x00030000)  // _ADR: Address
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

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB3.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (One)
                            }

                            Return (Zero)
                        }

                        Device (UPS0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                            Field (ARE0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   16
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (One)
                                }

                                Return (Zero)
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
                                    MABT,   1,
                                    Offset (0x3E),
                                        ,   6,
                                    SBRS,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB3.UPS0.DSB0.SECB */
                                }

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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB3.UPS0.DSB3.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
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
                                        If (_OSI ("Darwin"))
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB4)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB3.UPS0.DSB4.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
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
                                        If (_OSI ("Darwin"))
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB5)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB3.UPS0.DSB5.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }

                            Device (DSB6)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB3.UPS0.DSB6.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }
                        }
                    }

                    Device (DSB4)
                    {
                        Name (_ADR, 0x00040000)  // _ADR: Address
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

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB4.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (One)
                            }

                            Return (Zero)
                        }

                        Device (UPS0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                            Field (ARE0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   16
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (One)
                                }

                                Return (Zero)
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
                                    MABT,   1,
                                    Offset (0x3E),
                                        ,   6,
                                    SBRS,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB4.UPS0.DSB0.SECB */
                                }

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
                                        If (_OSI ("Darwin"))
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB3)
                            {
                                Name (_ADR, 0x00030000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB4.UPS0.DSB3.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
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
                                        If (_OSI ("Darwin"))
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB4)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB4.UPS0.DSB4.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
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
                                        If (_OSI ("Darwin"))
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB5)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB4.UPS0.DSB5.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }

                            Device (DSB6)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
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

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB4.UPS0.DSB6.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }
                        }
                    }

                    Device (DSB5)
                    {
                        Name (_ADR, 0x00050000)  // _ADR: Address
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

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB5.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (One)
                            }

                            Return (Zero)
                        }
                    }

                    Device (DSB6)
                    {
                        Name (_ADR, 0x00060000)  // _ADR: Address
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

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB1.UPS0.DSB6.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (One)
                            }

                            Return (Zero)
                        }
                    }
                }
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
                    Return (SECB) /* \_SB_.PCI0.RP01.PXSX.DSB2.SECB */
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

                /**
                 * Enable upstream link
                 */
                Method (PCEU, 0, Serialized)
                {
                    \_SB.PCI0.RP01.PXSX.DSB2.PRSR = Zero
                    If (\_SB.PCI0.RP01.PXSX.DSB2.PSTA != Zero)
                    {
                        \_SB.PCI0.RP01.PXSX.DSB2.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB2.PSTA = Zero
                    }

                    If (\_SB.PCI0.RP01.PXSX.DSB2.LDIS == One)
                    {
                        \_SB.PCI0.RP01.PXSX.DSB2.PRSR = One
                        \_SB.PCI0.RP01.PXSX.DSB2.LDIS = Zero
                    }
                }

                /**
                 * PCI disable link
                 */
                Method (PCDA, 0, Serialized)
                {
                    If (\_SB.PCI0.RP01.PXSX.DSB2.POFF () != Zero)
                    {
                        \_SB.PCI0.RP01.PXSX.DSB2.PCIA = Zero
                        \_SB.PCI0.RP01.PXSX.DSB2.PSTA = 0x03
                        \_SB.PCI0.RP01.PXSX.DSB2.LDIS = One
                        Local5 = (Timer + 10000000)
                        While (Timer <= Local5)
                        {
                            If (\_SB.PCI0.RP01.PXSX.DSB2.LACR == One)
                            {
                                If (\_SB.PCI0.RP01.PXSX.DSB2.LACT == Zero)
                                {
                                    Break
                                }
                            }
                            ElseIf (\_SB.PCI0.RP01.PXSX.DSB2.XHC2.AVND == 0xFFFFFFFF)
                            {
                                Break
                            }

                            Sleep (10)
                        }

                        \_SB.PCI0.RP01.GXCI = Zero
                        \_SB.PCI0.RP01.UGIO () // power down if needed
                    }
                    Else
                    {
                    }

                    \_SB.PCI0.RP01.PXSX.DSB2.IIP3 = One
                }

                /**
                 * Is power saving requested?
                 */
                Method (POFF, 0, Serialized)
                {
                    Return (!\_SB.PCI0.RP01.RUSB)
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If (_OSI ("Darwin"))
                    {
                        PCEU ()
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    If (_OSI ("Darwin"))
                    {
                        PCDA ()
                    }
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (_OSI ("Darwin"))
                    {
                        If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                        {
                            Local0 = Package (0x02)
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

                Device (XHC2)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (SDPC, Zero)
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

                    /**
                     * PCI Enable downstream
                     */
                    Method (PCED, 0, Serialized)
                    {
                        \_SB.PCI0.RP01.GXCI = One
                        // this powers up both TBT and USB when needed
                        If (\_SB.PCI0.RP01.UGIO () != Zero)
                        {
                            \_SB.PCI0.RP01.PXSX.DSB2.PRSR = One
                        }

                        // Do some link training
                        Local0 = Zero
                        Local1 = Zero
                        Local5 = (Timer + 10000000)
                        If (\_SB.PCI0.RP01.PXSX.DSB2.PRSR != Zero)
                        {
                            Local5 = (Timer + 10000000)
                            While (Timer <= Local5)
                            {
                                If (\_SB.PCI0.RP01.PXSX.DSB2.LACR == Zero)
                                {
                                    If (\_SB.PCI0.RP01.PXSX.DSB2.LTRN != One)
                                    {
                                        Break
                                    }
                                }
                                ElseIf ((\_SB.PCI0.RP01.PXSX.DSB2.LTRN != One) && (\_SB.PCI0.RP01.PXSX.DSB2.LACT == One))
                                {
                                    Break
                                }

                                Sleep (10)
                            }

                            Sleep (150)
                        }

                        \_SB.PCI0.RP01.PXSX.DSB2.PRSR = Zero
                        While (Timer <= Local5)
                        {
                            If (\_SB.PCI0.RP01.PXSX.DSB2.XHC2.AVND != 0xFFFFFFFF)
                            {
                                \_SB.PCI0.RP01.PXSX.DSB2.PCIA = One
                                Break
                            }

                            Sleep (10)
                        }

                        \_SB.PCI0.RP01.PXSX.DSB2.IIP3 = Zero
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (U2OP == One)
                        {
                            Local0 = Package (0x06)
                                {
                                    "USBBusNumber",
                                    Zero,
                                    "AAPL,xhci-clock-id",
                                    One,
                                    "UsbCompanionControllerPresent",
                                    One
                                }
                        }
                        Else
                        {
                            Local0 = Package (0x04)
                                {
                                    "USBBusNumber",
                                    Zero,
                                    "AAPL,xhci-clock-id",
                                    One
                                }
                        }

                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (Package (0x02)
                            {
                                0x6D,
                                0x04
                            })
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                0x6D,
                                0x03
                            })
                        }
                    }

                    Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                    {
                        If (_OSI ("Darwin"))
                        {
                            PCED ()
                        }
                    }

                    Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                    {
                    }

                    /**
                     * Run Time Power Check
                     * Called by XHC driver when idle
                     */
                    Method (RTPC, 1, Serialized)
                    {
                        If (_OSI ("Darwin"))
                        {
                            If (Arg0 <= One)
                            {
                                \_SB.PCI0.RP01.RUSB = Arg0
                            }
                        }

                        Return (Zero)
                    }

                    /**
                     * USB cable check
                     * Called by XHC driver to check cable status
                     * Used as idle hint.
                     */
                    Method (MODU, 0, Serialized)
                    {
                        Return (\_SB.PCI0.RP01.PXSX.MDUV)
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address

                        Device (HSP1)
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
                                    PLD_UserVisible        = 0x0,
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
                                If (U2OP == One)
                                {
                                    Local0 = Package (0x0A)
                                        {
                                            "UsbCPortNumber",
                                            0x01,
                                            "UsbPowerSource",
                                            0x01,
                                            "kUSBWakePortCurrentLimit",
                                            0x0BB8,
                                            "kUSBSleepPortCurrentLimit",
                                            0x0BB8,
                                            "UsbCompanionPortPresent",
                                            Zero
                                        }
                                }
                                Else
                                {
                                    Local0 = Package (0x0A)
                                        {
                                            "UsbCPortNumber",
                                            0x01,
                                            "UsbPowerSource",
                                            0x01,
                                            "kUSBWakePortCurrentLimit",
                                            0x0BB8,
                                            "kUSBSleepPortCurrentLimit",
                                            0x0BB8,
                                            "UsbCompanionPortPresent",
                                            Zero
                                        }
                                }

                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }
                        }

                        Device (HSP2)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
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
                                    PLD_UserVisible        = 0x0,
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

                        Device (SSP1)
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

                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If (U2OP == One)
                                {
                                    Local0 = Package (0x0A)
                                        {
                                            "UsbCPortNumber",
                                            0x03,
                                            "UsbPowerSource",
                                            0x03,
                                            "kUSBWakePortCurrentLimit",
                                            0x0BB8,
                                            "kUSBSleepPortCurrentLimit",
                                            0x0BB8,
                                            "UsbCompanionPortPresent",
                                            One
                                        }
                                }
                                Else
                                {
                                    Local0 = Package (0x08)
                                        {
                                            "UsbCPortNumber",
                                            0x03,
                                            "UsbPowerSource",
                                            0x03,
                                            "kUSBWakePortCurrentLimit",
                                            0x0BB8,
                                            "kUSBSleepPortCurrentLimit",
                                            0x0BB8
                                        }
                                }

                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }
                        }

                        Device (SSP2)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address

                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero,
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
                                    PLD_UserVisible        = 0x0,
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
}