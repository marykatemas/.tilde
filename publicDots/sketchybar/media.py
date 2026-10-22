#!/usr/bin/env python3

import json
import subprocess

SB = "/opt/homebrew/bin/sketchybar"
MEDIA = "/opt/homebrew/bin/media-control"
ITEMS = ("media", "media_center")

STATES = {
    True: ("􀑪", "0xffa78bfa", "0xf2ffffff"),
    False: ("􀊆", "0x59a78bfa", "0x9effffff"),
}


def render(line):
    try:
        payload = json.loads(line)["payload"]
        title = payload.get("title") or ""
        artist = payload.get("artist") or ""
    except (json.JSONDecodeError, KeyError, TypeError, AttributeError):
        return {"drawing": "off"}
    if not title and not artist:
        return {"drawing": "off"}
    playing = bool(payload.get("playing"))
    glyph, glyph_color, label_color = STATES[playing]
    return {
        "drawing": "on",
        "icon": glyph,
        "icon.color": glyph_color,
        "label": " /// ".join(part for part in (title, artist) if part),
        "label.color": label_color,
        "scroll_texts": "on" if playing else "off",
    }


def apply(props):
    args = [SB, "--animate", "sin", "15"]
    for item in ITEMS:
        args.append("--set")
        args.append(item)
        args.extend(f"{key}={value}" for key, value in props.items())
    subprocess.run(args)


def main():
    proc = subprocess.Popen(
        [MEDIA, "stream", "--no-diff", "--no-artwork", "--debounce=250"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )
    for line in proc.stdout:
        apply(render(line))


if __name__ == "__main__":
    main()
