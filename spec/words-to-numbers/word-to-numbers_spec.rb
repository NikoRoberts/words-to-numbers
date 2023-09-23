# frozen_string_literal: true

RSpec.describe WordsToNumbers do
  it "has a version number" do
    expect(WordsToNumbers::VERSION).not_to be nil
  end

  describe "with unicode characters" do
    let(:input_text) { "Do me a favour and call me bro. O .four. 7️⃣ .𝟜. THREE boys FIVE men SIX dudes 745 needed" }

    it "expects to extract words and unicode characters" do
      expect(WordsToNumbers.translate_words_to_numbers(input_text).join("")).to eq "0474356745"
    end
  end

  describe "with a bunch of number words" do
    let(:input_text) { "O .four. One .four. THREE boys FIVE fella ONE girl. NINE dads FIVE men SEVEN dudes needed" }

    it "expects to extract words and unicode characters" do
      expect(WordsToNumbers.translate_words_to_numbers(input_text).join("")).to eq "0414351957"
    end
  end

  describe "with mainly numbers broken up by other chars" do
    let(:input_text) { "0445 and then 2.3.4 and then 4-3-2" }

    it "expects to extract words and unicode characters" do
      expect(WordsToNumbers.translate_words_to_numbers(input_text).join("")).to eq "0445234432"
    end
  end
end
