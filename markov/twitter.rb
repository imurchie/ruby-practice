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


twitter_credentials = load_settings
Twitter.configure do |config|
  config.consumer_key       = twitter_credentials[:consumer_key]
  config.consumer_secret    = twitter_credentials[:consumer_secret]
  config.oauth_token        = twitter_credentials[:oauth_token]
  config.oauth_token_secret = twitter_credentials[:oauth_token_secret]
end



m = Practice::MarkovChain.new(get_text, 2)
Twitter.update(m.text)

