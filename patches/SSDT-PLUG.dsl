/* XCPM power management compatibility table.
 *
 * Enables X86PlatformPlugin to utilize XCPM CPU Power Management on 4th Gen Intel Core CPUs and newer.
 *
 * References:
 * [1] https://dortania.github.io/Getting-Started-With-ACPI/Universal/plug.html
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "CpuPlug", 0x00003000)
{
    External (_PR_.CPU0, ProcessorObj)

    Method (PMPM, 4, NotSerialized)
    {
        If ((Arg2 == Zero))
        {
            Return (Buffer (One)
            {
                 0x03                                             // .
            })
        }

        Return (Package (0x02)
        {
            "plugin-type",
            One
        })
    }

    Scope (_PR.CPU0)
    {
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Return (PMPM (Arg0, Arg1, Arg2, Arg3))
        }
    }

    Scope (\_GPE)
    {
        Method (LXEN, 0, NotSerialized)
        {
            Return (One)
        }
    }
}

