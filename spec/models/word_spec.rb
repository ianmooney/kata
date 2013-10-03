require 'spec_helper'

describe Word do

  before do
    Word.stub(:words_file_name).and_return File.expand_path('../WordList-test.txt', File.dirname(__FILE__))
  end
  
  subject(:word) { Word.new }
  
  describe '#made_of_sub_words?' do
    
    context 'made up of sub words' do
      it 'is true' do
        word.name = 'albums'        
        expect(word.made_of_sub_words?).to be_true
      end
    end
    
    context 'contains only one sub word' do
      it 'is false' do
        word.name = 'albert'
        expect(word.made_of_sub_words?).to be_false
      end
    end
    
    context 'contains no sub words' do
      it 'is false' do
        word.name = 'letter'
        expect(word.made_of_sub_words?).to be_false      
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
  
    it 'returns only long words' do
      letter_counts = Word.long_words.collect(&:letter_count)
      expect(letter_counts.uniq).to eq([Word::MAX_LETTERS])
    end
    
  end
  
  describe '::short_words' do
  
    it 'returns only short words' do
      letter_counts = Word.short_words.collect(&:letter_count)
      expect(letter_counts.uniq - [1,2,3,4,5]).to eq([])
    end
    
  end

end