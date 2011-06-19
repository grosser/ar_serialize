require 'active_record'

module ARSerialize
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip

  def self.serialize(v)
    if v.is_a?(ActiveRecord::Base)
      "ActiveRecord:#{v.class}:#{v.id}"
    elsif v.is_a?(Hash)
      Hash[v.map do |k,value|
        [k, serialize(value)]
      end]
    elsif v.is_a?(Array)
      v.map do |value|
        serialize(value)
      end
    else
      v
    end
  end

  def self.deserialize(v)
    if v.is_a?(String) and v =~ /^ActiveRecord:(\w+):(\d+)$/
      $1.constantize.find($2)
    elsif v.is_a?(Hash)
      result = Hash[v.map do |k,value|
        [k, deserialize(value)]
      end]

      v.is_a?(HashWithIndifferentAccess) ? result.with_indifferent_access : result
    elsif v.is_a?(Array)
      v.map do |value|
        deserialize(value)
      end
    else
      v
    end
  end
end
