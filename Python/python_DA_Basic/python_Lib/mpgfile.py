class mpg:
    
    def __init__(self,a,b,c,d,e,f,g,h,i,j,k):
        self.mpgName = a
        self.mpgModel = b
        self.mpgDis = c
        self.mpgYear = d
        self.mpgCyl = e
        self.mpgTrans = f
        self.mpgDrv = g
        self.mpgCty = h
        self.mpgHwy = i
        self.mpgFl = j
        self.mpgCls = k
       
    def print_mpg(self):
        print("제조사는 : {}, 배기량 : {}, 연비 : {}".format(self.mpgName,self.mpgDis,self.mpgHwy))
      
    def disp4(self):
        feul4 = 0
        if self.mpgDis <= 4:
            feul4 += mpgHwy
        print("배기량이 4이하인 평균연비 : {}".format(feul4 / len(self.mpgDis <= 4))
        
        