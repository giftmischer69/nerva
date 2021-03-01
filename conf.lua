function love.conf(t)
    t.identity = "strux"
    t.version = "0.9.1"
    t.console = false

    t.window.title = "SpacetruckS"
    t.window.icon = nil
    t.window.width = 320
    t.window.height = 240
    t.window.borderless = false
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.vsync = true

    t.modules.joystick = false
    t.modules.mouse = false
    t.modules.physics = false
end
