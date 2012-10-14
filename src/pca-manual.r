require(maptools)
require(grDevices)
require(graphics)


show_best = function(pca_res){
  t(t(pca_res$loadings[order(-abs(pca_res$loadings[,1])),1]))
}

show_best2 = function(pca_res){
  t(t(pca_res$loadings[order(-abs(pca_res$loadings[,2])),2]))
}

ud <- read.csv("../data/all-answers.csv") #users answers
cd <- read.csv("../data/vectors.csv") #candidates answers
debates <- read.csv("../data/debates.csv")


names <- cd[,2];
rnames <- cd[,1];
curias <- cd[,3];
cd = cd[,4:28]

length(names)
debates[order(debates[,2]),]
cd[c(92, 126, 93, 6, 145),]

qq = function(i1, i2){
  print(cor(ud[,i1], ud[,i2]))
  print(cor(cd[,i1], cd[,i2]))
}



get_corr = function(data, c){
  d = cor(data)
  all_edges = t(combn(1:(dim(d)[1]), 2))
  weights = cbind(all_edges, d[all_edges])
  return((weights[order(-abs(weights[,3])),])[1:c,])
}
get_corr(ud, 10)
get_corr(cd, 10)

show_best(princomp(ud))
show_best(princomp(cd))
# q18 -0.34942645 �������� ������������
# q24  0.34718659 ��� ���� ����������� � ���������
# q2  -0.31309653 ������ �������������� �������������
# q19 -0.28727912 ���-���������� � ����������
# q9   0.28266777 ����� �� ���������

# ����������:
#q18 -0.37341069  �������� ������������
#q24  0.34344388  ��� ���� ����������� � ���������
#q14 -0.32309573  ������� � ������ �����
#q2  -0.29902236  ������ �������������� �������������
#q6  -0.28560120  ���������� �������� � �����������
#q19 -0.27401402  ���-���������� � ����������

# �����:
axis1=c(18, 24, 2, 9, 19) # ���. ���� ����������� � ���������
show_best(princomp(cd[,-axis1]))
show_best(princomp(ud[,-axis1]))
# q14  0.46184408 ������� � ������ �����
# q13 -0.35050193 ��� ����
# q11 -0.34172888 ������ � ����������
# q3   0.32510906 �������� ����������
# q10 -0.29413253 ��������� ������ �������
# q20 -0.29328469 ������ �������������
# q7   0.26975902 ������ � ����

# ����������:
# q15  0.48124584 ���������
# q14  0.48074326 ������� � ������ �����
# q12  0.34981015 ���������
# q3   0.33148142 ���������� ��������
# q17 -0.22889146 $$ > ������
# q13 -0.21286605 ��� � ��
# 
# �����:
# �����������: 14-11+3+7

axis2 = c(14, 11, 3, 7);
show_best(princomp(ud[, append(-axis2, -axis1)]))
show_best(princomp(cd[, append(-axis2, -axis1)]))
# q15  0.61515133 ���������
# q12  0.42238761 ���������
# q17 -0.26412764 $$ > ������
# q23  0.26153023 ���������
# q22  0.24496068 �������������� ���������
# q25 -0.24081303 ����������
# q5  -0.21745381 ������ ������ ��������
#�����: ������������ 15+12-17+23+22-25-5

axis3 = c(15, 12, 17, 23, 22, 25, 5)

show_best(princomp(ud[, append(append(-axis3, -axis2), -axis1)]))
show_best(princomp(cd[, append(append(-axis3, -axis2), -axis1)]))

# q10  0.59455030 ������� ������
# q13  0.50459348 ��� ����
# q20  0.49166264 ������ �������������
# q6  -0.29309711 �������� � �����������

axis4 = c(10,13, 20, 6)
# ���������� ��������


show_best(princomp(cd[, append(append(append(-axis3, -axis2), -axis1), -axis4)]))
axis5 = c(4, 1, 8, 16)
# ������������������

axis1=c(18, 24, 2, 9, 19)             # ����. ���� ����������� � ���������
axis2 = c(14, 11, 3, 7)               # �����������
axis3 = c(15, 12, 17, 23, 22, 25, 5)  # ������������� | ������������ � ������
axis4 = c(10,13, 20, 6)               # ���������� ��������
axis5 = c(4, 1, 8, 16)                # �������������������� ��
axis_names = c("�����������", "�����������", "�������������", "���-��������", "���������������", "����������� ��������")

m = mat.or.vec(25,6)
m[18,1]=1 / length(axis1)
m[24,1]= -1 / length(axis1)
m[2,1]=1 / length(axis1)
m[9,1]=  -1 / length(axis1)
m[19,1]=1 / length(axis1)
m[14,2] = 1 / length(axis2)
m[11,2] = -1 / length(axis2)
m[3,2] = 1 / length(axis2)
m[7,2] = 1 / length(axis2)
m[15,3] = 1 / length(axis3)
m[12,3] = 1 / length(axis3)
m[17,3] = -1 / length(axis3)
m[23,3] = 1 / length(axis3)
m[22,3] = 1 / length(axis3)
m[25,3] = -1 / length(axis3)
m[5,3] = -1 / length(axis3)
m[10,4] = -1 / length(axis4)
m[13,4] = -1 / length(axis4)
m[20,4] = -1 / length(axis4)
m[6,4] = 1 / length(axis4)
m[4,5] = 1 / length(axis5)
m[1,5] = 1 / length(axis5)
m[8,5] = 1 / length(axis5)
m[16,5] = 1 / length(axis5)
m[21,6] = 1
cd2 = as.matrix(cd) %*% m
ud2 = as.matrix(ud) %*% m

pop = rep(0, length(cd2[,1]))
for(i in 1:length(ud2[,1])){
  minD = 1000000;
  closestCand = -1;
  for(ic in 1:length(cd2[,1]))
  {
    d = sqrt(sum((ud2[i,] - cd2[ic,])^2))
    if (minD > d) {
      closestCand = ic
      minD = d
    }
  }
  pop[closestCand] = pop[closestCand] + 1
}
pop

plo = function(axis1, axis2){
  err = 1/30
  plot(cd2[order(debates[,2]),axis1]+rnorm(length(cd2))*err, cd2[order(debates[,2]),axis2]+rnorm(length(cd2))*err, pch=20, col=rgb(debates[,2]/max(debates[,2]), 0, 0), xlab=axis_names[axis1], ylab=axis_names[axis2]);
}


plo(5,6)
plo(1 ,4)
plo(2 ,4)
plo(1 ,2)
plo(1,3)
plo(1,5)

Id = 1:length(cd[,1])
Label = rnames;
Curia = curias
GovControl = cd2[,1]
Naz = cd2[,2]
Agress = cd2[,3]
Social = cd2[,4]
Decentr = cd2[,5]
Debates = debates[,2]
Compass = pop

# csv nodes
write.table(
  data.frame(Id, Label, Curia, GovControl, Naz, Agress, Social, Decentr, Compass, Debates),
  file="../data/nodes.csv",
  sep = ',',
  quote = FALSE,
  row.names = FALSE,
)