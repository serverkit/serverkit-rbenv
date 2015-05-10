require "serverkit/resources/base"

module Serverkit
  module Resources
    class RbenvRuby < Base
      DEFAULT_GLOBAL = false
      DEFAULT_RBENV_EXECUTABLE_PATH = "rbenv"

      attribute :dependencies, type: [TrueClass, FalseClass]
      attribute :global, default: DEFAULT_GLOBAL, type: [FalseClass, TrueClass]
      attribute :profile_path, type: String
      attribute :rbenv_executable_path, default: DEFAULT_RBENV_EXECUTABLE_PATH, type: String
      attribute :version, required: true, type: String

      # Install the specified version of Ruby with rbenv if rbenv is executable
      # @note Override
      def apply
        if dependencies
          install_dependencies
        end
        if has_rbenv?
          install_specified_ruby_version unless has_specified_ruby_version?
          set_specified_global_version if has_invalid_global_version?
        end
      end

      # Check if rbenv is executable and the specified version of Ruby is installed
      # @note Override
      # @return [true, false] True if the specified version of Ruby is installed
      def check
        has_correct_dependencies? && has_rbenv? && has_specified_ruby_version? && !has_invalid_global_version?
      end

      private

      # @return [Array<Serverkit::Resources::Base>]
      def build_dependent_resources
        [
          Serverkit::Resources::RbenvDependentPackages.new(@recipe, {}),
          Serverkit::Resources::RbenvRbenv.new(@recipe, "user" => user),
          Serverkit::Resources::RbenvRubyBuild.new(@recipe, "user" => user),
          Serverkit::Resources::RbenvProfile.new(@recipe, "user" => user, "profile_path" => profile_path),
        ].map do |resource|
          resource.backend = backend
          resource
        end
      end

      # @note Override
      def default_id
        version
      end

      def global_version
        run_command("#{rbenv_executable_path} global").stdout.rstrip
      end

      def has_correct_dependencies?
        !dependencies || build_dependent_resources.all?(&:check)
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

      def install_dependencies
        build_dependent_resources.each(&:run_apply)
      end

      def install_specified_ruby_version
        run_command("#{rbenv_executable_path} install #{version}")
      end

      def set_specified_global_version
        run_command("#{rbenv_executable_path} global #{version}")
      end
    end
  end
end
