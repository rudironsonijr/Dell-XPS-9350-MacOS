/*
 * Fix HPET - Generated through SSDTTime.
 *
 * On a few systems, patching IRQ might be required and is required on almost all laptops.
 * The IRQ patching is not required by every system, but mostly on OEM systems (such as search Dell and search HP).
 * These fixes are needed mainly for onboard Audio/USB/Thunderbolt/FireWire.
 * For a few systems, the RTC and HPET tend to take IRQs from other devices like USB and Audio and can prevent such devices from working under macOS/OS X and therefore you must patch out the IRQ conflicts in order to make those devices work under macOS/OS X.
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/01_Adding_missing_Devices_and_enabling_Features/IRQ_and_Timer_Fix_(SSDT-HPET)
 * [2] https://dortania.github.io/Getting-Started-With-ACPI/Universal/irq.html
 */
DefinitionBlock ("", "SSDT", 2, "hack", "HPET", 0x00000000)
{
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)
    External (_SB_.PCI0.LPCB.HPET.XCRS, MethodObj)    // 0 Arguments

    Scope (\_SB.PCI0.LPCB.HPET)
    {
        Name (BUFX, ResourceTemplate ()
        {
            IRQNoFlags ()
                {0,8,11}
            Memory32Fixed (ReadWrite,
                0xFED00000,         // Address Base
                0x00000400,         // Address Length
                )
        })
        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
        {
            If ((_OSI ("Darwin") || !CondRefOf (\_SB.PCI0.LPCB.HPET.XCRS)))
            {
                Return (BUFX) /* \_SB_.PCI0.LPCB.HPET.BUFX */
            }

            Return (\_SB.PCI0.LPCB.HPET.XCRS ())
        }
    }
}

