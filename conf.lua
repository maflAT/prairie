-- required for debugging with VSCodes 'Local Lua Debugger' extension
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- define global constants here to keep 'main.lua' cleaner
GAME_WIDTH = 384
GAME_HEIGHT = 240
WINDOW_WIDTH = 1152
WINDOW_HEIGHT = 720

function love.conf(t)
    -- disable unused modules
    t.modules.joystick = false
    t.modules.physics = false
    t.modules.thread = false
    t.modules.touch = false
    t.modules.video = false

    -- initial window setup
    t.window.display = 2
    t.window.fullscreen = false
    t.window.fullscreentype = 'desktop'
    t.window.borderless = false
    t.window.resizable = true
    t.window.vsync = -1
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT
    t.window.minwidth = GAME_WIDTH
    t.window.minheight = GAME_HEIGHT
    t.window.title = "Revenge of the Prairy King"
end