%% code segment: densità probabilità somma v.c. tra 1 e 2)
Ntry = 10000;
D =randi(3,Ntry,3);
histogram2(D(:,1),[D(:,1)+D(:,2)],'Normalization','Probability','FaceColor','flat');
title('Sum');
xlabel('D1');ylabel('D1+D2');zlabel('P');