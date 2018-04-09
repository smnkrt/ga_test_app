require 'reform/form/coercion'

class BaseForm < Reform::Form
  include Coercion

  def process(params)
    validate(params) && save
  end
end
