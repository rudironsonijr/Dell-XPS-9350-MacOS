/*
 * ACPI Debug
 *
 * By adding debug code to SSDT-xxxx Hotpatches, it is possible to check the working status of an ACPI table on the console for debugging.
 *
 * # For streaming ACPI debug logs (e.g. hot (un)plugging USB-C/TB3 devices):
 * > log stream --predicate 'process == "kernel" AND senderImagePath CONTAINS "AppleACPIPlatform"' --style syslog | awk '/ACPI Debug/{getline; getline; print}'
 *
 * # For viewing previous ACPI debug logs (since boot):
 * > log show --last boot --predicate 'process == "kernel" AND senderImagePath CONTAINS "AppleACPIPlatform"' --style syslog | awk '/ACPI Debug/{getline; getline; print}
 *
 * Required:
 *   -  DebugEnhancer.kext
 *
 * References:
 * [1] https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/kernel-debugging.html#efi-setup
 * [2] https://gist.github.com/al3xtjames/39ebea4d615c8aed829109a9ea2cd0b5
 */
DefinitionBlock ("", "SSDT", 0, "hack", "_Debug", 0x00001000)
{
    /*
     * Many OEM ACPI implementations have a ADBG function which is used for
     * debug logging. In almost all cases, this function calls MDBG, which is
     * supposed to be defined in a ACPI debug SSDT (but is usually missing).
     * This should make ADBG functional.
     */
    Method (MDBG, 1, NotSerialized)
    {
        Debug = Arg0
    }

    Method (XDBG, 1, NotSerialized)
    {
        Debug = Arg0
    }

    Method (DBG1, 1, NotSerialized)
    {
        Debug = Arg0
    }

    Method (DBG2, 2, NotSerialized)
    {
        Debug = Arg0
        Debug = Arg1
    }

    Method (DBG3, 3, NotSerialized)
    {
        Debug = Arg0
        Debug = Arg1
        Debug = Arg2
    }
}

