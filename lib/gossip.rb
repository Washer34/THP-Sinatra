require 'csv'
class Gossip 
  attr_accessor :author, :content, :id

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all 
    all_gossips = []
    CSV.foreach("db/gossip.csv") do |row|
      all_gossips << Gossip.new(row[0], row[1])
    end
    return all_gossips
  end

  def self.find(id)
    return self.all[id.to_i]
  end

  def self.edit(id, new_author, new_content)
    to_update = self.find(id)
    puts "#{to_update.author}"
    to_update.author = new_author
    puts "#{to_update.author}"
    to_update.content = new_content
    all_gossips = CSV.read("db/gossip.csv")
    all_gossips.each_with_index do |gossip, index|
      if index.to_i == id.to_i
        gossip[0] = new_author
        gossip[1] = new_content
        break
      end
    end
    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips.each do |gossip|
        csv << gossip
      end
    end
  end

end