#add-auto-load-safe-path C:\mos\mongoose-os-clion-template\.gdbinit

#target remote :3333
set substitute-path /c/mos c:/mos
set substitute-path /mongoose-os c:/mos/git_sources/mongoose-os


define target hookpost-remote
file C:/mos/mongoose-os-clion-template/build/objs/mongoose-os-clion-template.elf


mon reset halt
flushregs
thb mgos_app_init

end

