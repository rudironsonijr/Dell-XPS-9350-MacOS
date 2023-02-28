/*
 * Fix Shutdown/Restart - DSDT patches to rename _PTS and _WAK to ZPTS and ZWAK are needed.
 *
 * So an odd quirk you may run into with macOS is that when you shutdown, your PC may instead restart itself.
 * This is actually due to a missing S5 call that powers down the controller.
 * Of course Windows and Linux implement hacks to get around this but macOS has no such fixes, instead we need to do the dirty work and fix their ACPI writing. 
 *
 * In config ACPI: _PTS to ZPTS(1,N)
 *    Find:     <data>X1BUUwE=</data>
 *    Replace:  <data>WlBUUwE=</data>
 *    Comment:  <string>Rename _PTS to ZPTS</string>
 *
 * In config ACPI: _WAK to ZWAK(1,N)
 *    Find:     <data>X1dBSwE=</data>
 *    Replace:  <data>WldBSwE=</data>
 *    Comment:  <string>Rename _WAK to ZWAK</string>
 *
 * References:
 * [1] https://dortania.github.io/OpenCore-Post-Install/usb/misc/shutdown.html
 */
DefinitionBlock ("", "SSDT", 2, "hack", "PTSWAK", 0x00000000)
{
    External (_SB_.LID0, DeviceObj)
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)    // 1 Arguments
    External (ZWAK, MethodObj)    // 1 Arguments

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        ZPTS (Arg0)
        If ((0x05 == Arg0))
        {
            \_SB.PCI0.XHC.PMEE = Zero
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        Local0 = ZWAK (Arg0)
        If ((0x03 == Arg0))
        {
            Notify (\_SB.LID0, 0x80) // Status Change
        }

        Return (Local0)
    }
}

