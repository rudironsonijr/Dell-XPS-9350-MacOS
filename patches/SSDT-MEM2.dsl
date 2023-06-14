/*
 *
 * MEM2 is relevant for Intel iGPUs in Laptops only.
 * It makes the iGPU use MEM2 instead of TPMX.
 *
 * Little is known about the device besides that without patching TPMX in DSDT, PNP0C01 and IOAccelMemoryInfoUserClient will not be loaded correctly.
 *
 * References:
 * [1] https://www.tonymacx86.com/threads/guide-patching-laptop-dsdt-ssdts.152573/page-148#post-1277391
 * [2] https://github.com/5T33Z0/OC-Little-Translated/tree/main/01_Adding_missing_Devices_and_enabling_Features/SSDT-MEM2
 */
DefinitionBlock ("", "SSDT", 2, "hack", "MEM2", 0x00000000)
{
    Device (MEM2)
    {
        Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
        Name (_UID, 0x02)  // _UID: Unique ID
        Name (CRS, ResourceTemplate ()
        {
            Memory32Fixed (ReadWrite,
                0x20000000,         // Address Base
                0x00200000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x40000000,         // Address Base
                0x00200000,         // Address Length
                )
        })
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Return (CRS) /* \MEM2.CRS_ */
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
    }
}

