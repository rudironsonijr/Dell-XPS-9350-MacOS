/*
 * Make brightness control and brightness keys work
 *
 * The OSID method exists on most Dell machines. It includes two variables, ACOS and ACSE, which determine the machine's operating mode. For example, the ACPI brightness shortcut method only works if ACOS >= 0x20.
 *
 * Following are some of the relationships between the 2 variables and the operating mode. For more details about the OSID method, please see DSDT's Method
 *
 * ACOS geq 0x20, the brightness shortcut works
 * ACOS eq 0x80 and ACSE = 0 for win7 mode. In this case the breathing light blinks during machine sleep
 * ACOS eq 0x80, ACSE = 1 for win8 mode. In this case the breathing light is off during the machine sleep
 * The specific content of the 2 variables in the OSID method depends on the OS itself, you must use OSID patch or this patch to change these 2 variables to meet the requirements macOS expects.
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/05_Laptop-specific_Patches/Brand-specific_Patches/Dell_Special_Patch
 */
DefinitionBlock ("", "SSDT", 2, "hack", "ALS0", 0x00000000)
{
    External (_SB_.ACOS, IntObj)
    External (_SB_.ACSE, IntObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.ACOS = 0x80
            \_SB.ACSE = 0x02
        }
    }
}

