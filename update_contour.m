function [contour_x,contour_y]=update_contour(rec_p)
%% 实现轮廓线的更新，以更新X方向上轮廓为例。首先降序排列矩形上边数据，接着依次摆下去
%rec_p转换成边数据集合line_x
% rec_p的格式[i,Xp1,Yp1,Xp3,Yp3];
line_x=rec_p;
line_y=rec_p;
Ls=rec_p(1,4);
Ws=rec_p(2,5);
line_x(1:2,:)=[];%删除前两行表示的坐标轴
line_y(1:2,:)=[];
%这里只是考虑到了rec_p存放有矩形而不只是两坐标轴

% line_x(:,1)=[];%删除第一列：矩形序号
% line_x(:,2)=[];%删除了左下角坐标的纵坐标，此时line_x=[Xp1，Xp3，Yp3]
% line_y(:,1)=[];%删除第一列：矩形序号
% line_y(:,1)=[];
% yy=line_y(:,2);
% line_y(:,2)=[];
% line_y=[line_y yy];%删除了左下角坐标的横坐标，此时line_y=[Yp1，Yp3，Xp3]

line_x(:,[1,3])=[];%删除了左下角坐标的纵坐标，此时line_x=[Xp1，Xp3，Yp3]
yy=line_y(:,4);
line_y(:,[1,2,4])=[];
line_y=[line_y yy];%删除了左下角坐标的横坐标，此时line_y=[Yp1，Yp3，Xp3]

line_x=sortrows(line_x,-3);%降序排序
line_y=sortrows(line_y,-3);%降序排序


%% ---------contour_x----------------

n=size(line_x,1);
if n~=0%赋值首行轮廓线集合
    contour_x=line_x(1,:);
else
    contour_x=[0,Ls,0];
end
m=size(contour_x,1);
axis_x=[0,Ls,0];
line_x=[line_x;axis_x];
n=n+1;
i=2;
k=1;
if n > 1
    while i<=n
        lineX=line_x(i,:);
        while k<=m %遍历已添加的轮廓线
            %开始进行重叠的判断与截去
            if lineX(1)<contour_x(k,1) && lineX(2)>contour_x(k,1) && lineX(2)<=contour_x(k,2) ==1
                lineX(2)=contour_x(k,1);
                
            elseif lineX(1)<contour_x(k,1) && lineX(2)>contour_x(k,2) ==1
                lineX_more=lineX;
                lineX_more(1)=contour_x(k,2);
                lineX(2)=contour_x(k,1);
                a=line_x;
                b=line_x;
                a(i:n,:)=[];
                b(1:i,:)=[];
                line_x=[a;lineX];%被裂开了一段，裂出来较后一线段添加进line_x中间
                line_x=[line_x;lineX_more];
                line_x=[line_x;b];
                n=n+1;%多加了一行待判断线段就要多一次判断
                
            elseif lineX(1)<contour_x(k,2) && lineX(1)>=contour_x(k,1) && lineX(2)<=contour_x(k,2) ==1
                lineX=[0,0,0];
                
                
            elseif lineX(1)>=contour_x(k,1) && lineX(1)<contour_x(k,2) && lineX(2)>contour_x(k,2) ==1
                lineX(1)=contour_x(k,2);
                
                
            end
            k=k+1;
            
        end
        
        contour_x=[contour_x;lineX];
        m=size(contour_x,1);
        
        i=i+1;
        k=1;
    end
end
contour_x=sortrows(contour_x,1);%升序排序
j=size(contour_x,1);%删除完全重叠的行
r=1;
while r<=j
    if contour_x(r,2)==0
        contour_x(r,:)=[];
        r=r-1;
        j=j-1;
    end
    r=r+1;
end
    

%% 同理--------------contour_y--------

n1=size(line_y,1);
if n1~=0%赋值首行轮廓线集合
    contour_y=line_y(1,:);
else
    contour_y=[0,Ws,0];
end
m1=size(contour_y,1);
axis_y=[0,Ws,0];
line_y=[line_y;axis_y];
n1=n1+1;
i1=2;
k1=1;
if n1 > 1
    while i1<=n1
        lineY=line_y(i1,:);
        while k1<=m1 %遍历已添加的轮廓线
            %开始进行重叠的判断与截去
            if lineY(1)<contour_y(k1,1) && lineY(2)>contour_y(k1,1) && lineY(2)<=contour_y(k1,2) ==1
                lineY(2)=contour_y(k1,1);
                
            elseif lineY(1)<contour_y(k1,1) && lineY(2)>contour_y(k1,2) ==1
                lineX_more=lineY;
                lineX_more(1)=contour_y(k1,2);
                lineY(2)=contour_y(k1,1);
                a=line_y;
                b=line_y;
                a(i1:n1,:)=[];
                b(1:i1,:)=[];
                line_y=[a;lineY];%被裂开了一段，裂出来较后一线段添加进line_x中间
                line_y=[line_y;lineX_more];
                line_y=[line_y;b];
                n1=n1+1;%多加了一行待判断线段就要多一次判断
                
            elseif lineY(1)<contour_y(k1,2) && lineY(1)>=contour_y(k1,1) && lineY(2)<=contour_y(k1,2) ==1
                lineY=[0,0,0];
                
                
            elseif lineY(1)>=contour_y(k1,1) && lineY(1)<contour_y(k1,2) && lineY(2)>contour_y(k1,2) ==1
                lineY(1)=contour_y(k1,2);
                
            
               
            end
            k1=k1+1;
            
        end
       
          contour_y=[contour_y;lineY];
          m1=size(contour_y,1);
        
        i1=i1+1;
        k1=1;
    end
end
contour_y=sortrows(contour_y,1);%升序排序
j1=size(contour_y,1);%删除完全重叠的行
r1=1;
while r1<=j1
    if contour_y(r1,2)==0
        contour_y(r1,:)=[];
        r1=r1-1;
        j1=j1-1;
    end
    r1=r1+1;
end
end

    
