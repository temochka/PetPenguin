import sublime, os

def plugin_loaded():
    dpi_settings = sublime.load_settings("Preferences.sublime-settings")
    dpi_settings.set("dpi_scale", float(os.environ["UI_SCALE_FACTOR"]))
    sublime.save_settings("Preferences.sublime-settings")

