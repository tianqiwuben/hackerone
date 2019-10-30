class Report < ApplicationRecord

  def update_attr(attr, value)
    if attr == :title
      if value.present?
        self.title = value 
      else
        return false
      end
    end
    if attr == :userName
      if value.present?
        self.user_name = value
      else
        return false
      end
    end
    self.description = value if attr == :description
    true
  end

  def to_json
    {
      id: self.id,
      title: self.title,
      description: self.description,
      userName: self.user_name,
      updatedAt: self.updated_at.to_i,
      createdAt: self.created_at.to_i,
    }
  end

end
