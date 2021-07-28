# frozen_string_literal: true

require "fileutils"

RSpec.describe Jekyll::GoogleSearchConsoleVerificationFile::Generator do
  context "when a site is correctly configured" do
    after(:all) { remove_dest_dir }

    let(:site) do
      site = make_site({ "source" => source_dir("normal"),
                         "google_search_console" => { "verification_file_code" => "1234567890" } })
      site.process
      site
    end
    let(:code) { site.config["google_search_console"]["verification_file_code"] }
    let(:ver_file_path) { dest_dir("google#{code}.html") }

    it "generated a verification file in the destination root directory" do
      expect(File.exist?(ver_file_path)).to be true
    end

    it "generated a verification file with the correct content" do
      content = File.read(ver_file_path).chomp
      expect(content).to eq("google-site-verification: google#{code}.html")
    end
  end

  context "when a site is incorrectly configured (missing site.google_search_console)" do
    after(:all) { remove_dest_dir }

    it "generating the site will raise an error" do
      site = make_site({ "source" => source_dir("normal") })
      expect { site.process }.to raise_error(ArgumentError)
    end

    it "does not generate a site" do
      expect(File.exist?(dest_dir)).to be false
    end
  end

  context "when a site is incorrectly configured (missing site.google_search_console.verification_file_code)" do
    after(:all) { remove_dest_dir }

    let(:site) { make_site({ "source" => source_dir("normal"), "google_search_console" => {} }) }

    it "generating the site will raise an error" do
      expect { site.process }.to raise_error(ArgumentError)
    end

    it "does not generate a site" do
      expect(File.exist?(dest_dir)).to be false
    end
  end

  context "when there already is a verification file in the root of the source tree" do
    after(:all) { remove_dest_dir }

    let(:site) do
      site = make_site({ "source" => source_dir("override"),
                         "google_search_console" => { "verification_file_code" => "1234567890" } })
      site.process
      site
    end
    let(:code) { site.config["google_search_console"]["verification_file_code"] }
    let(:ver_file_gen) { dest_dir("google#{code}.html") }
    let(:ver_file_from_src) { dest_dir("google999f1xtur3.html") }  # In the spec/fixtures/override/

    it "don't generate a new verification file" do
      expect(File.exist?(ver_file_gen)).to be false
    end

    it "preserves the verification file from the source directory" do
      expect(File.exist?(ver_file_from_src)).to be true
    end
  end
end
