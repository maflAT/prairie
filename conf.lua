-- required for debugging with VSCodes 'Local Lua Debugger' extension
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- define globals here to keep 'main.lua' cleaner
GAME_WIDTH = 320
GAME_HEIGHT = 240
WINDOW_WIDTH = 1280
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
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT
    t.window.minwidth = GAME_WIDTH
    t.window.minheight = GAME_HEIGHT
    t.window.title = "Revenge of the Prairy King"
    t.window.resizable = true
    t.window.vsync = -1
    t.window.borderless = false
end