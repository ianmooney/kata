require 'spec_helper'

describe Word do

  before do
    Word.stub(:file_name).and_return File.expand_path('../WordList-test.txt', File.dirname(__FILE__))
  end

  subject(:word) { Word.new }

  describe '#concatenated_word?' do

    context 'made up of sub words' do
      it 'is true' do
        word.name = 'albums'
        expect(word.concatenated_word?).to be_true
      end
    end

    context 'contains only one sub word' do
      it 'is false' do
        word.name = 'albert'
        expect(word.concatenated_word?).to be_false
      end
    end

    context 'contains no sub words' do
      it 'is false' do
        word.name = 'letter'
        expect(word.concatenated_word?).to be_false
      end
    end

  end
  
  describe '#sub_words' do

    context 'contains no sub words' do
      it 'is empty' do
        word.name = 'letter'
        expect(word.sub_words).to eq([])
      end
    end

    context 'contains sub words' do
      it 'is array of sub words' do
        word.name = 'albums'
        expect(word.sub_words.collect(&:name)).to match_array(['al', 'bums'])
      end
    end

  end

  describe '::long_words' do
  
    it 'is only long words' do
      word_lengths = Word.long_words.collect(&:length)
      expect(word_lengths.uniq).to eq([Word::MAX_LETTERS])
    end
    
    it 'is all long words' do
      expect(Word.long_words.count).to eq(10)
    end

  end
  
  describe '::sub_words' do
  
    it 'is only short words' do
      word_lengths = Word.sub_words.collect(&:length)
      expect(word_lengths.uniq - [1,2,3,4,5]).to eq([])
    end
    
    it 'is all sub words' do
      expect(Word.sub_words.count).to eq(16)
    end

  end

  describe '::concatenated_words' do

    it 'is only words with sub words' do
      all_names_match_sub_words = Word.concatenated_words.all? {|w| w.name == w.sub_words.join}
      expect(all_names_match_sub_words).to be_true
    end

    it 'is all words with sub words' do
      expect(Word.concatenated_words.count).to eq(8)
    end

  end

end
