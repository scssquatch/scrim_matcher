# credit: https://github.com/rinkudasiitg/ruby-algorithmic-problems-and-their-solutions/blob/master/partition.rb
# modified slightly to work with hashes

def simple_partition(input, key)
  input.sort_by! { |info| info[key] }.reverse!
  return input.partition.with_index { |_, i| i.even? }
end
