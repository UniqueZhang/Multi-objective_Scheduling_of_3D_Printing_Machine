function data_rec=save_data(data_rec,L,W,Xp1,Yp1,i)
%i------第i个矩形
%添加第i行 矩形数据矩阵
Xp3=Xp1+L;
Yp3=Yp1+W;%对角坐标足够表示一个矩形的信息,也方便使用
data_rec0=[i,Xp1,Yp1,Xp3,Yp3];
data_rec=[data_rec;data_rec0];%添加完毕