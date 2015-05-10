require "serverkit/resources/base"

module Serverkit
  module Resources
    class RbenvProfile < Base
      attribute :profile_path, required: true, type: String

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
            "path" => profile_path,
          )
          resource.backend = backend
          resource
        end
      end

      # @return [Array<String>]
      def lines
        [
          %<export PATH="$HOME/.rbenv/bin:$PATH">,
          %<eval "$(rbenv init -)">,
        ]
      end
    end
  end
end
