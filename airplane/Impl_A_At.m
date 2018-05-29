function out = Impl_A_At(s,N_FFT,N_sig,N_Ima,mode)
% ����˵����������ʽ��ʵ����������A��A'�����ڶ�801ת̨���ݽ���ϡ��ָ�����
% Input:
%   s ���� �����ź� if mode == 1, out = A * s, elseif mode == 2, out = A' * s
%   N_FFT ���� ��������Ԫ�أ��ֱ�Ϊ��һ�͵ڶ�ά�ȵ�FFT����
%   N_sig ���� ��������Ԫ�أ��ֱ�Ϊ��һ(N_f)�͵ڶ�(N_fai)ά�Ȼز��źŵĵ���
%   N_Ima ���� ��������Ԫ�أ��ֱ�Ϊ��һ(x,��f��Ӧ)�͵ڶ�(y,��fai��Ӧ)ά�ȵ�ͼ�����
%   mode ���� 1���ز�����ģʽ�� 2������ģʽ
% Output��
%   out ���� ����ź� if mode == 1, out = A * s, elseif mode == 2, out = A' * s

% Author���߾���  Date��2017.12.11
I=eye(2);
if mode == 1                 % �ز�����ģʽ
    s=reshape(s,[N_Ima(1) N_Ima(2)]);   % ��s��Ϊ������ʽ����һά��N_x���ڶ�ά��N_y
    c_t=1;
    N_pad_pre=ceil((N_FFT(c_t)-N_Ima(c_t))/2);
    N_pad_post=N_FFT(c_t)-N_Ima(c_t)-N_pad_pre;
    s=padarray(s,N_pad_pre*I(c_t,:),0,'pre');
    s=padarray(s,N_pad_post*I(c_t,:),0,'post');
    s=fft(ifftshift(s,c_t),[],c_t)/sqrt(N_FFT(c_t));
    s=[s(end-N_sig(1)+ceil(N_sig(1)/2)+1:end,:);s(1:ceil(N_sig(1)/2),:)];
    c_t=2;
    N_pad_pre=ceil((N_FFT(c_t)-N_Ima(c_t))/2);
    N_pad_post=N_FFT(c_t)-N_Ima(c_t)-N_pad_pre;
    s=padarray(s,N_pad_pre*I(c_t,:),0,'pre');
    s=padarray(s,N_pad_post*I(c_t,:),0,'post');
    s=fft(ifftshift(s,c_t),[],c_t)/sqrt(N_FFT(c_t));
    s=[s(:,end-N_sig(2)+ceil(N_sig(2)/2)+1:end) s(:,1:ceil(N_sig(2)/2))];
elseif mode == 2             % ����ģʽ
    s=reshape(s,[N_sig(1) N_sig(2)]);   % ��s��Ϊ������ʽ����һά��N_f���ڶ�ά��N_fai
    c_t=1;
    N_pad_pre=ceil((N_FFT(c_t)-N_sig(c_t))/2);
    N_pad_post=N_FFT(c_t)-N_sig(c_t)-N_pad_pre;
    s=padarray(s,N_pad_pre*I(c_t,:),0,'pre');
    s=padarray(s,N_pad_post*I(c_t,:),0,'post');
    s=ifft(ifftshift(s,c_t),[],c_t)*sqrt(N_FFT(c_t));
    s=[s(end-N_Ima(1)+ceil(N_Ima(1)/2)+1:end,:);s(1:ceil(N_Ima(1)/2),:)];
    c_t=2;
    N_pad_pre=ceil((N_FFT(c_t)-N_sig(c_t))/2);
    N_pad_post=N_FFT(c_t)-N_sig(c_t)-N_pad_pre;
    s=padarray(s,N_pad_pre*I(c_t,:),0,'pre');
    s=padarray(s,N_pad_post*I(c_t,:),0,'post');
    s=ifft(ifftshift(s,c_t),[],c_t)*sqrt(N_FFT(c_t));
    s=[s(:,end-N_Ima(2)+ceil(N_Ima(2)/2)+1:end) s(:,1:ceil(N_Ima(2)/2))];
end
out=s(:);
end

