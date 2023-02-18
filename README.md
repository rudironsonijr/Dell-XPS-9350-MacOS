# OpenCore Configuration for Dell XPS 15 9350

## UEFI BIOS Variables Setup
### Desired changes
| Variable                                 | Offset | Default         | Desired         | Comment |
|------------------------------------------|--------|-----------------|-----------------|---------|
| CFG Lock                                 | 0x109  | 0x01 (Enabled)  | 0x00 (Disabled) |         |
| CSM Support                              | 0xD83  | 0x01 (Enabled)  | 0x00 (Disabled) |         |
| DVMT Pre-Allocated                       | 0x432  | 0x02 (64M)      | 0x02 (64M)      |         |
| DVMT Total Gfx Memory                    | 0x433  | 0x02 (256M)     | 0x03 (MAX)      |         |
| Above 4GB MMIO BIOS assignment           | 0x437  | 0x00 (Disabled) | 0x01 (Enabled)  |         |
| GPIO filter                              | 0x120A | 0x00            | 0x01            |         |
| Native OS Hot Plug                       | 0xFF9  | N/A             | 0x01            |         |
| Thunderbolt(TM) PCIe Cache-line Size     | 0xFF1  | 0x20 (32)       | 0x80 (128)      |         |
| Wait time in ms after applying Force Pwr | 0xFF3  | 0xC8 (200)      | 0xC8 (200)      |         |

### Needs to be disabled, otherwise they'll break sleep and hibernation (mode 25)
| Variable                                 | Offset | Default         | Desired         | Comment |
|------------------------------------------|--------|-----------------|-----------------|---------|
| Thunderbolt Boot Support                 | 0xFEE  | 0x00 (Disabled) | 0x00 (Disabled) |         |
| Thunderbolt Usb Support                  | 0x120F | 0x00 (Disabled) | 0x00 (Disabled) |         |
| Wake From Thunderbolt(TM) Devices        | 0xFF0  | 0x01 (Enabled)  | 0x00 (Disabled) |         |
| GPIO3 Force Pwr                          | 0xFF2  | N/A             | 0x00 (Disabled) |         |

### Needs more testing
| Variable                                 | Offset | Default         | Desired         | Comment |
|------------------------------------------|--------|-----------------|-----------------|---------|
| Skip PCI OptionRom                       | 0x1003 | 0x00            | 0x00            |         |
| SW SMI on TBT hot-plug                   | 0x47A  | 0x01 (Enabled)  | 0x01            |         |

## ACPI Debug

``` bash
sudo log show --last boot | grep -i "AppleACPIPlatform"
```

``` bash
log show --debug --last boot --predicate 'process == "kernel"'
```

``` bash
log stream --process 0 | grep ACPI
```

## References

- [Dortania's OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/)
- [Dortania's Getting Started With ACPI](https://dortania.github.io/Getting-Started-With-ACPI/)
- [DarkWake on macOS Catalina](https://www.insanelymac.com/forum/topic/342002-darkwake-on-macos-catalina-boot-args-darkwake8-darkwake10-are-obsolete/)
- [XPS15 9560 EFI by jardenliu and SilentSliver](https://github.com/jardenliu/XPS15-9560-Catalina/tree/OpenCore/)
- [Post on fixing TBT on High Sierra](https://www.tonymacx86.com/threads/how-to-build-your-own-imac-pro-successful-build-extended-guide.229353/)
- [SSDT for TBT Hotplug](https://www.tonymacx86.com/threads/in-progress-ssdt-for-thunderbolt-3-hotplug.248784/page-55)
- [osy86's Hac-Mini](https://osy.gitbook.io/hac-mini-guide/)
