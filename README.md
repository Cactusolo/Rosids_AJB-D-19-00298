# Rosids_AJB-D-19-00298  

**Estimating rates and patterns of diversification with incomplete sampling: A case study in the rosids**  

_Miao Sun, Ryan A. Folk, Matthew A. Gitzendanner, Pamela S. Soltis, Zhiduan Chen, Douglas E. Soltis, Robert P. Guralnick_

**_Note:_**  
_Scripts and documentation are provided here with an assumption that users have basic knowledge of UNIX shell, R, and Python, including changing the working directory, and pointing to the input and output path to link data and properly execute the scripts. In order to fully reproduce the results in our study, high performance computing clusters ([HiPerGator](https://www.rc.ufl.edu/) at University of Florida) must be used for BAMM and RPANDA analysis._  

_Here we lay out below each of our scripts based on the order of the workflow as described in the main text. All the scripts and their relative folders are descriptively named based on their primary functionalities in the analyses, and detailed under each highlighted bullet point._  
<p align="center">
<img src="./image/workingflow.png" height="550px" />  
</p>  


## Datasets

+ **trees**  
  
  This folder contains four subfolders: "rosids_9k-tip", "rosids_20k-tip", "rosids_100k-tip" and "whole_tree". See "readme" for some naming conventions, and such conventions are ture all across data and scripts in this repo.  
  
  As described in the main text, all analyses were run in parallel across 17 subclades corresponding to all rosid orders recognized in [APG IV (2016)](https://onlinelibrary.wiley.com/doi/10.1111/boj.12385), hence all the 17 subclades trees are inside 9k-, 20k-, and 100k-tip folders, respectively.  
  
  We also used the whole tree (see "whole_tree" folder) for DR and RPANDA analyses.  
  _All trees are ultrametric._  

+ **clade_age**  
  Crown age of major clades in rosids were extracted from 9k-, 20k- and 100k-tip trees, respecitvely using R script _"./Scripts/misc/get_crown_age.R"_. The age estimated from treePL is used in present study, and compared (see Fig. 2 in the main text). 

+ **diversification_data**  
  Raw data and summerized results from three commonly used methods, both parametric (RPANDA and BAMM) and semiparametric (DR). Details see below under the name of each folder. Our general convention is that the summarized results are located at the root of each menthod directory.    
  
    - **RPANDA**  
      _A folder with all the resultant data generated by RPANDA analyses for 9k-, 20k-,and 100k-tip trees, including Rdata from birth-death and pure-birth models, summarized Akaike-weight, and diversification rates. Raw data is retained inside folders, and summarized data (`.csv` format) under directory of main folder. Any files with "17" tag means data was analyzed at subclade level, while "whole" means the whole rosid tree is analyzed._  
      
    - **BAMM**  
      _Two main folders under this directory --- "BAMM_BD"" and "BAMM_PB". They contain main results from BAMM analyses under birth-death ("BD") and pure-birth ("PB") models, respectively. We only used 17 subclades from 20k-tip tree for testing and comparing how tip rates and speciation rates were influenced by different diversification models._  
      _Note: given the large volume of BAMM event data (e.g., 2.84 GB for "Fabales" event data) and limitation of file size can be commited via git, only summarize rate files were uploaded._
      
    - **DR**   
      _A folder with all the DR rates calculated by R script "./Scripts/DR/DR_statistic.R". DR rates from 17 subclades are retained in 9k, 20k, and 100k tagged folders, respectively. DR rate for the whole tree are kept in "whole_tree" folder. Mean Dr rate for eahc order are summarized in `csv` file under "DR" directory._
      
    - **Cucurbitaceae_Test_Case**   
      _This folder contains four sub-folders: "Cucurbitaceae_original_subclade_tree", "Cucurbitaceae_random_sampling", "Cucurbitaceae_random_sampling_addin", and "Cucurbitaceae_representive_sampling"._  
      
        + **Cucurbitaceae_original_subclade_tree**  
          Diversification results from one single Cucurtbitaceae tree extract from 20k-tip rosid tree, including 528 tips (_tree file in "data" folder_).  
        
        + **Cucurbitaceae_random_sampling**  
          Diversification results from the simulation of randomly missing species by randomly dropping extant species from the original Cucurbitaceae tree (_Cucurbitaceae_original_subclade_tree_) at four sampling levels (10%, 30%, 50%, and 75% of sampled species), with 10 replicates for each sampling treatment (_40 trees in total, see tree files in "tree_40" folder_).  
          
        + **Cucurbitaceae_random_sampling_addin**  
          Diversification results from the simulation randomly missing species that are added in via backbone taxonomies via randomly dropping extant species at four sampling levels (as introduced above) and then adding them back to the phylogeny by attaching them to the most recent common ancestor (MRCA) of the genus, with the tip branch length extended to the present, similar to [Smith and Brown (2018)](https://bsapubs.onlinelibrary.wiley.com/doi/full/10.1002/ajb2.1019). These steps were done in 10 replicates with [OpenTree PY Toys](https://github.com/blackrim/opentree_pytoys) (_40 trees in total, see tree files in "tree_40/resulted_tree" folder_). 
          
        + **Cucurbitaceae_representive_sampling**  
          Diversification results from the simulation representative sampling. We pruned 528-tip Cucurtbitaceae tree from 20k-tip rosid phylogeny to a genus-level phylogeny by randomly selecting one species in each genus in 10 replicates. Across these scenarios, we repeated the diversification methods for the 10 replicated trees (_10 trees in total, see tree files in "tree_10" folder_)).  
          
          For these 10 replicate genus-level trees, we also explored the impact of a global sampling probability (one missing species proportion imposed as the parameter for the entire tree) and species-specific sampling probabilities (missing species parameters for arbitrarily defined clades, often named taxa) on diversification rates implemented in **BAMM** (_see "Cucurbitaceae_representive_sampling/genus_10BAMM/global_sampling" and "Cucurbitaceae_representive_sampling/genus_10BAMM/species-specific_sampling"_).  
          

## Scripts  

_**Note:** All the scripts here are categoried under the name of their directories (excuting diversification analyses, summarizing results and plotting figures in the main text, and supporting information). Please modify and confirm the input and output path before executing these scripts. All the file names here descriptively denote the specific purpose and follow the order of the main text (which see); further explanatory notes are selectively given below._  
        
+ **DR**  

    - _**DR_statistic.R**_  
      This script computes the DR statistic for the entire rosid tree and each ordinal tree. The method was described by [Jetz et al. (2012)](https://www.nature.com/articles/nature11631), and the script was derived from [Harvey et al. (2016)](https://www.pnas.org/content/114/24/6328).  
        
    - _**Extract_DR_subclade.sh**_  
      This bash script is used to extract DR rates for each order based on the species (tip) belong to which order.  It'll loop through all 17 rosid order based on [list](./Datasets/order.txt) with names of all rosid orders. All see comments inside the script.  
        
    - _**Summ_mean_DR_each_order.R**_  
      This R script will go through each of order folder created by step above, then summrized *mean* DR rates for each order.  
    
+ **RPANDA**  

    - _**fitbd.R**_  
      This script fits **9** time-dependent likelihood diversification birth-death [RPANDA models](https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.12526) to rosid 9k-, 20k-, and 100k-tip trees, and 17 subclades, and saving the results of fitted models as R objects.  
        outputs a summary table of parameters and values estimated from each model for each rosid subclade.  
        
    - _**fitbd_summ.R**_  
      This script outputs summary table of parameters and values estimated from each model for each rosid subclade.   
      
    - _**RPANDA_PB_model.R**_  
      This scipt will only extract pure-birth models from the 9 models mentioned above.  
      
    - _**RPANDA_summary_AW.R**_  
      This scipt reads in the summary table generated above, and then selects the model with the smallest Akaike Information Criterion (AIC; [Akaike, 1974](https://ieeexplore.ieee.org/document/1100705)) value and largest [Akaike weight](https://www.ncbi.nlm.nih.gov/pubmed/15117008) as the best diversification model for each rosid tree, or subclade, then outputs these values into a table (see **Appendix S2b**).  
    - _**RPANDA_model_weighted_mean_speciation_rate_summ.R**_  
      As explianed in the script title. Also see **Appendix S3a**.  
        
    
+ **BAMM**   

    _Given different sampling sclaes (9k-, 20k-, and 100k-tip), it's hard for BAMM to reach MCMC converge from a single run, even we already downsized the whole tree into subclades. Hence multiple runs were conducted for each large-size clade of each datasets. In the end, we concatenate event data from each run for each order and only keeps one header using the scirpts below.  Most of the scripts can be both applied to post-run analyses for BAMM under both "BD" and "PB" models, except configure files for BAMM runs._

    - _**Run_priors.sh**_  
      This bash script is used for “setBAMMpriors” in BAMM analyses; combining information from `rosid_17_order_sampling_fraction.csv` and `write_prior.R`  
          
    - _**write_prior.R**_  
      This dummy script is used by `Run_priors.sh` and will output parameters for each order to feed `BAMM_diversification.config`  
          
    - _**BAMM_BD_diversification.config** and **BAMM_PB_diversification.config**_  
      BAMM control file for "BD" and "PB" diversification analyses, containing a replaceable parameter template, which would be modified by `Run_BAMM_config_setup.sh` script below for each specific order.
            
      If not converged, this file should be modified again to load event data from previous run with additional generations; for more details see [BAMM website](http://bamm-project.org/quickstart.html). 
            
    - _**Run_BAMM_config_setup.sh**_  
      This bash script will replace parameter templates (above; denoted XXX) with specific values (`rosid_17_order_sampling_fraction.csv`) corresponding to each rosid order, as well as parameters produced by `Run_priors.sh` script. After this step, the BAMM configure file is ready to run   
         
    - _**BAMM.sbatch**_  
      Slurm job script from running BAMM including information of computational resources request.
        
    - _**BAMM_converge_checker.R**_  
      This script will check the combined "mcmc" file to ensure MCMC convergence (>200 for both the number of shifts and log likelihoods).  
        
    - _**BAMM_post-run_data_collector.sh**_  
      This bash script will combine mcmc data and event data of each order from all the BAMM runs, respectively. It will prepare the required data files for `BAMM_postrun_analyses_Order_Batch.R` step below.  
      `combine_BAMM_eventdata.sh` has similar function, but only works for event data.  

    - _**config_nrun_maker.sh**_  
      As noted in the begininng, it required multiple runs to each convergent, so if n-th run failed to converge, then (n+1)-th will launched automatically by run this bash script, with features of modifying corresponding parameters in the configure file.  
        
    - _**BAMM_postrun_analyses_Order_Batch.R**_   
      This script evaluate MCMC convergence of BAMM runs for each order (`Order`), and also extracts summaries of "tip rates"", "mean lambd", "rate-through-time matrices", etc. for downstream analyses. It also saves event data as an `.rds` file for read-in efficiency.  
      
        `BAMM_analysis_clade.R` has similar function, just working on single clade.
    
    - _**rosid_9k-20k_mean_rates_summ.R** and **rosid_100k_mean_rates_summ.R**_  
      These two scripts are used to summarized mean median tree-wide speciation rates and tips rate from all three rosid trees.  
        
    - _**BAMM_BD_vs_PB_sum_rate_plot.R**_  
      This script will plot and compare the rates through time summarized from rosid 20k-tip tree under BD and PB models (also see **Appendix S3d**).  
          

+ **Cucurbitaceae_Test_Case**  

    _This folder contains four sub-folders: "Cucurbitaceae_original_subclade_tree", "Cucurbitaceae_random_sampling", "Cucurbitaceae_random_sampling_addin", and "Cucurbitaceae_representive_sampling". All the scripts under each subfolder are corresponding with data files in the four sub-folders in **Datasets** section._  
    
    _Generally, names for these scripts are self-explained, including random trees generation, BAMM configure file, slurm job submission files, some bash scripts for automation, and Rscripts for three diversification analyses and their post-run summary._  
    
      
+ **Figs**  
 
    The scripts are corresponding to Figs.2-8 in the main text. Most are barplots and diversification rate curves from BAMM.   
    
+ **misc**  

    - _**Appendix_S3d.R** and **Appendix_S4.R**_  
    These scripts are used to generate plots in Online Supplemental files --- Appendix_S3d and Appendix_S4.  
  
    - _**Cucurbitaceae_genus10_AW_rate_summ.R**_  
      This script is used to summarized rates from three diversification methods, and conducting "TukeyHSD" test and some exploratory plotting (some may not used in paper) for different rates dataset from different sampling treaments (see Material and Methods section in the main text).  
      
    - _**get_crown_age.R**_  
      This script is used to extract ages of major rosid clade (see Fig. 2).  
      
    - _**Run_config_single_clade.sh**_  
      This script will generate and setup BAMM configure file for one single order (clade).  
      
    - _**make_ultra.R and make_ultra.sh**_  
      All the trees are dated, and ultrametric, but different OSs have different convents of round up maximum digits for the branch length info. Hence these two scripts will work together to address this issue, making trees ultrametric to facilitate downstream diversification analyses.  
      
    - _**subclade_extract_V2.sh**_  
      By providing a larger tree and a list of two tips used as most recent comment ancester (MRCA) to defined a clade, this bash script will extract the clade using phyx (make sure [Phyx](https://github.com/FePhyFoFum/phyx) is installed).  
      
    - _**summary_rate.sh**_  
      This script will summarize "Speciation Rate" and "Tip Rate" of each rosid order into one table (also see "./Scripts/BAMM/rosid_100k_mean_rates_summ.R" and "./Scripts/BAMM/rosid_9k-20k_mean_rates_summ.R").  
      

    
## Requirements
+ **R V.3.5.3**  
+ **Python3**  
+ **Bash**  
+ **[Phyx](https://github.com/FePhyFoFum/phyx)**
+ **[Newick Utilities](http://cegg.unige.ch/newick_utils)**  
  _The link with installation and mannual_  
  
  _The data analyses in this study were conducted either on a MacBook Pro laptop (OS-X) or on a Linux cluster system ([HiPerGator](https://www.rc.ufl.edu/))._  
  
  
  
_**If you found this repository useful, please cite our work and/or this repo.**_

