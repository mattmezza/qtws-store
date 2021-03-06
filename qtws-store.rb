#!/usr/local/bin/ruby -w
require 'json'

def update()
  puts "Updating store..."
  system("git fetch")
  puts "Done updating pls run upgrade"
end

def upgrade()
  puts "Upgrading store..."
  system("git pull")
  system("git --no-pager log -1 --oneline")
end

def launch(app)
  puts "Launching " + app
  appManifest = "apps/" + app + "/app.json"
  system("qtws " + appManifest)
end

def search(q)
  puts "searching for " + q + "...\n"
  apps = JSON.parse(File.read('apps.json'))
  filtered = apps.select{ |app| app["dir"].downcase().include? q.downcase }
  filtered.map{ |app|
    puts app["dir"] + ": by " + app["author"]["name"] + " <" + app["author"]["email"] + "> "
  }
  puts "\nUse `qtws-store launch name` to launch the app"
end

def version()
  version = "0.0.1"
  puts "Version " + version
end

def help(command)
  puts "qtws-store [update|upgrade|search|launch|version]"
end

command = ARGV[0] || ""

case command
when "update"
  update()
when "search"
  search(ARGV[1])
when "upgrade"
  upgrade()
when "launch"
  launch(ARGV[1])
when "version"
  version()
else
  help(command)
end

