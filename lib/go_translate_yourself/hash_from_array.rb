class HashFromArray
  def self.hash_from_array(array)
    array.inject({}) {|h, elem| h[elem[0]]=elem[1]; h}
  end
end
