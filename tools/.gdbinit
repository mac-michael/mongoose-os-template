#target remote :3333

# map remote path to local
set substitute-path /c/mos c:/mos
set substitute-path /mongoose-os c:/mos/mongoose-sources/mongoose-os

define target hookpost-remote
#file C:/mos/mongoose-os-template/build/objs/mongoose-os-template.elf

mon reset halt
flushregs
# stop at mgos_app_init
thb mgos_app_init

end

