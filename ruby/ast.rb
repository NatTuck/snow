
class SNum
  def initialize(text)
    if text.match(/\./)
      @num = text.to_f
    else
      @num = text.to_i
    end
  end

  def num
    @num
  end
end

class SSym
  def initialize(text)
    @sym = text
  end

  def sym
    @sym
  end
end

class SStruct
  def initialize(name, members)
    @name = name
    @mems = []
    
    unless members.size.even?
      raise Exception.new("Malformed struct")
    end

    until members.empty?
      @mems << members.take(2)
      members = members.drop(2)
    end
  end
end

class SDefn
  def initialize(head, body)
    @head = head
    @body = body
  end
end

class SLet
  def initialize(name, body)
    @name = name
    @body = body
  end
end

class SCall
  def initialize(name, args)
    @name = name
    @args = args
  end
end

class SMod
  def initialize(name, parts)
    @name  = name
    @parts = parts
  end

  def generate
    mod = Mod.new(name)
   
    @parts.each do |part|
      mod.add(part.generate)
    end

    mod
  end
end
