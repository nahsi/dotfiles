# general
config.load_autoconfig()
c.content.autoplay = False
c.backend = "webengine"
c.zoom.default = "125%"
c.completion.height = "30%"
c.url.start_pages = ["https://home.service.consul"]
c.url.default_page = "https://home.service.consul"
config.source("colors.py")

c.downloads.location.directory = "$XDG_DOWNLOAD_DIR"

# bokmarklets
c.aliases.update({ 'link': 'open https://links.service.consul/bookmarks/new?url={url}&auto_close'})

# fonts
c.fonts.default_family = ["Fira Sans", "Roboto", "Noto Sans"]
c.fonts.default_size = "10pt"

c.fonts.keyhint = "12pt monospace"
c.fonts.statusbar = "12pt monospace"
c.fonts.completion.category = "bold 10pt monospace"
c.fonts.completion.entry = "10pt monospace"

c.fonts.web.family.fixed = "Fira Code"

# searches
c.url.searchengines["DEFAULT"] = "https://duckduckgo.com/?q={}"
c.url.searchengines["aw"] = "https://wiki.archlinux.org/?search={}"
c.url.searchengines["gw"] = "https://wiki.gentoo.org/index.php?search={}&go=Go"
c.url.searchengines["yt"] = "https://www.youtube.com/results?search_query={}"
c.url.searchengines["w"] = "https://secure.wikimedia.org/wikipedia/en/w/index.php?search={}"
c.url.searchengines["gg"] = "http://www.google.com/search?hl=en&q={}"
c.url.searchengines["gh"] = "https://github.com/search?q={}&type=Code"

# keys
config.bind("e", "spawn mpv {url}")
config.bind("E", "hint links spawn mpv {hint-url}")
config.bind(",p", "spawn --userscript qute-pass --mode pass")
config.bind(",e", "open-editor")
config.bind("<Ctrl-e>", "open-editor", mode="insert")
