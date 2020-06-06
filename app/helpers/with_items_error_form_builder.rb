class WithItemsErrorFormBuilder < ActionView::Helpers::FormBuilder

  def pick_errors(attribute)
    return nil if @object.nil? || (messages = @object.errors.messages[attribute]).nil?

    lis = messages.collect do |message|
      %{<li>#{@object.errors.full_message(attribute, message)}</li>}
    end.join

    %{<ul class="error_message">#{lis}</ul>}.html_safe
  end

  def text_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def file_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def text_area(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def number_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    return super if options[:no_errors]
    super + pick_errors(method)
  end

  def select(attribute, choices = nil, options = {}, html_options = {}, &block)
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end


  (field_helpers - [:label, :radio_button, :hidden_field]).each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(attribute, options = {})
        return super if options[:no_errors]
        super + pick_errors(attribute)
      end
    RUBY_EVAL
  end
end