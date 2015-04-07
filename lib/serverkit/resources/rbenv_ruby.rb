module Serverkit
  module Resources
    class RbenvRuby < Base
      DEFAULT_GLOBAL = false
      DEFAULT_RBENV_EXECUTABLE_PATH = "rbenv"

      attribute :global, default: DEFAULT_GLOBAL, type: [FalseClass, TrueClass]
      attribute :rbenv_executable_path, default: DEFAULT_RBENV_EXECUTABLE_PATH, type: String
      attribute :version, required: true, type: String

      # Install the specified version of Ruby with rbenv if rbenv is executable
      # @note Override
      def apply
        if has_rbenv?
          unless has_specified_ruby_version?
            run_command("#{rbenv_executable_path} install #{version}")
          end
          if has_invalid_global_version?
            run_command("#{rbenv_executable_path} global #{version}")
          end
        end
      end

      # Check if rbenv is executable and the specified version of Ruby is installed
      # @note Override
      # @return [true, false] True if the specified version of Ruby is installed
      def check
        has_rbenv? && has_specified_ruby_version? && !has_invalid_global_version?
      end

      private

      def global_version
        run_command("#{rbenv_executable_path} global").stdout.rstrip
      end

      # @return [true, false] True if global attribute is specified and it differs from current global
      def has_invalid_global_version?
        !global.nil? && global_version != version
      end

      # @return [true, false] True if rbenv command is executable
      def has_rbenv?
        check_command("which #{rbenv_executable_path}")
      end

      # @return [true, false] True if the specified version of Ruby is installed
      def has_specified_ruby_version?
        check_command("#{rbenv_executable_path} prefix #{version}")
      end
    end
  end
end
