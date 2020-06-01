# NOTE: SEPARATE INTO A NEW REPO!
# Author: Davit Sargsyan
# Created: 05/31/2020
# Script: Meta-analysis of medians and interquartile ranges

# Aakash'e email, May 13 2020
# Please let me know if you got a chance to look. I have the median (IQR) values as follows:
#   
# In our study: operator's radiation exposure- diagnostic angio 17.8 micro Sv (13.2-34) , PCI 61 micro Sv (34-110.2)
# 
# In Historic controls: diagnostic angio 30 micro Sv (20-50), PCI 117 (68.3–197.8)

#**********

# On Sat, May 9, 2020 at 7:27 PM aakash garg <drgarg.aakash@gmail.com> wrote:
#   Hi Davit,
# 
# Please find the abstract below. Basically, trying to compare numbers in the blue lines. 
# 
# Hypothesis
# 
# We hypothesized that a simple reconfiguration of the conventional left radial setup could 
# afford the operator a significant reduction in radiation exposure and ergonomic stress.
# 
# Methods
# 
# Patient’s left arm was fully abducted at right angles to the body and placed on a pedestal
# table with forearm supinated thus putting the operator working site almost three feet away
# from the radiation source and providing enough room for the operator to sit down on a stool
# if so desired. A Geiger counter placed in juxtaposition with the patients left wrist was used
# as surrogate for operator radiation exposure.
# 
# Results
# 
# A total of 42 patients were included in the present study; 32 underwent diagnostic angiography and
# 10 underwent percutaneous coronary intervention. No access related complications or crossover to
# alternate access occurred. Median FT was 3.8 min and 12.3 min for patients undergoing diagnostic
# angiography and PCI, respectively. Median absorbed dose and DAP similarly varied for procedure type
# (diagnostic: 556 mGy and 35,108 mGy-cm2; PCI: 1570 mGY and 92,540 mGY-cm2). Finally, median operator’s
# radiation exposure were 17.8 μSv and 61 μSv for diagnostic angiography and PCI, respectively. 
# In historic controls, median operator dose was 30 μSv and 107 μSv with left or right TRA for diagnostic
# angiography and PCI. 
# 
# Conclusions
# 
# 1) Coronary procedures both diagnostic and interventions can safely be performed from left radial
# artery using this reconfigured cath lab set up.
# 
# 2) Significant reduction in operator radiation exposure as compared with historic controls and a
# reduction in ergonomic stress without taking away tactile feedback back makes this set up directly
# vie with the Cath lab robot; thus “Poor Man’s Robot”. 

#---

# Reference paper: Meta‐analysis of the difference of medians, S McGrath et al, Biomedical Journal, Sept 2019
# https://onlinelibrary.wiley.com/doi/full/10.1002/bimj.201900036

require(metamedian)
require(data.table)

# angio
qe.angio <- qe.study.level(q1.g1 = 13.2,
                           med.g1 =  17.8,
                           q3.g1 = 34,
                           n.g1 = 32,
                           q1.g2 = 20,
                           med.g2 = 30,
                           q3.g2 = 50,
                           n.g2 = 498)
qe.angio
qe.angio$effect.size - 1.96*sqrt(qe.angio$var)
qe.angio$effect.size + 1.96*sqrt(qe.angio$var)

# PCI
qe.pci <- qe.study.level(q1.g1 = 34,
                         med.g1 = 61,
                         q3.g1 = 110.2,
                         n.g1 = 10,
                         q1.g2 = 68.3,
                         med.g2 = 117,
                         q3.g2 = 197.8,
                         n.g2 = 379)
qe.pci
qe.pci$effect.size - 1.96*sqrt(qe.pci$var)
qe.pci$effect.size + 1.96*sqrt(qe.pci$var)

t1 <- data.table(grp = c("angio", "pci"),
                 `new - historic` = c(qe.angio$effect.size,
                                      qe.pci$effect.size),
                 `95%lb` = c(qe.angio$effect.size - 1.96*sqrt(qe.angio$var),
                             qe.pci$effect.size - 1.96*sqrt(qe.pci$var)),
                 `95%ub` = c(qe.angio$effect.size + 1.96*sqrt(qe.angio$var),
                             qe.pci$effect.size + 1.96*sqrt(qe.pci$var)))
t1
#            grp new - historic    95%lb      95%ub
# 1: angio          -12.2       -19.3293  -5.070704
# 2:   pci          -56.0       -99.0539 -12.946105

# Alternative package from Rutgers, Minge Xie, removed from CRAN!
# require(gmeta)

# Davit's replid to Aakash with results on 06/01/2020
