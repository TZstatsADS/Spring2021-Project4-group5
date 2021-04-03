#!/usr/bin/env python
# coding: utf-8

# Metric 3: Linear Propensity Score
# Defined as:
# $$D_{ij}=|logit(e_i)-logit(e_j)|$$Obtained by applying the logit function on the propensity scores.
# 
# Matching on the linear propensity score can be particularly effective in terms of reducing bias.
# 

# a. Low Dim Data Linear Propensity Score didn't perform as well for low dimension as high dimensional data set, possibly for the same reason discussed above for standard Propensity Score. We can see from the ratio_list print out below that the ratio between treatment and controls in each group is not very consistent.
# 
# 

# In[ ]:


start = time.time()
full_match_linear_propensity_factor = optmatch.fullmatch(optmatch.match_on(Formula('A~linear_propensity_score'),data=lowDim_dataset_linear_propensity_R,method='euclidean'),data=lowDim_dataset_linear_propensity_R)
lowDim_dataset_linear_propensity['assign'] = list(full_match_linear_propensity_factor)


# In[ ]:


#compute ATE
ATE_vec = []
weights = []
ratio_list = []

for i in range(max(list(full_match_linear_propensity_factor))):
    temp = lowDim_dataset_linear_propensity.loc[lowDim_dataset_linear_propensity['assign']==i+1]
    
    treatment_Y = temp.loc[temp['A']==1]['Y'].values
    control_Y = temp.loc[temp['A']==0]['Y'].values
    
    ATE_vec.append(np.mean(treatment_Y)-np.mean(control_Y))
    weights.append(len(treatment_Y)+len(control_Y))
    ratio_list.append([len(treatment_Y),len(control_Y)])
    
lowDim_linear_propensity_est_ATE = np.average(ATE_vec, weights=weights)

end = time.time()
lowDim_linear_propensity_match_runtime = end-start
print(ratio_list[0:10])


# In[ ]:


lowDim_linear_propensity_runtime = "{:,.3f}".format(lowDim_linear_propensity_R_runtime+lowDim_linear_propensity_match_runtime)


# In[ ]:


lowDim_linear_propensity_error = abs(lowDim_true_ATE-lowDim_linear_propensity_est_ATE)
lowDim_linear_propensity_error ="{:,.3f}".format(lowDim_linear_propensity_error)
lowDim_linear_propensity_est_ATE ="{:,.3f}".format(lowDim_linear_propensity_est_ATE)

print("ATE for low dimension is: ", lowDim_linear_propensity_est_ATE)
print("Runtime for low dimension is: ", lowDim_linear_propensity_runtime)
print("ATE error for low dimension is: ", lowDim_linear_propensity_error)


# b. High Dim Data
# Linear Propensity score performed well for high dimensional data set as explained above for standard propensity score. In addition, linear propensity score is effective in reducing bias.

# In[ ]:


start = time.time()
full_match_linear_propensity_factor = optmatch.fullmatch(optmatch.match_on(Formula('A~linear_propensity_score'),data=highDim_dataset_linear_propensity_R,
                                                                           method='euclidean'),data=highDim_dataset_linear_propensity_R)
highDim_dataset_linear_propensity['assign'] = list(full_match_linear_propensity_factor)


# In[ ]:


#compute ATE
ATE_vec = []
weights = []
ratio_list = []
for i in range(max(list(full_match_linear_propensity_factor))):
    temp = highDim_dataset_linear_propensity.loc[highDim_dataset_linear_propensity['assign']==i+1]
    
    treatment_Y = temp.loc[temp['A']==1]['Y'].values
    control_Y = temp.loc[temp['A']==0]['Y'].values
    
    ATE_vec.append(np.mean(treatment_Y)-np.mean(control_Y))
    weights.append(len(treatment_Y)+len(control_Y))
    ratio_list.append([len(treatment_Y),len(control_Y)])

highDim_linear_propensity_est_ATE=np.average(ATE_vec, weights=weights)

end = time.time()
highDim_linear_propensity_match_runtime = end-start
print(ratio_list[0:10])


# In[ ]:


highDim_linear_propensity_runtime = "{:,.3f}".format(highDim_linear_propensity_R_runtime+highDim_linear_propensity_match_runtime)


# In[ ]:


highDim_linear_propensity_error = abs(highDim_true_ATE-highDim_linear_propensity_est_ATE)
highDim_linear_propensity_error ="{:,.3f}".format(highDim_linear_propensity_error)
highDim_linear_propensity_est_ATE ="{:,.3f}".format(highDim_linear_propensity_est_ATE)

print("ATE for high dimension is: ", highDim_linear_propensity_est_ATE)
print("Runtime for high dimension is: ", highDim_linear_propensity_runtime)
print("ATE error for high dimension is: ", highDim_linear_propensity_error)


# In[ ]:




