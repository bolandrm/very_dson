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
          value = delimited(:hash, value, stringify: false)
          "such #{value} wow"
        when Array
          value = delimited(:array, value)
          "so #{value} many"
        else
          raise "such fail - cannot stringify #{value}"
        end
      end

      def simplify(value)
        case value
        when Symbol
          EscapedString.new(value.to_s)
        when EscapedString
          value
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

      def delimited(type, value, stringify: true)
        string = ""

        value = value.map { |v| _stringify(v) } if stringify

        value.each_with_index do |v, i|
          if i == 0
            string = v
          else
            if type == :hash
              delimiter = "#{OBJECT_PAIR_DELIMITERS.shuffle.sample} "
            else
              delimiter = " #{ARRAY_DELIMITERS.shuffle.sample} "
            end
            string = [string, v].join(delimiter)
          end
        end
        string
      end

      def object_to_key_value(value)
        if value.is_a?(Date) || value.is_a?(DateTime) || value.is_a?(ActiveSupport::TimeWithZone)
          simplify(value.to_s)
        elsif value.respond_to?(:to_a)
          simplify(value.to_a)
        elsif value.respond_to?(:attributes)
          simplify(value.attributes)
        elsif value.respond_to?(:to_hash)
          simplify(value.to_hash)
        elsif value.respond_to?(:instance_values)
          simplify(value.instance_values)
        elsif value.respond_to?(:instance_values)
          simplify(value.instance_values)
        else
          raise "such fail - cannot convert to key value #{value}"
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
