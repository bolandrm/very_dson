module VeryDSON
  class DSON
    ARRAY_DELIMITERS = ["and", "also"]
    OBJECT_PAIR_DELIMITERS = [",", ".", "!", "?"]

    class << self
      def stringify(value)
        _stringify(simplify(value))
      end

      private

      def _stringify(value)
        case value
        when EscapedString
          "\"#{value.to_dson}\""
        when Numeric
          value.to_s(8)
        when NilClass
          "empty"
        when TrueClass
          "yes"
        when FalseClass
          "no"
        when Hash
          delimiter = OBJECT_PAIR_DELIMITERS.sample
          delimiter = "#{delimiter} "

          value = value.map do |k, v|
            "#{_stringify(k)} is #{_stringify(v)}"
          end

          "such #{value.join(delimiter)} wow"
        when Array
          delimited_array(value)
        else
          raise "such fail #{value}"
        end
      end

      def simplify(value)
        case value
        when Symbol
          EscapedString.new(value.to_s)
        when String
          EscapedString.new(value)
        when Numeric, NilClass, TrueClass, FalseClass
          value
        when Hash
          Hash[value.map { |k, v| [simplify(k), simplify(v)] }]
        when Array
          value.map { |v| simplify(v) }
        else
          object_to_key_value(value)
        end
      end

      def delimited_array(value)
        string = ""

        value.map { |v| _stringify(v) }.each_with_index do |v, i|
          if i == 0
            string = v
          else
            delimiter = " #{ARRAY_DELIMITERS.sample} "
            string = [string, v].join(delimiter)
          end
        end

        "so #{string} many"
      end

      def object_to_key_value(value)
        if value.respond_to?(:attributes)
          value.attributes
        elsif value.respond_to?(:to_hash)
          value.to_hash
        else
          value.instance_values
        end
      end
    end

    ESCAPED_CHARS = {
    "\u2028" => '\u2028',
    "\u2029" => '\u2029',
    '>'      => '\u003e',
    '<'      => '\u003c',
    '&'      => '\u0026',
    }

    ESCAPE_REGEX_WITH_HTML_ENTITIES = /[\u2028\u2029><&]/u

    # This class wraps all the strings we see and does the extra escaping
    class EscapedString < String #:nodoc:
      def to_dson
        gsub ESCAPE_REGEX_WITH_HTML_ENTITIES, ESCAPED_CHARS
      end
    end
  end
end
