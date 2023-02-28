/*
 * Keyboard configuration
 *
 * Modify PS2 Keyboard mappings
 *
 * Keyboard keys can be re-mapped for triggering different keys than the one that's actual pressed.
 * Function keys like F2 can be re-mapped to triggering F10, for example.
 * But beware that only keys that can capture PS2 Scan Code under macOS can be re-mapped!
 *
 * This particular SSDT will modify the Left and Right alt so they behave like Command in macOS (windows key).
 * It will also remap windows key so it behaves like a Options key in macOS.
 *
 * References:
 * [1] https://github.com/5T33Z0/OC-Little-Translated/tree/main/05_Laptop-specific_Patches/Fixing_Keyboard_Mappings_and_Brightness_Keys
 */
DefinitionBlock ("", "SSDT", 2, "hack", "RMCF", 0x00000000)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Name (RMCF, Package (0x0A)
        {
            "Keyboard",
            Package (0x02)
            {
                "Custom PS2 Map",
                Package (0x05)
                {
                    "e05b=38",   // e05d is PS2 for right window key, e038 is PS2 for right alt (normal map is e05d=3d)
                    "e038=e05b", // e038 is PS2 for left alt, e05d is PS2 for right window key (normal map is e038=36)
                    "38=e05b",   // 38 is PS2 for left control, e05b is PS2 for left window key (normal map is 38=3a)
                    "e027=0",
                    "e028=0"
                }
            },

            "Mouse",
            Package (0x02)
            {
                "DisableDevice",
                ">y"
            },

            "Synaptics TouchPad",
            Package (0x02)
            {
                "DisableDevice",
                ">y"
            },

            "ALPS GlidePoint",
            Package (0x02)
            {
                "DisableDevice",
                ">y"
            },

            "Sentelic FSP",
            Package (0x02)
            {
                "DisableDevice",
                ">y"
            }
        })
    }
}

