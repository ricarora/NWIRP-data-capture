module ConvictionsHelper
  def convert_to_days(year, month, day)
    (year * 365) + (month * 30) + day
  end
end
