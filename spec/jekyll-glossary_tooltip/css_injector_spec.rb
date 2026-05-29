# frozen_string_literal: true

require "jekyll-glossary_tooltip/tag"
require "jekyll-glossary_tooltip/css_injector"

I = Jekyll::GlossaryTooltip::CssInjector # Make namespace referencing easier here.
CSS_FIRST_LINE = I::CSS_CONTENT.lines.first.strip

# Minimal doubles for direct inject_style unit tests.
MockSite = Struct.new(:config)
MockDoc  = Struct.new(:site, :output)

RSpec.describe Jekyll::GlossaryTooltip::CssInjector do
  context "when CSS injection is enabled (the default)" do
    before(:context) do
      site = make_site({ "source" => source_dir("css_injection") })
      site.process
    end

    after(:context) { remove_dest_dir }

    let(:page) { File.read(dest_dir("page1.html")) }

    it "injects a <style> block into the page <head>" do
      expect(page).to include(I::STYLE_ID)
    end

    it "injects the <style> block immediately after the opening <head> tag" do
      expect(page).to match(/<head[^>]*>\n<style id="#{I::STYLE_ID}">/)
    end

    it "includes the bundled CSS content in the injected block" do
      expect(page).to include(CSS_FIRST_LINE)
    end

    it "injects the style block exactly once (no duplicates)" do
      expect(page.scan(I::STYLE_ID).length).to eq(1)
    end
  end

  context "when CSS injection is disabled via glossary_tooltip.include_default_style: false" do
    before(:context) do
      site = make_site({ "source" => source_dir("css_injection_disabled") })
      site.process
    end

    after(:context) { remove_dest_dir }

    let(:page) { File.read(dest_dir("page1.html")) }

    it "does not inject any <style> block" do
      expect(page).not_to include(I::STYLE_ID)
    end
  end

  context "when inject_style is called directly" do
    let(:enabled_site) { MockSite.new({}) }

    it "does not inject into output with no <head>" do
      doc = MockDoc.new(enabled_site, "<body>no head here</body>")
      I.inject_style(doc)
      expect(doc.output).not_to include(I::STYLE_ID)
    end

    it "does not inject into output that only has <header> (not <head>)" do
      doc = MockDoc.new(enabled_site, "<html><header>nav</header><body>content</body></html>")
      I.inject_style(doc)
      expect(doc.output).not_to include(I::STYLE_ID)
    end

    it "injects after <head> with attributes" do
      doc = MockDoc.new(enabled_site, '<html><head lang="en"><title>Test</title></head></html>')
      I.inject_style(doc)
      expect(doc.output).to match(/<head lang="en">\n<style id="#{I::STYLE_ID}">/)
    end

    it "injects the style block exactly once even when called twice" do
      doc = MockDoc.new(enabled_site, "<html><head><title>Test</title></head></html>")
      2.times { I.inject_style(doc) }
      expect(doc.output.scan(I::STYLE_ID).length).to eq(1)
    end
  end
end
