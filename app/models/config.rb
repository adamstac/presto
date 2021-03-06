module Nesta
  class Config
    @yaml = nil
    
    class << self
      attr_accessor :yaml
    end

    def self.cache
      if Sinatra::Application.environment == :test
        false
      else
        get(environment)["cache"] || false
      end
    end

    def self.title
      configuration["title"]
    end
    
    def self.subtitle
      configuration["subtitle"]
    end
    
    def self.description
      configuration["description"]
    end
    
    def self.keywords
      configuration["keywords"]
    end
    
    def self.author
      configuration["author"]
    end
    
    def self.theme
      configuration["theme"] || "default"
    end
    
    def self.google_analytics_code
      get(environment)["google_analytics_code"]
    end
    
    def self.disqus_short_name
      configuration["disqus_short_name"]
    end
    
    def self.content_path(basename = nil)
      get_path(get(environment)["content"], basename)
    end
    
    def self.page_path(basename = nil)
      get_path(File.join(content_path, "pages"), basename)
    end
    
    def self.attachment_path(basename = nil)
      get_path(File.join(content_path, "attachments"), basename)
    end
    
    private
      def self.environment
        Presto.environment.to_s
      end
    
      def self.configuration
        file = File.join(File.dirname(__FILE__), *%w[.. .. config config.yml])
        self.yaml ||= YAML::load(IO.read(file))
      end
      
      def self.get(key, default = {})
        configuration[key].nil? ? default : configuration[key]
      end
      
      def self.get_path(dirname, basename)
        basename.nil? ? dirname : File.join(dirname, basename)
      end
  end
end
