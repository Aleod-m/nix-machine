
def host-name [] {

}


def print-logo [] {
    let c1 = "cyan"
    let c2 = "blue"
    let c3 = "green"
    print $"
                           (ansi ($c1))▁▁                   (ansi ($c2))▁▁▁▁▁▁                ▁▁▁▁
                          (ansi ($c1))╱##╲                  (ansi ($c2))╲#####╲              ╱####╲
                         (ansi ($c1))╱####╲                  (ansi ($c2))╲#####╲            ╱#####╱ 
                         (ansi ($c1))╲#####╲                  (ansi ($c2))╲#####╲          ╱#####╱   
                          (ansi ($c1))╲#####╲                  (ansi ($c2))╲#####╲        ╱#####╱     
                           (ansi ($c1))╲#####╲                  (ansi ($c2))╲#####╲      ╱#####╱       
                            (ansi ($c1))╲#####╲                  (ansi ($c2))╲#####╲    ╱#####╱         
                             (ansi ($c1))╲#####╲                  (ansi ($c2))╲#####╲  ╱#####╱           
                              (ansi ($c1))╲#####╲                  (ansi ($c2))╲#####╲╱#####╱             
                  (ansi ($c1))▁▁▁▁▁▁▁▁▁▁▁▁▁╲#####╲▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁   (ansi ($c2))╲##########╱             (ansi ($c1))╱╲
                 (ansi ($c1))╱###################################╲   (ansi ($c2))╲########╱             (ansi ($c1))╱##╲
                (ansi ($c1))╱#####################################╲   (ansi ($c2))╲######╱             (ansi ($c1))╱####╲
               (ansi ($c1))╱#######################################╲   (ansi ($c2))╲#####╲            (ansi ($c1))╱#####╱ 
    (ansi ($c1))           ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔    (ansi ($c2))╲#####╲          (ansi ($c1))╱#####╱   
    (ansi ($c1))                                                         (ansi ($c2))╲#####╲        (ansi ($c1))╱#####╱     
                                 (ansi ($c2))▁▁▁▁▁▁     (ansi ($c3))▁▁▁▁▁▁▁▁▁▁▁▁▁▁    (ansi ($c2))╲#####╲      (ansi ($c1))╱#####╱       
                                (ansi ($c2))╱#####╱    (ansi ($c3))╱##############╲    (ansi ($c2))╲####╱     (ansi ($c1))╱#####╱         
                               (ansi ($c2))╱#####╱    (ansi ($c3))╱################╲    (ansi ($c2))╲##╱     (ansi ($c1))╱#####╱           
                              (ansi ($c2))╱#####╱    (ansi ($c3))╱##################╲    (ansi ($c2))╲╱     (ansi ($c1))╱#####╱             
    (ansi ($c2))                         ╱#####╱    (ansi ($c3))╱####################╲         (ansi ($c1))╱#####╱               
    (ansi ($c2))   ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁╱#####╱    (ansi ($c3))╱######################╲       (ansi ($c1))╱#####╱▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
    (ansi ($c2))  ╱##########################╱    (ansi ($c3))╱########################╲     (ansi ($c1))╱########################╲
    (ansi ($c2)) ╳##########################╱    (ansi ($c3))╳##########################╳   (ansi ($c1))╱##########################╳
    (ansi ($c2))  ╲########################╱      (ansi ($c3))╲########################╱   (ansi ($c1))╱##########################╱
    (ansi ($c2))   ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔╱#####╱        (ansi ($c3))╲######################╱   (ansi ($c1))╱#####╱▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
    (ansi ($c2))                   ╱#####╱    (ansi ($c1))╱╲    (ansi ($c3))╲####################╱   (ansi ($c1))╱#####╱                     
    (ansi ($c2))                  ╱#####╱    (ansi ($c1))╱##╲    (ansi ($c3))╲##################╱   (ansi ($c1))╱#####╱                     
    (ansi ($c2))                 ╱#####╱    (ansi ($c1))╱####╲    (ansi ($c3))╲################╱   (ansi ($c1))╱#####╱                     
    (ansi ($c2))                ╱#####╱     (ansi ($c1))╲#####╲    (ansi ($c3))╲##############╱   (ansi ($c1))╱#####╱                     
    (ansi ($c2))               ╱#####╱       (ansi ($c1))╲#####╲    (ansi ($c3))▔▔▔▔▔▔▔▔▔▔▔▔▔▔    (ansi ($c1))▔▔▔▔▔▔                     
    (ansi ($c2))              ╱#####╱         (ansi ($c1))╲#####╲                                               
    (ansi ($c2))             ╱#####╱           (ansi ($c1))╲#####╲    (ansi ($c2))▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ 
    (ansi ($c2))            ╱#####╱             (ansi ($c1))╳#####╲   (ansi ($c2))╲######################################╱
    (ansi ($c2))            ╲####╱             (ansi ($c1))╱#######╲   (ansi ($c2))╲####################################╱
    (ansi ($c2))             ╲##╱             (ansi ($c1))╱#########╲   (ansi ($c2))╲##################################╱
    (ansi ($c2))              ╲╱             (ansi ($c1))╱#####╳#####╲   (ansi ($c2))▔▔▔▔▔▔▔▔▔▔▔▔▔▔╲#####╲▔▔▔▔▔▔▔▔▔▔▔▔▔
    (ansi ($c2))                            (ansi ($c1))╱#####╱ ╲#####╲                 (ansi ($c2))╲#####╲           
    (ansi ($c2))                           (ansi ($c1))╱#####╱   ╲#####╲                 (ansi ($c2))╲#####╲         
    (ansi ($c2))                          (ansi ($c1))╱#####╱     ╲#####╲                 (ansi ($c2))╲#####╲       
    (ansi ($c2))                         (ansi ($c1))╱#####╱       ╲#####╲                 (ansi ($c2))╲#####╲     
    (ansi ($c2))                        (ansi ($c1))╱#####╱         ╲#####╲                 (ansi ($c2))╲#####╲   
    (ansi ($c2))                       (ansi ($c1))╱#####╱           ╲#####╲                 (ansi ($c2))╲#####╲ 
    (ansi ($c2))                      (ansi ($c1))╱#####╱             ╲#####╲                 (ansi ($c2))╲####╱
    (ansi ($c2))                      (ansi ($c1))╲####╱               ╲#####╲                 (ansi ($c2))╲##╱
    (ansi ($c2))                       (ansi ($c1))▔▔▔▔                 ▔▔▔▔▔▔                  (ansi ($c2))▔▔
    (ansi reset) 
"
}

print-logo
