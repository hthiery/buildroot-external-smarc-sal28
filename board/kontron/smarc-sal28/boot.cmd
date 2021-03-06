if test "${devtype}" = "mmc"; then
	echo "Root File Sytem on MMC"
	setenv rootfs /dev/mmcblk${devnum}p2
elif test "${devtype}" = "usb"; then
	echo "Root File Sytem on USB"
	setenv rootfs /dev/sda2
elif test "${devtype}" = "nvme"; then
	echo "Root File System on NVMe "
	setenv rootfs /dev/nvme${devnum}n1p2
	sleep 2
fi

setenv bootargs root=${rootfs} rootwait default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080 cma=256M ${extrabootargs}

load ${devtype} ${devnum} ${kernel_addr_r} Image
load ${devtype} ${devnum} ${fdt_addr_r} sl28.dtb

echo "Preparing for overlays"
setexpr fdt_overlay_addr_r ${fdt_addr_r} + 10000
fdt addr ${fdt_addr_r}
fdt resize 4000

if load ${devtype} ${devnum} ${fdt_overlay_addr_r} overlays/sl28-variant${variant}.dtbo; then
	echo "Overlaying sl28-variant${variant}.dtbo"
	fdt apply ${fdt_overlay_addr_r}
else
	echo "Loading overlay for variant ${variant} failed. Aborting."
	exit 1
fi

if test -n ${carrier}; then
	if load ${devtype} ${devnum} ${fdt_overlay_addr_r} overlays/carrier-${carrier}.dtbo; then
		echo "Overlaying carrier-${carrier}.dtbo"
		fdt apply ${fdt_overlay_addr_r}
	else
		echo "Loading overlay for carrier ${carrier} failed. Aborting."
		exit 1
	fi
fi

for overlay in ${overlays}; do
	if load ${devtype} ${devnum} ${fdt_overlay_addr_r} overlays/${overlay}.dtbo; then
		echo "Overlaying ${overlay}.dtbo"
		fdt apply ${fdt_overlay_addr_r}
	else
		echo "Loading overlay ${overlay} failed. Aborting."
		exit 1
	fi
done

booti ${kernel_addr_r} - ${fdt_addr_r}
