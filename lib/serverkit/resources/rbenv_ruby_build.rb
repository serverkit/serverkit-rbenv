require "serverkit/resources/base"

module Serverkit
  module Resources
    class RbenvRubyBuild < Base
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
          "path" => "/home/#{user}/.rbenv/plugins/ruby-build",
          "repository" => "https://github.com/sstephenson/ruby-build.git",
          "user" => user,
        )
        resource.backend = backend
        resource
      end
    end
  end
end
