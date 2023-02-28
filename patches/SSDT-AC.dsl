/*
* Fix AC Adapter SB
* This patch attaches an AC Adapter Device existing in a Laptop's DSDT to the AppleACPIACAdapter service in the IORegistry of macOS.
* This is optional and mostly cosmetic.
*
* References:
* [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/01_Adding_missing_Devices_and_enabling_Features/AC_Adapter_(SSDT-AC)
*/
DefinitionBlock ("", "SSDT", 2, "hack", "AC__", 0x00000000)
{
    External (_SB_.AC__, DeviceObj)

    Scope (\_SB.AC)
    {
        If (_OSI ("Darwin"))
        {
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x18,
                0x03
            })
        }
    }
}

