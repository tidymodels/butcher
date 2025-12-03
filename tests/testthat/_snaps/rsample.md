# butchering two-way rsplits

    Code
      print(basic_split_trim)
    Output
      <Training/Testing/Total>
      <0/0/0>

---

    Code
      print(time_split_trim)
    Output
      <Training/Testing/Total>
      <0/0/0>

---

    Code
      print(grp_split_trim)
    Output
      <Training/Testing/Total>
      <0/0/0>

---

    Code
      butcher(basic_split, verbose = TRUE)
    Message
      v Memory released: 4.24 kB
      x Disabled: `analysis()`, `as.data.frame()`, `as.integer()`, `assessment()`, `complement()`, `internal_calibration_split()`, `populate()`, `reverse_splits()`, `testing()`, `tidy()`, and `training()`
    Output
      <Training/Testing/Total>
      <0/0/0>

---

    Code
      butcher(time_split, verbose = TRUE)
    Message
      v Memory released: 5.10 kB
      x Disabled: `analysis()`, `as.data.frame()`, `as.integer()`, `assessment()`, `complement()`, `internal_calibration_split()`, `populate()`, `reverse_splits()`, `testing()`, `tidy()`, and `training()`
    Output
      <Training/Testing/Total>
      <0/0/0>

---

    Code
      butcher(grp_split, verbose = TRUE)
    Message
      v Memory released: 4.24 kB
      x Disabled: `analysis()`, `as.data.frame()`, `as.integer()`, `assessment()`, `complement()`, `internal_calibration_split()`, `populate()`, `reverse_splits()`, `testing()`, `tidy()`, and `training()`
    Output
      <Training/Testing/Total>
      <0/0/0>

# butchering three-way rsplits

    Code
      print(val_split_trim)
    Output
      <Training/Validation/Testing/Total>
      <0/0/0/0>

---

    Code
      butcher(val_split, verbose = TRUE)
    Message
      v Memory released: 4.79 kB
      x Disabled: `internal_calibration_split()`, `testing()`, `training()`, and `validation()`
    Output
      <Training/Validation/Testing/Total>
      <0/0/0/0>

# butchering rsets

    Code
      print(basic_rset_trim$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[3]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      print(boot_rset_trim$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      print(time_rset_trim$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      butcher(basic_rset, verbose = TRUE)
    Message
      v Memory released: 1.93 kB
      x Disabled: `populate()`, `reverse_splits()`, and `tidy()`
    Output
      #  3-fold cross-validation 
      # A tibble: 3 x 2
        splits        id   
        <list>        <chr>
      1 <split [0/0]> Fold1
      2 <split [0/0]> Fold2
      3 <split [0/0]> Fold3

---

    Code
      butcher(boot_rset, verbose = TRUE)
    Message
      v Memory released: 2.97 kB
      x Disabled: `populate()`, `reverse_splits()`, and `tidy()`
    Output
      # Bootstrap sampling 
      # A tibble: 2 x 2
        splits        id        
        <list>        <chr>     
      1 <split [0/0]> Bootstrap1
      2 <split [0/0]> Bootstrap2

---

    Code
      butcher(time_rset, verbose = TRUE)
    Message
      v Memory released: 2.98 kB
      x Disabled: `populate()`, `reverse_splits()`, and `tidy()`
    Output
      # Sliding window resampling 
      # A tibble: 2 x 2
        splits        id    
        <list>        <chr> 
      1 <split [0/0]> Slice1
      2 <split [0/0]> Slice2

# butchering tune_results

    Code
      print(tune_obj_trim$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      butcher(tune_obj, verbose = TRUE)
    Message
      v Memory released: 33.18 kB
      x Disabled: `augment()` and `fit_best()`
    Output
      # Tuning results
      # 2-fold cross-validation 
      # A tibble: 2 x 6
        splits        id    .metrics         .notes           .predictions .extracts
        <list>        <chr> <list>           <list>           <list>       <list>   
      1 <split [0/0]> Fold1 <tibble [6 x 5]> <tibble [0 x 4]> <tibble>     <tibble> 
      2 <split [0/0]> Fold2 <tibble [6 x 5]> <tibble [0 x 4]> <tibble>     <tibble> 

# butchering workflow sets

    Code
      print(wflow_res_trim$result[[1]]$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      print(wflow_res_trim$result[[2]]$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      print(wflow_res_trim$result[[3]]$splits)
    Output
      [[1]]
      <Analysis/Assess/Total>
      <0/0/0>
      
      [[2]]
      <Analysis/Assess/Total>
      <0/0/0>
      

---

    Code
      butcher(wflow_res, verbose = TRUE)
    Message
      v Memory released: 101.37 kB
      x Disabled: `augment()` and `fit_best()`
    Output
      # A workflow set/tibble: 3 x 4
        wflow_id info             option    result   
        <chr>    <list>           <list>    <list>   
      1 A_cart   <tibble [1 x 4]> <opts[3]> <tune[+]>
      2 B_cart   <tibble [1 x 4]> <opts[3]> <tune[+]>
      3 AB_cart  <tibble [1 x 4]> <opts[3]> <tune[+]>

