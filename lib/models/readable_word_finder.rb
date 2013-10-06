class ReadableWordFinder

  class << self

    def concatenated_words
      words = []
      Word.sub_words.each do |sub_word|
        words_that_start_with(sub_word).each do |word|
          suffix = word.name[sub_word.length..word.name.length-1]
          if Word.sub_words.include?(suffix)
            word.sub_words = [sub_word, Word.new(:name => suffix)]
            words << word
          end
        end
      end
      words
    end

    def words_that_start_with(sub_word)
      Word.long_words.select {|w| w.starts_with?(sub_word)}
    end

  end

end