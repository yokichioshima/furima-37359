module BlankCheckSupport
  def blank_check(hash, key)
    hash[key] = ''
    hash.valid?
    # keyがidの場合、エラー文に_idは出力されないため、以下のとおり分岐する。
    if key.to_s.end_with?('_id')
      expect(hash.errors.full_messages).to include(key.to_s.capitalize.chop.chop.chop.gsub(/_/, ' ') + ' ' + "can't be blank")
    else
      expect(hash.errors.full_messages).to include(key.to_s.capitalize.gsub(/_/, ' ') + ' ' + "can't be blank")
    end
  end

  def collection_select_blank_check(hash, key)
    hash[key] = 1
    hash.valid?
    if key.to_s.end_with?('_id')
      expect(hash.errors.full_messages).to include(key.to_s.capitalize.chop.chop.chop.gsub(/_/, ' ') + ' ' + "can't be blank")
    else
      expect(hash.errors.full_messages).to include(key.to_s.capitalize.gsub(/_/, ' ') + ' ' + "can't be blank")
    end
  end
end
