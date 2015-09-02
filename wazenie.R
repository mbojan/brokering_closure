library(dplyr)

set.seed(666)
N <- 30

individuals <- data.frame(x = sample(1:5, N, replace=TRUE) ) %>%
  mutate( y = round(2 * x + 2 + rnorm(N)) )

aggregated <- individuals %>% group_by(x, y) %>% summarise(freq=n()) %>% 
  ungroup() %>% mutate( w = freq/sum(freq) * 16  )

library(survey)
design <- svydesign( ~ 0, weights=~w, data=aggregated)

modele <- list( 
               ind_lm = lm(y ~ x, data=individuals),
               ind_glm = glm(y ~ x, family=gaussian(), data=individuals),
               wei_lm = lm(y ~ x, data=aggregated, weight=w),
               wei_glm = glm(y ~ x, data=aggregated, family=gaussian(), weight=w),
               svy_glm = svyglm(y ~ x, design=design, family=gaussian())
               )

# Effects are identical
sapply(modele, coef)

# Inference (i.e. SEs) not
sapply(modele, function(mod) coef(summary(mod))[,"Std. Error"])



# attempting to fix http://stackoverflow.com/questions/10268689/weighted-regression-in-r



modele$fixmod <- modele$wei_lm
modele$fixmod$df.residual <- with(fixmod, sum(weights) - 2)

sapply(modele, function(mod) coef(summary(mod))[,"Std. Error"])






