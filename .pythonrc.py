import readline
import rlcompleter
readline.parse_and_bind("tab: complete")

import sys
def custom_displayhook(value):
    if value is not None:
        sys._last_value = value
        if isinstance(value, int):
            print(f"{value:,}")
        else:
            print(value)
sys.displayhook = custom_displayhook
