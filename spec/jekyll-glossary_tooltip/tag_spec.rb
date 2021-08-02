# frozen_string_literal: true

require "fileutils"

require "jekyll-glossary_tooltip/tag"
require "jekyll-glossary_tooltip/errors/configuration"

RSpec.describe Jekyll::GlossaryTooltip::Tag do
  after(:context) { remove_dest_dir }

  context "when a site is correctly configured" do
    before(:context) {
  	  site = make_site({ "source" => source_dir("normal") })
  	  site.process
  	}

    let(:page1) { File.read(dest_dir("page1.html")) }
	let(:page2) { File.read(dest_dir("page2.html")) }
	let(:page3) { File.read(dest_dir("page3.html")) }

    it "renders a glossary tag with a URL" do
      expect_tag_match(page1, "term_with_url", url=true)
    end

	it "renders a glossary tag without a URL" do
      expect_tag_match(page2, "term_without_url", url=true)
	end

    it "renders a glossary tag from case insensitive lookup" do
      expect_tag_match(page3, "TERM_CASE_INSENSITIVE", url=true)
    end
  end

  context "when a site is incorrectly configured (missing term definition)" do
    let(:site) { make_site({ "source" => source_dir("missing_definition") }) }

    it "building the site will raise an error" do
	  expect { site.process }.to raise_error(ArgumentError)
    end
  end

  context "when a site is incorrectly configured (missing glossary file)" do
    let(:site) { make_site({ "source" => source_dir("missing_glossary") }) }

    it "building the site will raise an error" do
	  expect { site.process }.to raise_error(Jekyll::GlossaryTooltip::Errors::NoGlossaryFile)
    end
  end

  context "when a site is incorrectly configured (missing term in glossary)" do
    let(:site) { make_site({ "source" => source_dir("missing_term") }) }

    it "building the site will raise an error" do
	  expect { site.process }.to raise_error(ArgumentError)
    end
  end

  context "when a site is incorrectly configured (duplicate term in glossary)" do
    let(:site) { make_site({ "source" => source_dir("duplicate_term") }) }

    it "building the site will raise an error" do
	  expect { site.process }.to raise_error(ArgumentError)
    end
  end
end
