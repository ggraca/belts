module BeltsBGFX
  class RenderSystem < BeltsEngine::System
    def start
      SDL.Init(SDL::INIT_EVERYTHING)
      @window = SDL.CreateWindow("bgfx", 0, 0, 640, 480, 0)

      BGFX.render_frame(0)
      init_bgfx
      BGFX::setViewClear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)
    end

    def update
      # SDL.GL_MakeCurrent(@window, @context)
      BGFX.setViewRect(0, 0, 0, 640, 480)
      BGFX.touch(0)

      BGFX.frame(false)
      SDL.GL_SwapWindow(@window)
    end

    private

    def get_platform_data
      wmi = SDL::SysWMinfo_cocoa.new
      pp "#{wmi[:version][:major]}.#{wmi[:version][:minor]}.#{wmi[:version][:patch]}"

      wmi = SDL::SysWMinfo_win.new
      pp "#{wmi[:version][:major]}.#{wmi[:version][:minor]}.#{wmi[:version][:patch]}"

      wmi = SDL::SysWMinfo_x11.new
      pp "#{wmi[:version][:major]}.#{wmi[:version][:minor]}.#{wmi[:version][:patch]}"

      SDL.GetWindowWMInfo(@window, wmi)
      pp wmi[:subsystem]
      pp SDL.GetError().read_string

      pp "#{wmi[:version][:major]}.#{wmi[:version][:minor]}.#{wmi[:version][:patch]}"


    end

    def get_platform_data_wl
      wmi = SDL::SysWMinfo_wl.new
      SDL::GetVersion(wmi[:version])
      SDL.GetWindowWMInfo(@window, wmi)
      pp SDL.GetError().read_string

      platform_data = BGFX::PlatformData.new
      platform_data[:ndt] = wmi[:info][:wl][:display]
      platform_data[:nwh] = wmi[:info][:wl][:surface]

      platform_data
    end

    def get_platform_data_x11
      wmi = SDL::SysWMinfo_x11.new
      SDL::GetVersion(wmi[:version])
      SDL.GetWindowWMInfo(@window, wmi)
      pp SDL.GetError().read_string

      platform_data = BGFX::PlatformData.new
      platform_data[:ndt] = wmi[:info][:x11][:display]
      platform_data[:nwh] = wmi[:info][:x11][:window]

      platform_data
    end

    def init_bgfx
      resolution = BGFX::Resolution.new(width: 640, height: 480, reset: BGFX::RESET_VSYNC)
      init_data = BGFX::Init.new(resolution:)
      init_data[:type] = BGFX::RendererType[:Vulkan]
      init_data[:platformData] = get_platform_data_x11

      BGFX.init(init_data)
    end
  end
end
