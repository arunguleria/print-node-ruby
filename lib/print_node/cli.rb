require 'thor'

module PrintNode
  class CLI < Thor
    desc 'version', 'print version'
    def version
      puts "Version: #{PrintNode::VERSION}"
    end
  end
end