% M�todo de Elimina��o de Gauss com Pivoteamento por Coluna 

clear all
clc 

% Entrada de dados do Sistema Linear

A = zeros(4);
b = [77/12; 37/10; 53/20; 218/105];
for j=1:4
    i = j -1;
    A(j,1) = 1/(i+1);
    A(j,2) = 1/(i+2);
    A(j,3) = 1/(i+3);
    A(j,4) = 1/(i+4);
end

b=reshape(b,length(b),1); %transforma b em coluna 

[m,n]=size(A);  %Aquisi��o da ordem de A por tamanho

% Verifica��o do Sistema
    
    %Matriz A
    if m~=n
        disp('N�mero de Equa��es diferente do N�mero de Inc�gnitas')
        return
    end
    
    %Vetor b
    if [m,1]~=size(b)
        disp('N�mero de igualdades n�o corresponde ao n�mero de linhas de A')
        return
    end

    if det(A)==0
        disp('Matriz Singular ou possui Equa��es Linearmente Dependentes')
        return
    end
    
    index=linspace(1,m,m);%cria um vetor com m termos, onde o �ltimo termo � m e o incremento � 1
    
% Triangulariza��o

    % 1� Pivoteamento
    for cont=1:m-1
        
        [Y,I]=max(A(cont,cont:m));

        I=I+(cont-1); %Corre��o do numero de colunas quando cont>1 em cont:m 
        
        aux=A(:,cont);
        A(:,cont)=A(:,I);
        A(:,I)=aux;
      
        aux=index(cont); % mudan�a de posi�ao do vetor index
        index(cont)=index(I);
        index(I)=aux;

%      "AUX = A
%       A = B
%       B = AUX"
        
  
    % 2� Anula��o dos Valores abaixo do Pivo
        for cont2=cont+1:m
        
            k=-A(cont2,cont)/Y;
            A(cont2,cont:m)=A(cont2,cont:m)+k*A(cont,cont:m); 
            b(cont2)=b(cont2)+k*b(cont);
        
        end
    end
    
 % Acabou  todo o pivoteamento

% Solve do sistema

    x(m)=b(m)/A(m,m);    
        
        while cont>=1 % contador regressivo
            aux=sum(A(cont,cont+1:m).*x(cont+1:m));
                     
    
            x(cont)=(b(cont)-aux)/A(cont,cont);           
            cont=cont-1;
            
            if cont<1
                break
            end
                     
        end

    %   Realojamento do Vetor de Inc�gnitas nas Posi��es Corretas:

for cont=1:m
    
    for i=1:m
        
        if index(i)==index(cont)
            
            aux=x(index(i));
            x(index(i))=x(cont);
            x(cont)=aux;
       
            aux=index(index(i));% conserta-se o index pra n�o repetir a opera��o de troca de valor em x
            index(index(i))=index(cont);
            index(cont)=aux;
            
        end
    
    end
    
end

disp('Vetor de Inc�gnitas')
disp(x)
        