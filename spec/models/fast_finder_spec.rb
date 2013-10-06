require 'spec_helper'

describe FastFinder do

  before do
    FastFinder.stub(:file_name).and_return File.expand_path('../WordList-test.txt', File.dirname(__FILE__))
    FastFinder.suppress_output = true
  end

  describe '::concatenated_words' do

    it 'is only words with sub words' do
      words = FastFinder.concatenated_words
      all_names_match_sub_word = words.all? {|w, w1, w2| w == w1 + w2}
      expect(all_names_match_sub_word).to be_true
    end

    it 'is all words with sub words' do
      expect(FastFinder.concatenated_words.count).to eq(8)
    end

  end

end
