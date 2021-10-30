require 'jekyll'

# == Tasks ==

task default: %w[build]

desc "Build website"
task :build do
  puts "Building site...".bold
  Jekyll::Commands::Build.process(verbose: true)
  #jekyll("build")
end


desc "Clean up generated files"
task :clean do
  puts "Cleaning up generated files".bold
  Jekyll::Commands::Clean.process({})
end


desc "Build and serve website and watch for changes on filesystem."
task :serve do
  puts "Will serve website live from source...".bold
  Jekyll::Commands::Serve.process(watch: true, livereload: true, open_url: true, show_drafts: true)
  #jekyll('serve --watch --livereload --open-url --drafts')
end
task :preview => :serve

# == Helper functions ==

def jekyll(cmds)
  sh 'jekyll ' + cmds
end
