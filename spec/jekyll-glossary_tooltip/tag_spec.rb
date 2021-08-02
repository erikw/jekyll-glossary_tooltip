# frozen_string_literal: true

require "fileutils"

require "jekyll-glossary_tooltip/tag"

RSpec.describe Jekyll::GlossaryTooltip::Tag do
  context "when a site is correctly configured" do
    let(:site) { make_site({ "source" => source_dir("normal") }) }
    before(:each) { site.process }
    after(:each) { remove_dest_dir }

    let(:page1) { File.read(dest_dir("page1.html")) }
    it "renders a glossary tag with a URL" do
      expect_tag_match(page1, "term_with_url", url=true)
    end

	let(:page2) { File.read(dest_dir("page2.html")) }
	it "renders a glossary tag without a URL" do
      expect_tag_match(page2, "term_without_url", url=true)
	end

	let(:page3) { File.read(dest_dir("page3.html")) }
    it "renders a glossary tag from case insensitive lookup" do
      expect_tag_match(page3, "TERM_CASE_INSENSITIVE", url=true)
    end
  end

  context "when a site is incorrectly configured (missing term definition)" do
    let(:site) { make_site({ "source" => source_dir("missing_definition") }) }
    after(:each) { remove_dest_dir }

    it "building the site will raise an error" do
	  expect { site.process }.to raise_error(ArgumentError)
    end
  end

  context "when a site is incorrectly configured (missing glossary file)" do
    let(:site) { make_site({ "source" => source_dir("missing_glossary") }) }
    after(:each) { remove_dest_dir }

    it "building the site will raise an error" do
	  expect { site.process }.to raise_error(ArgumentError)
    end
  end
end
