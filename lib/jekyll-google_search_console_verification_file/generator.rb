# frozen_string_literal: true

require "jekyll"

module Jekyll
  module GoogleSearchConsoleVerificationFile
    # Generator for the verification file.
    class Generator < Jekyll::Generator
      safe true
      priority :lowest

      # Plugin entry point.
      def generate(site)
        @site = site
        @site.pages << verification_file unless a_verification_file_exist?
      end

      private

      # Configuration keys in _config.yml
      CONF_NS = "google_search_console"
      CONF_CODE = "verification_file_code"
      # The 'progname' argument to the logger class.
      LOG_TAG = "Google Search Console Verification File Generator:"

      # Get the verification code from _config.yml
      def verification_code
        err_msg = "#{LOG_TAG} #{CONF_NS}.#{CONF_CODE} must be set in _config.html"
        raise ArgumentError, err_msg unless @site.config[CONF_NS]&.[](CONF_CODE)

        @site.config[CONF_NS][CONF_CODE]
      end

      # Check if a GSC verification file already exist in the source that will be put in the root of the generated site.
      def a_verification_file_exist?
        file_pattern = %r{/google.+\.html?}
        exists = @site.static_files.any? { |p| p.url =~ file_pattern }
        warn_msg = "Found a verification file in source tree matching /#{file_pattern.source}/; not generating one..."
        Jekyll.logger.warn LOG_TAG, warn_msg if exists
        exists
      end

      # Get path of the template file.
      def source_path(file = "jekyll-google_search_console_verification_file/template.html")
        File.expand_path "../#{file}", __dir__
      end

      # Path of the output file.
      def destination_path
        "google#{verification_code}.html"
      end

      # Construct a file object from a template with content that can be added to generated pages
      def verification_file
        Jekyll.logger.info LOG_TAG, "Generating #{destination_path}"
        page = PageWithoutAFile.new(@site, __dir__, "", destination_path)
        page.content = File.read(source_path)
        page.data["layout"] = nil
        page
      end
    end
  end
end
