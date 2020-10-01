##### Load Packages ########
# To install distributed packages in R using base packages, it usually takes two steps:
# Step 1: install packages
install.packages("pacman")

# Step 2: load packages - can use either of the followings:
require(pacman)  # Gives a confirmation message.
library(pacman)  # No message.

# For multiple packages, you need to repeat step 1 and step 2 for each package.

# Alternatively, by using the p_load function from "pacman" package, 
# you can install and load multiple packages in 1 step, such as:
p_load(pacman, dplyr, tidyr, stringr, ggplot2, rmarkdown, RJDBC, sqldf)

# or
pacman::p_load(pacman, dplyr, tidyr, stringr, ggplot2, rmarkdown, RJDBC, sqldf) 


##### Get Help
?p_load
??p_load
example("p_load")


##### Clear Packages ########
# Similarly, you can clear packages using base function (one at a time):
detach("package:pacman", unload = TRUE)

# Or use the p_unload function in "pacman" package to clear multiple packages at once
p_unload(dplyr, tidyr, stringr) # Clear specific packages
p_unload(all)  # Easier: clears all add-ons



