class User
  attr_accessor :id
  attr_accessor :name
  attr_accessor :age

  def initialize(user)
    @id = user["id"]
    @name = user["name"]
    @age = user["age"]
  end
end

