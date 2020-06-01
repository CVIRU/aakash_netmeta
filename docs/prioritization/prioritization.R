dt1 <- fread("docs/prioritization/Prioritization tool without patient Sheet2.csv")
dt1
t.test(dt1)

dt2 <- melt.data.table(dt1)
dt2 <- dt2[!is.na(value), ]

plot(dt2)
tt <- t.test(dt2$value ~ dt2$variable)
tt
tt$estimate
diff(tt$estimate)
tt$p.value
tt$conf.int
tt$estimate
tt$stderr
hist(dt2$value, 100)

dt2$value <- as.integer(dt2$value)
dt2$variable <- factor(dt2$variable,
                       levels = c("Cancelled",
                                  "Performed"))

table(dt2)

ggplot(dt2,
       aes(x = value,
           group = variable,
           fill = variable)) +
  geom_density(aes(y = ..count..),
               position = position_dodge(0.6),
               alpha = 0.2) +
  geom_histogram(bins = 100,
                 position = position_dodge(0.6)) +

  scale_x_continuous("Score",
                     breaks = seq(0, 40, 2)) +
  scale_y_continuous("Counts",
                     breaks = 0:11) +
  scale_fill_discrete("",
                      breaks = c("Performed",
                                 "Cancelled")) +
  theme_bw() +
  theme(legend.position = "top")
