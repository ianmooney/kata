class FastWordFinder

  class << self

    def concatenated_words
      words = []
      Word.long_words.each do |word|
        Word.sub_words.each do |sub_word|
          if word.starts_with?(sub_word)
            suffix = word.name[sub_word.length..word.length-1]
            if with_length(suffix.length).include?(suffix)
              word.sub_words = [sub_word, Word.new(:name => suffix)]
              words << word
            end
          end
        end
      end
      words
    end

    def with_length(length)
      @grouped_by_length ||= Word.all.group_by(&:length)
      @grouped_by_length[length] || []
    end

  end

end