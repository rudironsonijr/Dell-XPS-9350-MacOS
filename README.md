



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