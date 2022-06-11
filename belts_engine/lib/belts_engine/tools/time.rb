module BeltsEngine
  module Tools
    class Time
      attr_reader :delta_time, :uptime

      def initialize
        @start_time = system_time
        @last_time = @start_time
        @uptime = 0
        @delta_time = 0
      end

      def update
        @delta_time = system_time - @last_time
        @last_time = system_time
        @uptime += @delta_time
      end

      private

      def system_time
        Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end
    end
  end
end
