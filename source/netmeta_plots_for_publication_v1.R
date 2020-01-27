# Project: Network Meta-Analysis
# PI: Aakash Garg
# Author: Davit Sargsyan
# Date: 01/22/2020

# 1. Network plot
tmp <- data.table(x = c(1, 2, 3),
                  y = c(1, 2, 1),
                  n = c(14, 18, 4))
p1 <- ggplot() +
  geom_segment(aes(x = c(1, 2, 1),
                   xend = c(2, 3, 3),
                   y = c(1, 2, 1),
                   yend = c(2, 1, 1),
                   size = c(4, 2, 1),
                   linetype = c("dashed",
                                "dashed",
                                "solid")),
               color = "black") +
  geom_segment(aes(x = c(1, 2),
                   xend = c(2, 3),
                   y = c(1, 2),
                   yend = c(2, 1),
                   size = c(2.8, 1.2)),
               color = "white") +
  geom_point(data = tmp,
             aes(x = x,
                 y = y,
                 size = n),
             shape = 21,
             fill = "white") +
  geom_text(aes(x = c(1.2, 2, 2.8),
                y = c(0.9, 2.1, 0.9),
                label = c("S-DAPT/ASA",
                          "L-DAPT",
                          "S-DAPT/P2Y12"))) +
  geom_text(aes(x = c(1.5, 2.5),
                y = c(1.6, 1.6),
                label = c("14 Studies",
                          "4 Studies"),
                angle = c(52, -52))) +
  theme_void() +
  theme(legend.position="none")
p1

tiff(filename = "tmp/network.tiff",
     height = 5,
     width = 6,
     units = 'in',
     res = 600,
     compression = "lzw+p")
print(p1)
graphics.off()

# 2 & 3. Forest plots
tmp <- fread("data/netmeta_v6_estimates_selected_v2.csv")
# tmp <- fread("data/netmeta_v7_estimates_selected_v2.csv")
tmp$Endpoint <- factor(tmp$Endpoint,
                       levels = unique(tmp$Endpoint))

tmp$Label <-factor(tmp$Label,
                   levels = c("S-DAPT/P2Y12 vs. S-DAPT/ASA",
                              "S-DAPT/P2Y12 vs. L-DAPT",
                              "S-DAPT/ASA vs. L-DAPT"))
tmp$Est <- paste0(tmp$OR,
                  " (",
                  tmp$LB,
                  ";",
                  tmp$UB,
                  ")")

p1 <- ggplot(tmp,
             aes(x = OR,
                 y = Label,
                 xmin = LB,
                 xmax = UB)) +
  facet_wrap(.~ Endpoint,
             ncol = 1) +
  geom_errorbarh(height = 0) +
  geom_vline(xintercept = 1,
             linetype = "dashed") +
  geom_point(shape = 21,
             size = 2,
             fill = "grey") +
  geom_text(aes(x = rep(max(tmp$UB) + 0.05, nrow(tmp)),
                y = rep(4, nrow(tmp)),
                label = c("OR (95% C.I.)",
                          rep("", nrow(tmp) - 1))),
            hjust = 0) +
  geom_text(aes(x = rep(max(tmp$UB) + 0.05, nrow(tmp)),
                y = Label,
                label = Est),
            hjust = 0) +
  coord_cartesian(xlim = c(min(tmp$LB),
                           max(tmp$UB)),
                  ylim = c(1:3),
                  clip = "off") +
  scale_y_discrete("") +
  scale_x_continuous("",
                     expand = c(0.01, 0.01)) +
  theme(plot.margin = unit(x = c(1, 8, 1, 1), 
                           units = "lines"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))
p1

tiff(filename = "tmp/fig1.tiff",
     height = 7,
     width = 9,
     units = 'in',
     res = 300,
     compression = "lzw+p")
print(p1)
graphics.off()