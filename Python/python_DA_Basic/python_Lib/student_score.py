
## class 정의
class Student:
    # class variable 굳이 잡을 필요 없을듯
    
    # 생성자 (constructor)
    def __init__(self,n,k,e,m):
        self.sName = n
        self.sKor = int(k)
        self.sEng = int(e)
        self.sMath = int(m)
        self.sAvg = self.calcul_avg()
        
    # method
    def calcul_avg(self):
        return (self.sKor + self.sEng + self.sMath) /3
    
    
    def print_student(self):
        print("학생의 이름은 : {}, 평균은 : {:.2f}".format(self.sName,self.sAvg))