  class ActiveRecord::Base     
    def save!(*)
        create_or_update || raise(RecordNotSaved.new("Failed to save the record", self))
        rescue RangeError
            return false
      end
  end