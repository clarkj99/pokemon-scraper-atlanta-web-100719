class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon 
      (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
  end

  def self.new_from_db(row, db)
    self.new(id: row[0], name: row[1], type: row[2], db: db)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT id, name, type 
      FROM pokemon 
      WHERE id = ? 
      LIMIT 1
    SQL

    results = db.execute(sql, id)
    self.new_from_db(results[0], db)
  end
end
