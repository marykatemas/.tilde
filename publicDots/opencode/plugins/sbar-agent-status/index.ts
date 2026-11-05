import { spawn } from "node:child_process"
import { Plugin } from "@opencode/plugin"

const SB = "/opt/homebrew/bin/sketchybar"
const ITEMS = ["agent", "agent_center"] as const
const DONE_MS = 5000

const STATES = {
  working: { label: "w", icon: "0xff8e8e93", labelColor: "0xf2ffffff" },
  blocked: { label: "b", icon: "0xffff453a", labelColor: "0xffff453a" },
  done: { label: "d", icon: "0xff00c15a", labelColor: "0xff00c15a" },
  idle: { label: "i", icon: "0x598e8e93", labelColor: "0x9effffff" },
} as const

type Status = keyof typeof STATES

function render(status: Status) {
  const { label, icon, labelColor } = STATES[status]
  const args = ["--animate", "sin", "15"]
  for (const item of ITEMS) {
    args.push(
      "--set", item,
      "drawing=on",
      "icon=󰚩",
      `icon.color=${icon}`,
      `label=${label}`,
      `label.color=${labelColor}`,
    )
  }
  spawn(SB, args, { stdio: "ignore" })
}

export default Plugin.define({
  id: "sbar.agent.status",
  setup(ctx) {
    const running = new Set<string>()
    const pending = new Set<string>()
    // shortcut: in-memory state; a sketchybar reload or server crash shows stale status until the next event.
    let shown: Status | undefined
    let last: "done" | "idle" = "idle"
    let reset: ReturnType<typeof setTimeout> | undefined

    function publish() {
      const status: Status = pending.size ? "blocked" : running.size ? "working" : last
      if (status === shown) return
      shown = status
      render(status)
    }

    function finish(outcome: "done" | "idle") {
      clearTimeout(reset)
      last = outcome
      if (outcome === "done") {
        reset = setTimeout(() => {
          last = "idle"
          publish()
        }, DONE_MS)
      }
    }

    publish()

    const controller = new AbortController()
    void (async () => {
      try {
        for await (const event of ctx.event.subscribe({ signal: controller.signal })) {
          switch (event.type) {
            case "session.execution.started":
              running.add(event.data.sessionID)
              break
            case "session.execution.succeeded":
              running.delete(event.data.sessionID)
              finish("done")
              break
            case "session.execution.failed":
            case "session.execution.interrupted":
              running.delete(event.data.sessionID)
              finish("idle")
              break
            case "permission.asked":
              pending.add(`permission:${event.data.id}`)
              break
            case "permission.replied":
              pending.delete(`permission:${event.data.requestID}`)
              break
            case "form.created":
              pending.add(`form:${event.data.form.id}`)
              break
            case "form.replied":
            case "form.cancelled":
              pending.delete(`form:${event.data.id}`)
              break
            default:
              continue
          }
          publish()
        }
      } catch (error) {
        if (!controller.signal.aborted) console.warn("[sbar.agent.status] event stream failed", error)
      }
    })()

    return () => {
      controller.abort()
      clearTimeout(reset)
      running.clear()
      pending.clear()
      last = "idle"
      publish()
    }
  },
})
