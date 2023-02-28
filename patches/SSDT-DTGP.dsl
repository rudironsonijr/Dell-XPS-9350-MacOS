/*
 * DTGP method explained
 *
 * In addition to using DeviceProperties to inject device parameters into macOS, you can also use the method _DSM (Device Specific Method) to do so.
 * It contains properties for a device and makes use of the method DTGP which is universal for all devices.
 * It is specified in the DSDT of real Macs. Its purpose is to inject custom parameters into some devices.
 * Without this method, patched DSDTs would not work well.
 *
 * The DTGP (Device Temporary Got Power) method is called by the ACPI firmware to determine whether a specific device should temporarily receive power or not. 
 * The method takes five arguments:
 *
 * - Arg0: A UUID (Universally Unique Identifier) for the device being checked for power.
 * - Arg1: A flag indicating whether the device should receive power (1) or not (0).
 * - Arg2: Another flag indicating the type of power being requested. In this case, only values 0 and 1 are referenced.
 * - Arg4: A buffer containing the result of the power check.
 *
 * - Return: A return value indicating whether the power check was successful (1) or failed (0).
 *
 * Basically, macOS won't actually read/merge device properties from ACPI unless a Buffer of 0x03 is returned when it asks for this property (Arg0 = UUID, Arg1 = 1 and Arg2 = 0).
 *
 * DTGP won't pass through calls to device-specific methods unless a specific UUID is provided that indicates that macOS is calling the _DSM.
 * macOS has a non-standard device enumeration behavior: it first probes each ACPI Device's DSM by passing over only 2 arguments (one of which is the UUID). 
 * macOS then expects the _DSM to return the number of additional arguments that can be used.
 * It's fine if the device returns more arguments than expected, but not less, so it's best to return the maximum, which is three (Arg0 to Arg2).
 *
 * macOS will call _DSM methods of Device objects with only two arguments at first. When this occurs, the method should return 3.
 * So all you need to do is check if Arg2 exists (is non-zero).
 * If it doesn't, return 3. If it does, return whatever properties you want macOS to use for that device.
 *
 * In other words, store is saving information you want to hand over to macOS as a local variable via the DTGP method.
 * So its whole purpose is to handle macOS-specific behavior without breaking non-macOS behavior - like running Windows on real Macs (with Boot Camp) for example.
 *
 * References:
 * [1] 
 */
DefinitionBlock ("", "SSDT", 0, "hack", "_Debug", 0x00001000)
{
    Method (DTGP, 5, NotSerialized)
    {
        If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
        {
            If ((Arg1 == One))
            {
                If ((Arg2 == Zero))
                {
                    Arg4 = Buffer (One)
                        {
                             0x03                                             // .
                        }
                    Return (One)
                }

                If ((Arg2 == One))
                {
                    Return (One)
                }
            }
        }

        Arg4 = Buffer (One)
            {
                 0x00                                             // .
            }
        Return (Zero)
    }
}