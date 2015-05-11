require "serverkit/resources/base"

module Serverkit
  module Resources
    class RbenvProfile < Base
      attribute :profile_path, type: String
      attribute :user, at_least_one_of: [:profile_path], type: String

      # @note Override
      def apply
        build_resources.each(&:run_apply)
      end

      # @note Override
      def check
        build_resources.all?(&:check)
      end

      private

      # @return [Array<Serverkit::Resources::Line>]
      def build_resources
        lines.map do |line|
          resource = Serverkit::Resources::Line.new(
            @recipe,
            "line" => line,
            "path" => proper_profile_path,
          )
          resource.backend = backend
          resource
        end
      end

      # @return [String]
      def get_user_home_directory
        run_command_from_identifier(:get_user_home_directory, user).stdout.rstrip
      end

      # @return [Array<String>]
      def lines
        [
          %<export PATH="$HOME/.rbenv/bin:$PATH">,
          %<eval "$(rbenv init -)">,
        ]
      end

      # @return [String]
      def proper_profile_path
        @proper_profile_path ||= profile_path || "#{get_user_home_directory}/.bash_profile"
      end
    end
  end
end
