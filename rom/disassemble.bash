#!/bin/bash

m68k-linux-gnu-objdump -b binary --adjust-vma=0x800000 -m m68k --start-address=0x80001a -D bin/merged.bin
