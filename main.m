
close all;
 

figure;
void('C:\Dowloads\studio_M2.wav',1);

figure;


void('C:\Dowloads\studio_F2.wav',2);

figure;


void('C:\Dowloads\phone_M2.wav',3);

 figure;


 
void('C:\Dowloads\phone_F2.wav',4);

%doc tin hieu
function void(tin , w)
[x,fs]= audioread(tin);
%tinh do dai tin hieu
%sound(x,fs);
leng_x= length(x);
t= leng_x./fs;
frame_time= 0.02; %10ms
frame_sample = round(fs * frame_time);%quy tron do dai frame
frame_num = floor(leng_x / frame_sample);%so frame da chia vs frame_time
s=[zeros(1,frame_num)];
s1=[zeros(1,frame_num)];


for i=1:frame_num
    begin = frame_sample*(i-1) +1;
    finish =  frame_sample*i;
    %tinh STE
    for m= begin: finish
      s(i)= s(i)+x(m).*x(m);
    end
    %tinh ZRC
     for m= begin: finish-1
     if(x(m).*x(m+1)<0)
         s1(i)=s1(i)+2;
     end
    end
end
 % Bieu dien STE cung do dai voi tin hieu am thanh
  STE = 0;
  
    for i = 1 : length(s)
        len = length(STE);
        STE(len : len + frame_sample) = s(i)/max(s);
       
    end
    % Bieu dien ZRC cung do dai voi tin hieu am thanh
  ZRC = 0;
   
    for i = 1 : length(s1)
        len = length(ZRC);
        ZRC(len : len + frame_sample) = s1(i)/max(s1);
    end
    %hieu so STE va ZRC
    H_SR=0;
   ms =0;
    for i= 1: length(STE)
        
       if((STE(i)>0.02)&& (ZRC(i)<0.4))
          H_SR(i)=1; 
        
       end
    end
     subplot(4,1,1);
     hold on
     title("STE");
     plot((1:leng_x)./fs,x);
       hold on
plot((1:length(STE))./fs,STE);

      xlabel('Time (s)');
       subplot(4,1,2);
        hold on
     title("ZCR");
     plot((1:leng_x)./fs,x);
      hold on
plot((1:length(ZRC))./fs,ZRC);
      xlabel('Time (s)');
     subplot(4,1,3);
     plot((1:leng_x)./fs,x);
      xlabel('Time (s)');
      if(w==1)
           hold on
                title("studio M2");
      end
      if(w==2)
           hold on
                title("studio F2");
      end
      if(w==3)
           hold on
                title("phone M2");
      end
      if(w==4)
           hold on
                title("phone F2");
      end
    for i= 1:length(H_SR)-1
        if((H_SR(i)+H_SR(i+1))==1&& H_SR(i)==0)
            
            hold on;
          xline(i./fs,'Color', 'b', 'LineWidth', 1);  
        end
        if((H_SR(i)+H_SR(i+1))==1&& H_SR(i)==1)
            hold on;
          xline(i./fs,'Color', 'b', 'LineWidth', 1);  
        end
    end

    hold on;
          xline(length(H_SR)./fs,'Color', 'b', 'LineWidth', 1);  
       subplot(4,1,4);
    plot((1:leng_x)./fs,x);
      xlabel('Time (s)');
           if(w==1)
               hold on
                title("studio M2(chuan)");
               msm= [0.45 0.48 0.77 0.79 0.88 0.92 1.32 1.37 1.53 1.59 1.93 ];
               for i=1:length(msm)
       
         hold on;
   xline(msm(i),'Color', 'r', 'LineWidth', 1);
    end
    
 
   end
           if(w==2)
                hold on
                title("studio F2(chuan)");
               msm=[0.77 1.25 1.27 1.35 1.41 1.76 1.83 1.98 2.06 2.37 ];%studio_f1
               for i=1:length(msm)
        
         hold on;
   xline(msm(i),'Color', 'r', 'LineWidth', 1);
    end
   
   
 
           end
           if(w==3)
                hold on
                title("phone M2(chuan)");
               msm=[0.53 1.05 1.12 1.24 1.31 1.46 1.68 1.97 2.06 2.12 2.17 2.30 2.43 2.50 2.52 ]; %phone_m1
               for i=1:length(msm)
        
         hold on;
   xline(msm(i),'Color', 'r', 'LineWidth', 1);
    end
   
   
  
           end
           if(w==4)
                hold on
                title("phone F2(chuan)");
              msm=[1.02 1.88 1.95 2.16 2.25 2.6 2.75 3.34 3.38 3.45 3.62 3.8 3.91 4 4.04 ];%phone_f1
               for i=1:length(msm)
        
         hold on;
   xline(msm(i),'Color', 'r', 'LineWidth', 1);
    end
   
  
 
           end
       
   
end

