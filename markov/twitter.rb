require "twitter"
require "yaml"

require_relative "markov"


def load_settings
  twitter_credentials = YAML.load(File.open("settings.yml", "r"))
end

def get_text
  filenames = Dir["texts/*.txt"]
  raise "No files found" if filenames.nil? || filenames.empty?

  filename = filenames[rand(filenames.length)]

  text = ""
  File.open(filename) do |file| 
    text = file.read
  end

  # gutenberg puts in <CR> tags
  text.gsub(/<.+>/, "")
end

def get_markov(n_length=2)
  filenames = Dir["texts/*.txt"]
  raise "No files found" if filenames.nil? || filenames.empty?

  filename = filenames[rand(filenames.length)]
  
  m = filename.match(/(\w+).txt/)
  text_name = m[1]
  
  begin
    file = File.open("objects/#{text_name}--#{n_length.to_i}.yml", "r")
    markov = YAML.load(file)
    file.close
    
    return markov
  rescue
    # no buffer
    text = ""
    File.open(filename) do |file| 
      text = file.read
    end

    # gutenberg puts in <CR> tags
    text.gsub(/<.+>/, "")
    markov = Practice::MarkovChain.new(text, n_length)
    
    # save the buffer
    File.open("objects/#{text_name}--#{n_length.to_i}.yml", "w") do |f|  
      # use "\n" for two lines of text  
      f << markov.to_yaml
    end  
  end
end


twitter_credentials = load_settings
Twitter.configure do |config|
  config.consumer_key       = twitter_credentials[:consumer_key]
  config.consumer_secret    = twitter_credentials[:consumer_secret]
  config.oauth_token        = twitter_credentials[:oauth_token]
  config.oauth_token_secret = twitter_credentials[:oauth_token_secret]
end


m = get_markov(2)
#m = Practice::MarkovChain.new(get_text, 2)
p m
#Twitter.update(m.text)

