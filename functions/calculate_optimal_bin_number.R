### calculate_optimal_bin_number.R
### Author: Erik Ländström
### Created: 181212
### Date: 200204

# Calculates the optimal number of bins for one sample accroding to the 
# Freedman-Diaconis rule for histograms.

# Arguments:
# tb = a vector of values, e.g.: LFQ intensities for one sample

calculate_optimal_bin_number <- function(tb) {
  b <- diff(range(tb, na.rm = TRUE)) / 
    (2 * IQR(tb, na.rm = TRUE) / 
       length(tb)^(1/3))
  
  return(b)
}  

