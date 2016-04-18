require "serverkit/resources/base"

module Serverkit
  module Resources
    class RbenvDependentPackages < Base
      PACKAGE_NAMES_FOR_APT = %w[
        autoconf
        bison
        build-essential
        git
        libffi-dev
        libgdbm-dev
        libgdbm3
        libncurses5-dev
        libreadline6-dev
        libssl-dev
        libyaml-dev
        zlib1g-dev
      ]

      PACKAGE_NAMES_FOR_PACMAN = %w[
        base-devel
        git
        libffi
        libyaml
        openssl
        zlib
      ]

      PACKAGE_NAMES_FOR_YUM = %w[
        gcc
        gdbm-devel
        git
        libffi-devel
        libyaml-devel
        ncurses-devel
        openssl-devel
        readline-devel
        zlib-devel
      ]

      PACKAGE_NAMES_FOR_ZYPPER = %w[
        automake
        gcc
        gdbm-devel
        libffi-devel
        libyaml-devel
        ncurses-devel
        openssl-devel
        readline-devel
        zlib-devel
      ]

      # @note Override
      def apply
        packages.each(&:run_apply)
      end

      # @note Override
      def check
        packages.all?(&:check)
      end

      private

      # @return [Array<Serverkit::Resources::Package>]
      def packages
        package_names.map do |package_name|
          Serverkit::Resources::Package.new(@recipe, "name" => package_name).tap do |package|
            package.backend = backend
          end
        end
      end

      # @todo
      # @return [Array<String>]
      # @example ["gcc", "git", "gdbm-devel", ...]
      def package_names
        @package_names ||= begin
          case get_command_from_identifier(:install_package, "dummy")
          when /\bapt-get\b/
            PACKAGE_NAMES_FOR_APT
          when /\bpacman\b/
            PACKAGE_NAMES_FOR_PACMAN
          when /\byum\b/
            PACKAGE_NAMES_FOR_YUM
          when /\bzypper\b/
            PACKAGE_NAMES_FOR_ZYPPER
          else
            []
          end
        end
      end
    end
  end
end
