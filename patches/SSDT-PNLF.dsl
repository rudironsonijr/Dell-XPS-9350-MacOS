/*
 * Adds Backlight Control for Laptop Screens.
 *
 * If you are using macOS Catalina or newer, you also need a Fake Ambient Light Sensor (SSDT-ALS0) so that the brightness level doesn't reset to maximum after rebooting.
 *
 * Required:
 *   - Lilu.kext
 *   - WhateverGreen.kext (has a built-in brightness driver)
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/01_Adding_missing_Devices_and_enabling_Features/Brightness_Controls_(SSDT-PNLF)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "PNLF", 0x00000000)
{
    External (\_SB.PCI0.GFX0, DeviceObj)

    If (_OSI ("Darwin"))
    {
        Device (\_SB.PCI0.GFX0.PNLF)
        {
            Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
            Name (_CID, "backlight")  // _CID: Compatible ID
            Name (_UID, 0x10)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
        }
    }
}