%Generate the 20 random sybol low-rate data message m[k]
mk=(-1).^(rand(1,20)>0.5);
%Up-sampled m[k] to produce d[k]
dk_=repmat(mk,[5 1]);
dk=dk_(:)';
%Generate users binary-valued random sequence s1k and s2k, also make sure
%they are not identical
s1k=(-1).^(rand(1,5)>0.5);
s2k=(-1).^(rand(1,5)>0.5);
while isequal(s1k,s2k) 
    s2k=(-1).^(rand(1,5)>0.5);
end

%Generate Periodic spreading sequnce S1[k] for user 1 based on s1[k]
S1=repmat(s1k,[1,20]);
%Product modulated sequence p[k] using point-by-point multiplicative modulation for intended user 1
pk=dk.*S1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 1:

%Define the digital matched filter for user 1
h1m=fliplr(s1k);
%Product the output of the matched filter 
y1=conv(h1m,pk);
%Choose a threshold
threshold1=4;
%After choosing the threshold, generate the final output of singals
y1_filter=(y1>threshold1)-(y1<-threshold1);
y1_output=y1_filter(y1_filter~=0);
%Compute the Error rate
n=length(mk);
m1=length(y1_output);
k1=min(n,m1);
take1=mk(1:k1)-y1_output(1:k1);
ERT1=length(take1(take1~=0))/n;

%display 
figure(1);
subplot(3,2,1);
stem(dk);xlabel('k');ylabel('d[k]');title('d[k]');
subplot(3,2,2)
stem(s1k);xlabel('k');ylabel('s1[k]');title('s1[k]');
subplot(3,2,3);
stem(S1,'.','MarkerSize',15);xlabel('k');ylabel('S1[k]');title('S1[k]');
subplot(3,2,4);
stem(y1);xlabel('k');ylabel('y1[k]');title('y1[k]');
subplot(3,2,5);
stem(mk);xlabel('k');ylabel('m[k]');title('m[k]');
subplot(3,2,6);
stem(y1_output);xlabel('k');ylabel('y1 output');title('Signal after threshold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 2:
%Define the digital matched filter for user 2
h2m=fliplr(s2k);
%Product the output of the matched filter
y2=conv(h2m,pk);
%Using different threshold
threshold2=2.5;
%Generate the final output
y2_filter=(y2>threshold2)-(y2<-threshold2);
y2_output=y2_filter(y2_filter~=0);
%Compute the Error rate
m2=length(y2_output);
k2=min(n,m2);
take2=mk(1:k2)-y2_output(1:k2);
ERT2=length(take2(take2~=0))/n;

%display 
figure(2);
subplot(3,2,1);
stem(dk);xlabel('k');ylabel('d[k]');title('d[k]');
subplot(3,2,2)
stem(s2k);xlabel('k');ylabel('s1[k]');title('s2[k]');
subplot(3,2,3);
stem(S1,'.','MarkerSize',15);xlabel('k');ylabel('S1[k]');title('S1[k]');
subplot(3,2,4);
stem(y2);xlabel('k');ylabel('y1[k]');title('y2[k]');
subplot(3,2,5);
stem(mk);xlabel('k');ylabel('m[k]');title('m[k]');
subplot(3,2,6);
stem(y2_output);xlabel('k');ylabel('y2 output');title('Signal after threshold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Question 3:
%Add normal noise to d[k] with SNR=0dB and creat d[k]_noise
dk_noise=awgn(dk,0);
pk_noise=dk_noise.*S1;
%Product the output of the matched filter 
y1_noise=conv(h1m,pk_noise);
%Choose a different threshold
threshold3=4.5;
%After choosing the threshold, generate the final output of singals
y1_filter_noise=(y1_noise>threshold3)-(y1_noise<-threshold3);
y1_output_noise=y1_filter_noise(y1_filter_noise~=0);
%Compute the Error rate
m3=length(y1_output_noise);
k3=min(n,m3);
take3=mk(1:k3)-y1_output_noise(1:k3);
ERT3=length(take3(take3~=0))/n;

%display 
figure(3);
subplot(3,2,1);
stem(dk_noise);xlabel('k');ylabel('d[k] noise');title('d[k] after adding noise');
subplot(3,2,2)
stem(s1k);xlabel('k');ylabel('s1[k]');title('s1[k]');
subplot(3,2,3);
stem(S1,'.','MarkerSize',15);xlabel('k');ylabel('S1[k]');title('S1[k]');
subplot(3,2,4);
stem(y1_noise);xlabel('k');ylabel('y1[k] noise');title('y1[k] after adding noise');
subplot(3,2,5);
stem(mk);xlabel('k');ylabel('m[k]');title('m[k]');
subplot(3,2,6);
stem(y1_output_noise);xlabel('k');ylabel('y1 output noise');title('Signal with noise after threshold');

