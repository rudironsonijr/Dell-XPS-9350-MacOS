/*
 *
 * What is AppleSMBus? Well, it mainly handles the System Management Bus, which has various functions, such as:
 *
 *   - AppleSMBusController: Aids with correct Temperature, Fan, Voltage, ICH, and other readings.
 *   - AppleSMBusPCI: Same idea as AppleSMBusController except for low bandwidth PCI devices.
 *   - Memory Reporting: Aids in proper memory reporting and can aid in getting better memory-related kernel panic details.
 *
 * In order for the SMBus to work properly under macOS, Device SMBUS (respectively SBUS) has to be present in the IO Registry.
 * Additionally, the Memory Controller Hub (MCHC) which is serviceable in macOS also needs to be present to wire it to the power management of the PCI bus.
 * So we need to verify the presence/absence of both devices to decide which SSDT(s) needs to be added.
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/01_Adding_missing_Devices_and_enabling_Features/System_Management_Bus_and_Memory_Controller_(SSDT-SBUS-MCHC)
 */
DefinitionBlock ("", "SSDT", 2, "OCLT", "MCHC", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)

    Scope (_SB.PCI0)
    {
        Device (MCHC)
        {
            Name (_ADR, Zero)  // _ADR: Address
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
        }
    }
}

