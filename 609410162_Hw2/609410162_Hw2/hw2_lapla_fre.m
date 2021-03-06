clc;
clear;
tic;

img1 = imread("./HW2_test_image/HW2_test_image/blurry_moon.tif");
img2 = imread("./HW2_test_image/HW2_test_image/skeleton_orig.bmp");

PQ1=paddedsize(size(img1),1);
PQ2=paddedsize(size(img2),1);

%儲存原本的image
I1 = img1;  
I2 = img2;

img1 = padarray(img1,[1,1]);
img1 = double(img1);
img2 = padarray(img2,[1,1]);
img2 = double(img2);

%進行fourier transform
fft_img1 = fft2(double(img1),PQ1(1),PQ1(2));
fft_img2 = fft2(double(img2),PQ2(1),PQ2(2));

%設定filter
% H = fspecial('laplacian');
H = [0 1 0;1 -4 1;0 1 0];

%把filter也做傅立葉轉換
H1=fft2(double(H),PQ1(1),PQ1(2));
H2=fft2(double(H),PQ2(1),PQ2(2));

%convolution
img1_t = fft_img1.*(H1+1);
img2_t = fft_img2.*(H2+1);

%inverse fourier transform
g1 = real(ifft2(img1_t));
g2 = real(ifft2(img2_t));

sharp1 = uint8(g1);
sharp2 = uint8(g2);

%畫圖、顯示圖片、儲存圖片

subplot(2,2,1);imshow(I1);title('Original');
set(gca,'xtick',[],'ytick',[])
subplot(2,2,2);imshow(sharp1);title('transformed');
set(gca,'xtick',[],'ytick',[])

subplot(2,2,3);imshow(I2);title('Original');
set(gca,'xtick',[],'ytick',[])
subplot(2,2,4);imshow(sharp2);title('transformed');
set(gca,'xtick',[],'ytick',[])

saveas(gcf,'lapla_frequency','bmp');

toc;