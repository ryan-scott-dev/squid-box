module RepositoriesHelper

  def trim_string(string, length)
    if string.length > length
      "#{string[0..length]} ..."
    else
      string
    end
  end

end
