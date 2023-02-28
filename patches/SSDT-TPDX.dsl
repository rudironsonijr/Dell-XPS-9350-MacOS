/*
 * Enable I2C Touchpad
 *
 *============================================================================================
 *
 * 1. Enable GPIO:
 *
 * The presence of a GPIO device is required for a I2C TouchPads to function properly.
 * This is achieved by setting "GPEN = One" to enable GPIO
 *
 *============================================================================================
 *
 *============================================================================================
 *
 * 2. Enable I2C Touchpad:
 *
 * This method provides a solution for implementing Hotpatch patches to I2C device.
 * We'll disable TPD0 and TPD1 by setting "SDS0 = Zero" and "SDS1 = Zero"
 * After that, we'll create a new device TPXX and port all the contents of the original TPD1 to TPXX (and implement some adjustments).
 *
 *============================================================================================
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/05_Laptop-specific_Patches/Trackpad_Patches#enabling-i2c-touchpads
 * [2] https://github.com/5T33Z0/OC-Little-Translated/tree/main/05_Laptop-specific_Patches/Trackpad_Patches/I2C_TrackPad_Patches
 */
DefinitionBlock ("", "SSDT", 2, "hack", "TPDX", 0x00000000)
{
    External (_SB_.GNUM, MethodObj)    // 1 Arguments
    External (_SB_.INUM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.HIDD, MethodObj)    // 5 Arguments
    External (_SB_.PCI0.HIDG, IntObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.TP7D, MethodObj)    // 6 Arguments
    External (_SB_.PCI0.TP7G, IntObj)
    External (_SB_.SHPO, MethodObj)    // 2 Arguments
    External (DSID, FieldUnitObj)
    External (GPDI, FieldUnitObj)
    External (GPEN, FieldUnitObj)
    External (SDM1, FieldUnitObj)
    External (SDS0, FieldUnitObj)
    External (SDS1, FieldUnitObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            SDS0 = Zero
            SDS1 = Zero
            GPEN = One
        }
    }

    Scope (_SB.PCI0.I2C1)
    {
        Device (TPDX)
        {
            Name (SSCN, Package (0x03)
            {
                0x0210,
                0x0280,
                0x1E
            })
            Name (FMCN, Package (0x03)
            {
                0x80,
                0xA0,
                0x1E
            })
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y00)
                {
                    0x00000000,
                }
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, \_SB.PCI0.I2C1.TPDX._Y00._INT, INT2)  // _INT: Interrupts
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                INT1 = GNUM (GPDI)
                INT2 = INUM (GPDI)
                If ((SDM1 == Zero))
                {
                    SHPO (GPDI, One)
                }

                _HID = "DLL0704"
                HID2 = 0x20
            }

            Name (_HID, "XXXX0000")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
        }
    }
}

