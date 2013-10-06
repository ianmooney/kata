class FastFinder

  class << self

    attr_accessor :suppress_output

    def concatenated_words
      long_words, sub_words, grouped_by_length = read_words_from_file
      concatenated_words = []
      long_words.each do |word|
        sub_words.each do |sub_word|
          if word[0..sub_word.length-1] == sub_word
            suffix = word[sub_word.length..word.length-1]
            words_with_correct_length = grouped_by_length[suffix.length]
            if words_with_correct_length && words_with_correct_length.include?(suffix)
              concatenated_words << [word, sub_word, suffix]
              puts "#{word} (#{sub_word} + #{suffix})" unless suppress_output
              break
            end
          end
        end
      end
      concatenated_words
    end

    private
    def file_name
      File.expand_path('../WordList.txt', File.dirname(__FILE__))
    end
    
    def read_words_from_file
      long_words, sub_words, grouped_by_length = [[], [], {}]
      File.open(file_name, "r").each_line do |line|
        if line.strip! != '' && line.length <= FastFinder::MAX_LENGTH
          if line.length == FastFinder::MAX_LENGTH
            long_words << line
          else
            sub_words << line
            grouped_by_length[line.length] ||= []
            grouped_by_length[line.length] << line
          end
        end
      end
      [long_words, sub_words, grouped_by_length]      
    end

  end

end

FastFinder::MAX_LENGTH = 6