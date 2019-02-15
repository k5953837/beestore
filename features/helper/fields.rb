module FieldsHelper
  def field_id(field)
    case field
    when 'Aishield Select'
      'aishield_select'
    else
      field
    end
  end
end

World FieldsHelper
