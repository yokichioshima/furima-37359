module BlankCheckSupport
  def blank_check(object, key)
    object[key] = ''
    object.valid?
    expect(object.errors.full_messages).to include(key.to_s.capitalize.gsub(/_/, ' ') + ' ' + "can't be blank")
  end
end
