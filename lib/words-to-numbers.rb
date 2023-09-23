# frozen_string_literal: true

require_relative "words-to-numbers/version"
require 'yaml'

module WordsToNumbers
  key_value_hash = {}

  GEM_ROOT = File.expand_path("../..", __FILE__)
  Dir["#{GEM_ROOT}/lib/words-to-numbers/words/*.yml"].each do |file|
    data = YAML.load(File.read(file))
    key_value_hash.merge!(data)
  end

  ALL_WORDS = key_value_hash.dup.freeze
  BLACKLIST_SINGULAR_WORDS = ['a']

  def self.translate_words_to_numbers(text)
    pattern = /(?:\d+|\b(?:#{ALL_WORDS.keys.join('|')})\b|\p{N})/i
    numbers = []

    text.scan(pattern) do |match|
      match = match.to_s.downcase
      if ALL_WORDS.keys.include?(match.to_s)
        number = ALL_WORDS[match]
        numbers << number if number && !BLACKLIST_SINGULAR_WORDS.include?(match)
      else
        numeric_match = match.to_i
        numbers << match if numeric_match
      end
    end

    numbers.compact
  end
end
