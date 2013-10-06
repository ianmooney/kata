module Extendible
  
  class Word

    include WordExt

    class << self

      def concatenated_words(options = {})
        if handle_options(options)
          super()
        end
      end
      
      def max_length
        @max_length || super
      end
      
      def print_words(options = {})
        if handle_options(options)
          super()
        end
      end
      
      def reload
        @all = nil
        @concatenated_words = nil
        @long_words = nil
        @sub_words = nil
        @grouped_by_length = nil
      end
      
      private
      def file_name
        @file_name || super
      end
      
      def set_file_name(path)
        return true if path.nil?
        if !path.match(/\.txt$/) || !File.exists?(path)
          message = File.exists?(path) ? 'Must be a text file' : 'File does not exist'
          raise Extendible::InvalidOptionsError, message
        else
          @file_name = path
        end        
      end
      
      def set_length(length)
        return true if length.nil?
        if length.to_i <= 1
          raise Extendible::InvalidOptionsError, 'Length must be greater than 1'
        else
          @max_length = length.to_i
        end
      end
      
      def handle_options(options)
        begin
          set_file_name(options[:file_name])
          set_length(options[:length])
        rescue Extendible::InvalidOptionsError => e
          puts "Invalid options: #{e}"
          false
        else
          true
        end
      end
      
    end

  end

  class InvalidOptionsError < StandardError;  end

end