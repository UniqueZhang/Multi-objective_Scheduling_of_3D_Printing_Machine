function data_rec=save_data(data_rec,L,W,Xp1,Yp1,i)
%i------��i������
%��ӵ�i�� �������ݾ���
Xp3=Xp1+L;
Yp3=Yp1+W;%�Խ������㹻��ʾһ�����ε���Ϣ,Ҳ����ʹ��
data_rec0=[i,Xp1,Yp1,Xp3,Yp3];
data_rec=[data_rec;data_rec0];%������