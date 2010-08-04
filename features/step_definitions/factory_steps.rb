Dado /^que (?:o|os|a|as) seguint(?:e|es) (.+) exist(?:e|em):$/ do |nome, table|
  table.hashes.each do |hash|
    Factory( nome.singularize, hash )
  end
end