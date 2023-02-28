/*
 * Use this if you have "Method (GPRW, 2" in your ACPI
 *
 * macOS will instant wake if either USB or power states change while sleeping.
 * To fix this we need to reroute the GPRW/UPRW/LANC calls to a new SSDT, verify you have instant wake issues before trying the below.
 *
 * Use with the following ACPI Patch:
 *
 *    Find:     <data>R1BSVwI=</data>
 *    Replace:  <data>WFBSVwI=</data>
 *    Comment:  change Method(GPRW,2,N) to XPRW, pair with SSDT-GPRW.aml
 *
 * References:
 * [1] https://dortania.github.io/OpenCore-Post-Install/usb/misc/instant-wake.html
 * [2] https://github.com/dortania/OpenCore-Post-Install/blob/master/extra-files/GPRW-Patch.plist
 */
DefinitionBlock ("", "SSDT", 2, "hack", "GPRW", 0x00000000)
{
    External (XPRW, MethodObj)    // 2 Arguments

    Method (GPRW, 2, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If ((0x6D == Arg0))
            {
                Return (Package (0x02)
                {
                    0x6D,
                    Zero
                })
            }

            If ((0x0D == Arg0))
            {
                Return (Package (0x02)
                {
                    0x0D,
                    Zero
                })
            }
        }

        Return (XPRW (Arg0, Arg1))
    }
}

