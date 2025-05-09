# Unbind default keys
keys_unbind = [
    "<Shift-h>",
    "<Shift-j>",
    "<Shift-k>",
    "<Shift-l>",
    ";I",
    ";b",
    ";d",
    ";f",
    ";h",
    ";i",
    ";r",
    "r",
    "<Ctrl-Shift-w>",
    "<Ctrl-v>",
    "<Ctrl-t>",
    "<Ctrl-w>",
    "<Ctrl-s>",
    "D",
    "d",
    "tch",
    "tcH",
    "tCh",
    "tCH",
    "tcu",
    "tCu",
    "tih",
    "tiH",
    "tIh",
    "tIH",
    "tiu",
    "tIu",
    "tph",
    "tpH",
    "tPh",
    "tPH",
    "tpu",
    "tPu",
    "tsh",
    "tsH",
    "tSh",
    "tSH",
    "tsu",
    "tSu",
    "PP",
    "Pp",
    "pP",
    "sf",
    "sk",
    "sl",
]
for keys in keys_unbind:
    config.unbind(keys)

# Hints
config.bind(
    "M",
    'hint links spawn nohup mpv -ao=pulse --cache=yes --demuxer-max-bytes=300M --demuxer-max-back-bytes=100M -ytdl-format="bv[ext=mp4]+ba/b" {hint-url}',
)
config.bind("P", "hint links userscript zathura.sh")

# Automations
config.bind("gc", ":spawn --userscript git_clone.sh")

# Shortcuts for links
config.bind("wp", "open -t http://openssl.com")
config.bind("gpt", "open -t https://chatgpt.com")

# Navigation
map = {
    "h": {
        "Shift": "back",
        "Alt": "fake-key --global <Left>",
    },
    "j": {
        "default": "scroll-px 0 300",
        "Ctrl": "tab-next",
        "Alt": "fake-key --global <Down>",
    },
    "k": {
        "default": "scroll-px 0 -300",
        "Ctrl": "tab-prev",
        "Alt": "fake-key --global <Up>",
    },
    "l": {
        "Shift": "forward",
        "Alt": "fake-key --global <Right>",
    },
}

for navigation_key, commands in map.items():
    for mod_key, command in commands.items():
        if mod_key == "default":
            config.bind(f"{navigation_key}", command)
        else:
            config.bind(f"<{mod_key}-{navigation_key}>", command)
config.bind("<space>ff", "cmd-set-text --space :tab-focus ")
config.bind("<space>o", "cmd-set-text --space :open -t ")

# Tabs
for i in range(99):
    if i + 1 < 10:
        config.bind(f"<space>{i+1}", f"tab-focus {i+1}")
    else:
        config.bind(f"{i+1}", f"tab-focus {i+1}")

config.bind("dd", "tab-close")
config.bind("r", "reload")
config.bind("<space>e", "config-cycle tabs.show always never")

# Others
config.bind("`", "mode-enter passthrough")
config.bind("`", "mode-leave", mode="passthrough")
config.bind("<Ctrl-h>", "open -t qute://history/")
config.bind("R", "config-source")
