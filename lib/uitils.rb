module Utils
  
  
  def self.quick_sort(list, left, right)
    if right > left
      pivot_index = 0
      pivot = list[pivot_index]
      pivot_new_inext = self.partionate(list, left, right, pivot_index)
      self.quick_sort(list, left, pivot_new_inext-1)
      self.quick_sort(list, pivot_new_inext+1, right)
      puts list.join(" ")
    end
  end
  
  def self.partionate(list, left, right, pivotIndex)
    pivot = list[pivotIndex]
    list[pivotIndex], list[right] = list[right], list[pivotIndex]# 把 pivot 移到結尾
    storeIndex = left
    (left..right).each do |i|
      if list[i] < pivot
        list[storeIndex], list[i] = list[i], list[storeIndex]
        storeIndex = storeIndex + 1
      end
    end
    list[right], list[storeIndex] =  list[storeIndex], list[right]
    return storeIndex
  end

end

puts Utils.quick_sort([1,3,2,5,6,2,7],0,7-1)