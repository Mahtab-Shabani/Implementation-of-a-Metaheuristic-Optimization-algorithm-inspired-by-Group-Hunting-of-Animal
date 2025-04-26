clc
clear all
close all
%% 

num_hunter=100; 
dim=2;

alpha=0.1; 
betta=1;
epsilon=0.01;
MML=0.2;
HGCR=0.3;
Ramin=1e-7;
Ramax=1e-1;

lb=[-5,-5];
ub=[10,10];
max_iter=100;


x=lb(1):0.1:ub(1);
y=lb(2):0.1:ub(2);
[X,Y]=meshgrid(x,y);

%function1
%Z=(X-Y).^2+((X+Y-10)/3).^2;

%function2
%Z=(X.^2+Y.^2);

%function3
Z=100*(X.^2-Y)+(X-1).^2;


figure;surf(X,Y,Z);
%% 

for ii=1:10
    %step2
    EN=0;
    f_hunter=zeros(1,num_hunter);
    newf_hunter=zeros(1,num_hunter);
    newpos_hunter=zeros(num_hunter,dim);
    pos_hunter=rand(num_hunter,dim).*repmat((ub-lb),num_hunter,1)+repmat(lb,num_hunter,1);

    for j=1:num_hunter
        f_hunter(j)=feval(@objj,pos_hunter(j,:));
    end

    [f_leaderHunter,leaderHunterIdx]=min(f_hunter);
    pos_leaderHunter=pos_hunter(leaderHunterIdx,:);

    tic;


    for i=1:max_iter        
        %%step3
        for j=1:num_hunter
            newpos_hunter(j,:)=pos_hunter(j,:)+rand(1,1)*MML*(pos_leaderHunter-pos_hunter(j,:));        
            newf_hunter(j)=feval(@objj,newpos_hunter(j,:));
        end
        temp_idx=newf_hunter<f_hunter;
        pos_hunter(temp_idx,:)=newpos_hunter(temp_idx,:);
        f_hunter(temp_idx)=newf_hunter(temp_idx);

        %step4
        for j=1:num_hunter
            if(j~=leaderHunterIdx)
                rr=rand(1,1);
                if(rr<=HGCR)
                    for kk=1:dim
                        ps=randi([1,num_hunter],1,1);
                        pos_hunter(j,kk)=pos_hunter(ps,kk);
                    end
                else
                    for kk=1:dim
                        Ra= Ramin*(ub(kk)-lb(kk))*exp((log(Ramin/Ramax)*i)/max_iter);
                        re=rand(1,1);
                        if(re<0.5)
                            pos_hunter(j,kk)=pos_hunter(j,kk)+Ra;
                        else
                            pos_hunter(j,kk)=pos_hunter(j,kk)-Ra;
                        end
                    end
                end

            end
        end

        for j=1:num_hunter        
            f_hunter(j)=feval(@objj,pos_hunter(j,:));
        end

        [f_leaderHunter,leaderHunterIdx]=min(f_hunter);
        pos_leaderHunter=pos_hunter(leaderHunterIdx,:);
        
        [f_WorseHunter,WorseHunterIdx]=max(f_hunter);

        %step 5:
        dff=abs(f_WorseHunter-f_leaderHunter);
        if(dff<epsilon)
            EN=EN+1;
            for j=1:num_hunter        
                if(j~=leaderHunterIdx)
                    for kk=1:dim
                        re=rand(1,1);
                        if(re<=0.5)
                            pos_hunter(j,kk)=pos_hunter(leaderHunterIdx,kk)+rand(1,1)*(ub(kk)-lb(kk))*alpha*exp(-betta*EN);
                        else
                            pos_hunter(j,kk)=pos_hunter(leaderHunterIdx,kk)-rand(1,1)*(ub(kk)-lb(kk))*alpha*exp(-betta*EN);
                        end
                    end
                end
            end

            for j=1:num_hunter        
                f_hunter(j)=feval(@objj,pos_hunter(j,:));
            end
            [f_leaderHunter,leaderHunterIdx]=min(f_hunter);
            pos_leaderHunter=pos_hunter(leaderHunterIdx,:);
        end    

        final_f(i,ii)=f_leaderHunter;
        final_pos(i,ii,:)=pos_leaderHunter;
    end
end
toc

hold on;
plot3(final_pos(max_iter,10,1),final_pos(max_iter,10,2),final_f(max_iter,10),'*r','Markersize',20);

disp(['EN number: ',num2str(EN)]);

figure;
for i=1:10
    hold on;plot3(repmat(i,max_iter,1),1:max_iter,final_f(:,i),'--.r');
end
disp(['Avg of optimal point: ',num2str(mean(final_f(max_iter,:)))]);
disp(['the best of optimal point: ',num2str(min(final_f(max_iter,:)))]);
disp(['the worst of optimal point: ',num2str(max(final_f(max_iter,:)))]);

