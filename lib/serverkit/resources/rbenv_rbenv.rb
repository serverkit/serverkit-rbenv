require "serverkit/resources/base"

module Serverkit
  module Resources
    class RbenvRbenv < Base
      attribute :user, required: true, type: String

      # @note Override
      def apply
        build_resource.run_apply
      end

      # @note Override
      def check
        build_resource.check
      end

      private

      def build_resource
        resource = Serverkit::Resources::Git.new(
          @recipe,
          "path" => "/home/#{user}/.rbenv",
          "repository" => "https://github.com/sstephenson/rbenv.git",
          "user" => user,
        )
        resource.backend = backend
        resource
      end
    end
  end
end
