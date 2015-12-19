class CacheService
  def initialize word
    @word = word
  end

  def save_word_to_cache
    words = JSON.parse $redis.get("words")

    words.push({"id"=>@word.id,
      "category_name"=>@word.category.name,
      "content"=>@word.content,
      "created_at"=>@word.created_at,
      "updated_at"=>@word.updated_at})

    $redis.set "words", words.to_json
  end

  def update_word_to_cache
    words = JSON.parse $redis.get("words")

    index = words.find_index{|word| word["id"] == @word.id}

    words[index]["category_name"] = @word.category.name
    words[index]["content"] = @word.content
    words[index]["updated_at"] = @word.updated_at

    $redis.set "words", words.to_json
  end

  def delete_word_from_cache
    words = JSON.parse $redis.get("words")

    # words.delete_if {|word| word["id"] == @word.id}

    words.delete_if {|word| word["category_name"] == "cat1"}

    $redis.set "words", words.to_json
  end
end
