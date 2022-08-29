module BeltsBGFX
  class WindowSystem < BeltsEngine::System
    def start
      SDL.Init(SDL::INIT_EVERYTHING)
      @window = SDL.CreateWindow("bgfx", 0, 0, 640, 480, 0)

      init_bgfx
    end

    def update
      SDL.GL_SwapWindow(@window)
    end

    private

    def get_platform_data_wl
      wmi = SDL::SysWMinfo_wl.new
      SDL::GetVersion(wmi[:version])
      SDL.GetWindowWMInfo(@window, wmi)

      platform_data = BGFX::PlatformData.new
      platform_data[:ndt] = wmi[:info][:wl][:display]
      platform_data[:nwh] = wmi[:info][:wl][:surface]

      platform_data
    end

    def get_platform_data_x11
      wmi = SDL::SysWMinfo_x11.new
      SDL::GetVersion(wmi[:version])
      SDL.GetWindowWMInfo(@window, wmi)

      platform_data = BGFX::PlatformData.new
      platform_data[:ndt] = wmi[:info][:x11][:display]
      platform_data[:nwh] = wmi[:info][:x11][:window]

      platform_data
    end

    def init_bgfx
      BGFX.render_frame(0)

      resolution = BGFX::Resolution.new(width: 640, height: 480, reset: BGFX::RESET_VSYNC)
      init_data = BGFX::Init.new(resolution:)
      init_data[:type] = BGFX::RendererType[:Vulkan]
      # TODO: choose platform
      init_data[:platformData] = get_platform_data_x11

      BGFX.init(init_data)
    end
  end
end
