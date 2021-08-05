# frozen_string_literal: true

require "fileutils"

require "jekyll-glossary_tooltip/tag"
require "jekyll-glossary_tooltip/errors"

E = Jekyll::GlossaryTooltip::Errors  # Make namespace referencing easier here.

RSpec.describe Jekyll::GlossaryTooltip::Tag do
  after(:context) { remove_dest_dir }

  context "when a site is correctly configured" do
    before(:context) do
      site = make_site({ "source" => source_dir("normal") })
      site.process
    end

    let(:page1) { File.read(dest_dir("page1.html")) }
    let(:page2) { File.read(dest_dir("page2.html")) }
    let(:page3) { File.read(dest_dir("page3.html")) }
    let(:page4) { File.read(dest_dir("page4.html")) }
    let(:page5) { File.read(dest_dir("page5.html")) }

    it "renders a glossary tag with a URL" do
      expect_tag_match(page1, "term_with_url")
    end

    it "renders a glossary tag without a URL" do
      expect_tag_match(page2, "term_without_url", url: false)
    end

    it "renders a glossary tag from case insensitive lookup" do
      expect_tag_match(page3, "TERM_CASE_INSENSITIVE", term_display: "TerM_Case_Insensitive")
    end

    it "renders a glossary tag having spaces" do
      expect_tag_match(page4, "term with spaces", url: false)
    end

    it "renders a glossary tag with alternative display name" do
      expect_tag_match(page5, "term_with_url", term_display: "term alt display name")
    end
  end

  context "when a site is incorrectly configured (missing term definition)" do
    let(:site) { make_site({ "source" => source_dir("missing_definition") }) }

    it "building the site will raise an error" do
      expect { site.process }.to raise_error(E::MissingTermDefinition)
    end
  end

  context "when a site is incorrectly configured (empty term definition)" do
    let(:site) { make_site({ "source" => source_dir("empty_definition") }) }

    it "building the site will raise an error" do
      expect { site.process }.to raise_error(E::MissingTermDefinition)
    end
  end

  context "when a site is incorrectly configured (missing glossary file)" do
    let(:site) { make_site({ "source" => source_dir("missing_glossary") }) }

    it "building the site will raise an error" do
      expect { site.process }.to raise_error(E::NoGlossaryFile)
    end
  end

  context "when a site is incorrectly configured (missing term in glossary)" do
    let(:site) { make_site({ "source" => source_dir("missing_term") }) }

    it "building the site will raise an error" do
      expect { site.process }.to raise_error(E::MissingTermEntry)
    end
  end

  context "when a site is incorrectly configured (duplicate term in glossary)" do
    let(:site) { make_site({ "source" => source_dir("duplicate_term") }) }

    it "building the site will raise an error" do
      expect { site.process }.to raise_error(E::MultipleTermEntries)
    end
  end

  context "when a site is incorrectly configured (missing term arg in the tag)" do
    let(:site) { make_site({ "source" => source_dir("missing_tag_arg") }) }

    it "building the site will raise an error" do
      expect { site.process }.to raise_error(E::OptionsNoTermNameInTag)
    end
  end
end
