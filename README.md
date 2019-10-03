##  Project: Network Meta-Analysis
### Study ID: [??](??)
### Principal Investigator: Aakash Garg
### Statistician: Davit Sargsyan 
### Created: 09/29/2019 

---    

## Table of Contents
[Daily Logs](#log) 
[Results](#results)   
[References](#ref)  

## Daily Logs<a name="log"></a>
### 09/29/2019
* Created teh repository and fihished preliminary analysis

### 10/02/2019
Meeting with Traymon, Javier and Dhammika 
  
1. Typo in the data file fixed ("Maojor" -> "Major")  
2. Typo in the code fixed (p-values were exponentiated)  
3. Some studies had zero events. Since the analysis is done on log-odds ratios, we were excluding studies with zeros, on the endpoint-by-endpoint bases. To keep all studies in, we added 1/2 (0.5) to all count. Such transformation is commonly used to deal with zeros. All teh results in this report are done on this, transformed data.This is only for the calculation, we are not showing halves in tables.  
4. The table with average ORs for each study now contains ORs in both direction for all comparisons (i.e., both ASA/P1Y12 amd P1Y12/ASA are presented).   
5. Additional information such as doses, treatment duration, average age, etc. can be useful. Even if you don't want to use it for this paper, can you please provide us with meta data for these studies?
6. The forest plot with all studies and the averages is asymmetric. We can make it symmetric by: a) plotting log-odds ratios or b) plotting them in semi-log scale.  
  
## Results<a name="res"></a>

## References<a name="ref"></a>