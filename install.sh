#! /bin/bash
function command_exists {
	command -v $1 &> /dev/null
}

if [[ "$USER" != "root" ]]; then
	if command_exists sudo; then
		SUDO="sudo -E"
	elif command_exists doas; then
		SUDO="doas"
		if ! ENV_TEST="test123" doas env | grep "ENV_TEST=test123" > /dev/null; then
			echo "Please make sure doas keeps the environment for emerge (add keepenv to /etc/doas.conf)"
			exit 1
		fi
	fi
fi

if command_exists apt; then
	$SUDO apt install -y \
		meson \
		ninja-build \
		xorg \
		i3status \
		i3lock-fancy \
		feh \
		picom \
		bat \
		lolcat \
		cowsay \
		fortune \
		zsh \
		lua5.3 \
		git \
		imagemagick

	# i3-gaps dependencies
	$SUDO apt install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev

	git clone https://github.com/Airblader/i3.git
	mkdir -p i3/build
	cd $_ # same as cd i3/build
	meson ..
	ninja
	sudo ninja install
	cd ../..

elif command_exists emerge; then
	USE="
>=x11-libs/cairo-1.16.0-r5 X
>=x11-libs/libxkbcommon-1.3.1 X
>=x11-libs/pango-1.48.10 X
>=media-libs/freetype-2.11.0-r2 harfbuzz
>=sys-auth/pambase-20210201.1 elogind
>=media-libs/libglvnd-1.3.4
>=net-wireless/wpa_supplicant-2.9-r5 dbus
>=app-crypt/gcr-3.40.0 gtk
" \
	$SUDO emerge --ask --newuse \
		x11-base/xorg-x11 \
		x11-wm/i3-gaps \
		x11-misc/dmenu \
		x11-misc/i3lock \
		x11-misc/i3status \
		gnome-extra/nm-applet \
		x11-misc/xss-lock \
		media-gfx/feh \
		x11-misc/picom \
		sys-apps/bat \
		games-misc/lolcat \
		games-misc/cowsay \
		games-misc/fortune-mod \
		app-shells/zsh \
		dev-lang/lua:5.3 \
		dev-vcs/git \
		media-gfx/imagemagick \
		media-fonts/ubuntu-font-family \
		media-fonts/hack

	$SUDO ln -s /usr/local/bin/bat /usr/bin/batcat
else
	echo "Distro not supported"
	exit 1
fi

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p ~/bin/
cp cat ~/bin/

mkdir -p ~/.config/i3/
cp i3-config ~/.config/i3/config

mkdir -p ~/.config/i3status/
cp i3status-config ~/.config/i3status/config

mkdir -p ~/.config/kitty/
cp kitty.conf ~/.config/kitty/kitty.conf

mkdir -p ~/.config/
cp picom.conf ~/.config/picom.conf

mkdir -p ~/.oh-my-zsh/themes/
cp himbeer.zsh-theme ~/.oh-my-zsh/themes/himbeer.zsh-theme

mkdir -p ~/
cp zshrc ~/.zshrc

mkdir -p ~/
cp wallpaper.png ~/Pictures/himbeerlogo.png
ln -s ~/Pictures/himbeerlogo.png ~/.wallpaper.png
