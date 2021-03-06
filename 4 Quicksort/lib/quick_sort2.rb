class QuickSort
  def self.sort1(array)
    return array if array.length < 2
    left = []
    right = []
    pivot = array.shift
    array.each do |int|
      if pivot >= int
        left << int
      else
        right << int
      end
    end
    self.sort1(left) + [pivot] + self.sort1(right)
  end

  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proce.new { |first, second| first <=> second }
    return array if length < 2
    pivot_idx = self.partition(array, start, length, &prc)
    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |first, second| first <=> second }
    barrier = start
    pivot = array[start]
    ((start + 1)...(start + length)).each do |i|
      if prc.call(pivot, array[i]) > 0
        array[i], array[barrier + 1] = array[barrier + 1], array[i]
        barrier += 1
      end
    end
    array[start], array[barrier] = array[barrier], array[start]
    barrier
  end
end
