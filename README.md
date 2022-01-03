# i3-setup
My personal i3-gaps setup for Debian.

Based on [Fleckenstein's i3-gaps setup](https://github.com/EliasFleckenstein03/i3-setup).

Installs zsh, oh-my-zsh, kitty, i3-gaps, i3lock-fancy, picom, feh, lua, batcat, lolcat,
cowsay, fortune.
Includes a custom zsh theme, wallpaper, kitty configuration,
i3-gaps configuration and a custom cat program written in lua.

I recommend to install this on a Debian system with no GUI.
You should probably install lightdm unless you already have a different
desktop environment installed. In this case, run you can run the
`install_additional.sh` script to install and configure lightdm.
It also installs additional desktop programs like firefox and thunderbird.

## Known issues
i3-gaps isn't in the official Debian apt repositories
and needs to be compiled from source. I'll eventually
integrate this into the `install.sh` script.
