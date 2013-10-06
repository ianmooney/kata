require 'spec_helper'

describe FastWordFinder do

  before do
    Word.stub(:file_name).and_return File.expand_path('../WordList-test.txt', File.dirname(__FILE__))
  end

  describe '::concatenated_words' do

    it 'is only words with sub words' do
      all_names_match_sub_word = FastWordFinder.concatenated_words.all? {|w| w.name == w.sub_words.join}
      expect(all_names_match_sub_word).to be_true
    end

    it 'is all words with sub words' do
      expect(FastWordFinder.concatenated_words.count).to eq(8)
    end

  end

end
