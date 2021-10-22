if element == 'max' or element == "\d"
  #check if neighbor contain '0'
  if(@x_spielfeld[row_index-1][column_index] == [/\d/]
    return 'X'
  end
  if  @x_spielfeld[row_index-1][column_index+1] == ['/\d/']
    return 'X'
  end

end