config.load_autoconfig(False)
config.source("keybindings.py")

config.set(
    "qt.args",
    [
        "ignore-gpu-blocklist",
        "enable-gpu-rasterization",
        "enable-accelerated-video-decode",
        "enable-quic",
        "enable-zero-copy",
    ],
)
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "scholar": "https://scholar.google.com/scholar?q={}",
    "css": "https://consensus.app/search/new/?q={}",
}
c.url.default_page = "https://www.github.com"
c.tabs.show = "never"
c.tabs.position = "left"
c.auto_save.session = True
c.fonts.default_family = "JetbrainsMono Nerd Font Mono"
c.fonts.default_size = "8pt"
c.content.user_stylesheets = "style/style.css"
c.content.javascript.clipboard = "access-paste"
c.scrolling.bar = "always"
c.tabs.padding = {
    "top": 3,
    "bottom": 3,
    "left": 5,
    "right": 5,
}
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.preferred_color_scheme = "dark"
c.statusbar.widgets = ["tabs", "text: - ", "scroll"]
c.qt.chromium.sandboxing = "disable-all"
c.zoom.default = "80%"
c.qt.highdpi = True

config.set(
    "hints.selectors",
    {
        "all": [
            "reddit-search-large",
            "a",
            "area",
            "textarea",
            "select",
            'input:not([type="hidden"])',
            "button",
            "frame",
            "iframe",
            "img",
            "link",
            "summary",
            '[contenteditable]:not([contenteditable="false"])',
            "[onclick]",
            "[onmousedown]",
            '[role="link"]',
            '[role="option"]',
            '[role="button"]',
            '[role="tab"]',
            '[role="checkbox"]',
            '[role="switch"]',
            '[role="menuitem"]',
            '[role="menuitemcheckbox"]',
            '[role="menuitemradio"]',
            '[role="treeitem"]',
            "[aria-haspopup]",
            "[ng-click]",
            "[ngClick]",
            "[data-ng-click]",
            "[x-ng-click]",
            '[tabindex]:not([tabindex="-1"])',
        ],
        "images": [
            "img",
        ],
        "inputs": [
            'input[type="text"]',
        ],
    },
    "https://www.reddit.com",
)
