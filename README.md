# Project 4: Causal Inference

### [Project Description](doc/project4_desc.md)

Term: Spring 2021

+ Group 5
+ Project title: Implementing, Evaluating, and Comparing Full Matching with Five Propensity Scoring Models and Weighted Regression in a Causal Inference Problem  
+ Team members
	+ Amir Idris
	+ Yandong Xiong
	+ Ruize Yu
	+ Sean Harris
	+ Chuyun Shu
+ Project summary: Our group was assigned six approaches, listed below, to estimate the treatment effect on an outcome _Y_ in two datasets, one 24 features and another with 187 features. The propensity models were implemented individually, and can be found in the lib folder. The full matching algorithm was derived and implemented from scratch, and can be found in the lib folder, with the results from the algorithm found in the doc folder under _main\_scratch.Rmd_. Because this approach was too slow for the full datasets, the final version of full matching was implemented using the _MatchIt_ package. The final report can be found under the doc folder, _main.Rmd_. The approaches were evaluated by the error of their estimates as well as their runtime. The final presentation can be found under the doc folder, _ADS Project 4 Presentation_. 
	
**Contribution statement**:
+ <ins>Amir Idris</ins>: Research references for full matching, derive algorithm for full matching, implement full matching algorithm from scratch, test and write report on full matching from-scratch algorithm. Implement full matching algorithm using _MatchIt_. Implement linear propensity score. Implement logistic regression for propensity estimation. Edit L1 and L2 penalized logistic regression functions. Edit regression tree and boosted stumps propensity models. Research and co-implement weighted regression function. Write final report and evaluate results. Write and deliver final presentation. Organize and lead group meetings, record meeting minutes. 
+ <ins>Yandong Xiong</ins>: Research and implement regression tree propensity model. Research and co-implement weighted regression algorithm. 
+ <ins>Ruize Yu</ins>: Research and implement boosted stumps propensity model. Research and co-implement weighted regression algorithm.
+ <ins>Sean Harris</ins>: Research and implement L1 and L2 penalized logistic regression propensity models. Research full matching package _MatchIt_. 
+ <ins>Chuyun Shu</ins>: Research and implement boosted stumps propensity model.Research and help co-implement L1 Penalized Logistic Regression propensity model.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
