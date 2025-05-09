config.load_autoconfig(False)
config.source("keybindings.py")

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
c.content.user_stylesheets = "style/style.css"
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
