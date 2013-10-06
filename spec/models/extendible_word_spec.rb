require 'spec_helper'

describe Extendible::Word do

  before do
    Extendible::Word.stub(:file_name).and_return File.expand_path('../WordList-test.txt', File.dirname(__FILE__))
    Extendible::Word.reload
  end
  
  context 'no options' do
  
    describe '::concatenated_words' do

      it 'is only words with sub words' do
        all_names_match_sub_words = Extendible::Word.concatenated_words.all? {|w| w.name == w.sub_words.join}
        expect(all_names_match_sub_words).to be_true
      end

      it 'is all words with sub words' do
        expect(Extendible::Word.concatenated_words.count).to eq(8)
      end

    end
    
  end
  
  context 'length option is 8' do
    
    describe '::concatenated_words' do

      it 'is correct words' do
        words = Extendible::Word.concatenated_words(:length => 8)
        expect(words.collect(&:name)).to eq(['convexed'])
        expect(words.first.sub_words.collect(&:name)).to eq(['con', 'vexed'])
      end

    end 
    
  end
  
end