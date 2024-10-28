
# I. Cài đặt và cấu hình Jenkins  
   ## 1. OS requirment :  
   - Redhat 9.4 or later  
   - RAM : 4GB  
   - CPU : 2 cores  
   ## 2.Cài đặt Jenkins  
   - SSH vào server sẽ cài đặt jenkins bằng user root. Sử dụng lệnh sau để tạo folder và tải  file cài đặt:  
        ```sh
        sudo mkdir /opt/Jenkins  
        cd /opt/Jenkins  
        sudo yum install git -y  
        git clone https://github.com/trungduongmewmew/Jenkins_Conjur.git  
        cd Jenkins_Conjur/Install_Jenkins/  
        chmod +x *.sh  
        ```   

   - Chỉnh sửa file 01_Install_Jenkins.sh  thành IP tương ứng của server cài Jenkins, say đó chạy file 01_Install_Jenkins.sh. Sau khi hoàn tất , copy chuỗi cuối cùng để làm passcode đăng nhập vào Jenkins  
   <img width="831" alt="1" src="https://github.com/user-attachments/assets/653ee5a0-5984-4e42-b130-6077f6c34a59"> 
    

     
    


