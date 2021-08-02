# frozen_string_literal: true

require "fileutils"

require "jekyll-glossary_tooltip/tag"

RSpec.describe Jekyll::GlossaryTooltip::Tag do
  context "when a site is correctly configured" do
    let(:site) { make_site({ "source" => source_dir("normal") }) }
    before(:each) { site.process }
    after(:each) { remove_dest_dir }

    let(:r1) { %r{<span class="jekyll-glossary">\s*} }
    let(:r2) { %r{\s*<span class="jekyll-glossary-tooltip">\s*} }
  	let(:r3) { %r{\s*<br(\s/)?><a class="jekyll-glossary-source-link" href="} }
  	let(:r4) { %r{"></a>\s*} }
	let(:r5) { %r{</span>\s*</span>} }

    let(:page1) { File.read(dest_dir("page1.html")) }
    it "renders a glossary tag with a URL" do
	  # TODO extract this to helper assert function?
      expect(page1).to match(%r/#{r1}term_with_url#{r2}term_with_url definition#{r3}term_with_url url#{r4}#{r5}/)
    end

	let(:page2) { File.read(dest_dir("page2.html")) }
	it "renders a glossary tag without a URL" do
	  expect(page2).to match(%r/#{r1}term_without_url#{r2}term_without_url definition#{r5}/)
	end

	let(:page3) { File.read(dest_dir("page3.html")) }
    it "renders a glossary tag from case insensitive lookup" do
      expect(page3).to match(%r/#{r1}TERM_CASE_INSENSITIVE#{r2}term_case_insensitive definition#{r3}term_case_insensitive url#{r4}#{r5}/)
    end

    #let(:code) { site.config["google_search_console"]["verification_file_code"] }
    #let(:ver_file_path) { dest_dir("google#{code}.html") }

    #it "generated a verification file in the destination root directory" do
      #expect(File.exist?(ver_file_path)).to be true
    #end

    #it "generated a verification file with the correct content" do
      #content = File.read(ver_file_path).chomp
      #expect(content).to eq("google-site-verification: google#{code}.html")
    #end
  end

  #context "when a site is incorrectly configured (missing site.google_search_console)" do
    #after(:all) { remove_dest_dir }

    #it "generating the site will raise an error" do
      #site = make_site({ "source" => source_dir("normal") })
      #expect { site.process }.to raise_error(ArgumentError)
    #end

    #it "does not generate a site" do
      #expect(File.exist?(dest_dir)).to be false
    #end
  #end

  #context "when a site is incorrectly configured (missing site.google_search_console.verification_file_code)" do
    #after(:all) { remove_dest_dir }

    #let(:site) { make_site({ "source" => source_dir("normal"), "google_search_console" => {} }) }

    #it "generating the site will raise an error" do
      #expect { site.process }.to raise_error(ArgumentError)
    #end

    #it "does not generate a site" do
      #expect(File.exist?(dest_dir)).to be false
    #end
  #end

  #context "when there already is a verification file in the root of the source tree" do
    #after(:all) { remove_dest_dir }

    #let(:site) do
      #site = make_site({ "source" => source_dir("override"),
                         #"google_search_console" => { "verification_file_code" => "1234567890" } })
      #site.process
      #site
    #end
    #let(:code) { site.config["google_search_console"]["verification_file_code"] }
    #let(:ver_file_gen) { dest_dir("google#{code}.html") }
    #let(:ver_file_from_src) { dest_dir("google999f1xtur3.html") }  # In the spec/fixtures/override/

    #it "don't generate a new verification file" do
      #expect(File.exist?(ver_file_gen)).to be false
    #end

    #it "preserves the verification file from the source directory" do
      #expect(File.exist?(ver_file_from_src)).to be true
    #end
  #end
end
