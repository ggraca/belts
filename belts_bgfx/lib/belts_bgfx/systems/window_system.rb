module BeltsBGFX
  class WindowSystem < BeltsEngine::System
    def start
      SDL.Init(SDL::INIT_EVERYTHING)
      @sdl_window = SDL.CreateWindow("bgfx", 0, 0, @window.width, @window.height, SDL::WINDOW_RESIZABLE)

      init_bgfx
      @input_manager = BeltsBGFX::InputManager.new(@game, @sdl_window)
    end

    def update
      @input_manager.update
      BGFX.set_view_rect(0, 0, 0, @window.width, @window.height)
      BGFX.reset(@window.width, @window.height, BGFX::RESET_VSYNC, BGFX::TextureFormat[:Unknown])
      SDL.GL_SwapWindow(@sdl_window)
    end

    private

    def get_platform_data_wl
      wmi = SDL::SysWMinfo_wl.new
      SDL::GetVersion(wmi[:version])
      SDL.GetWindowWMInfo(@sdl_window, wmi)

      platform_data = BGFX::PlatformData.new
      platform_data[:ndt] = wmi[:info][:wl][:display]
      platform_data[:nwh] = wmi[:info][:wl][:surface]

      platform_data
    end

    def get_platform_data_x11
      wmi = SDL::SysWMinfo_x11.new
      SDL::GetVersion(wmi[:version])
      SDL.GetWindowWMInfo(@sdl_window, wmi)

      platform_data = BGFX::PlatformData.new
      platform_data[:ndt] = wmi[:info][:x11][:display]
      platform_data[:nwh] = wmi[:info][:x11][:window]

      platform_data
    end

    def init_bgfx
      BGFX.render_frame(0)

      resolution = BGFX::Resolution.new(width: @window.width, height: @window.height, reset: BGFX::RESET_VSYNC)
      init_data = BGFX::Init.new(resolution:)
      init_data[:type] = BGFX::RendererType[:Vulkan]
      # TODO: choose platform
      init_data[:platformData] = get_platform_data_x11

      BGFX.init(init_data)
    end
  end
end
