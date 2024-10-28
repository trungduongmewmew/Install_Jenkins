I. Cài đặt và cấu hình Jenkins  
    1. OS requirment :  
    Redhat 9.4 or later  
    RAM : 4GB  
    CPU : 2 cores  
    2.Cài đặt Jenkins  
        -  SSH vào server sẽ cài đặt jenkins bằng user root. Sử dụng lệnh sau để tạo folder và tải  file cài đặt:  
            
            sudo mkdir /opt/Jenkins  
            cd /opt/Jenkins  
            sudo yum install git -y  
            git clone https://github.com/trungduongmewmew/Jenkins_Conjur.git  
            cd Jenkins_Conjur/Install_Jenkins/  
            chmod +x *.sh  
            
        -  Chỉnh sửa file 01_Install_Jenkins.sh  thành IP tương ứng của server cài Jenkins, say đó chạy file 01_Install_Jenkins.sh. Sau khi hoàn tất , copy chuỗi cuối cùng để làm passcode đăng nhập vào Jenkins  
        <img width="831" alt="1" src="https://github.com/user-attachments/assets/653ee5a0-5984-4e42-b130-6077f6c34a59">  
        -  Mở trình duyệt web , và truy cập địa chỉ sau : http://YourIP:8080  
        -  Nhập passcode đã lưu ở trên để login vào account admin  
        <img width="922" alt="2" src="https://github.com/user-attachments/assets/7978b795-d942-490b-b9c8-a1bdaaddb742">  
        - Chọn Install sugggested plugin để Jenkins tự động cài đặt các plugin cần thiết  
        - Tạo user để login vào Jenkins  
        <img width="938" alt="3" src="https://github.com/user-attachments/assets/d1fb0c35-b72d-4c8e-ba5b-6a0443fb97ea">  
        - Tạo url instance, sau đó login vào portal bằng user vừa tạo ở trên.  
        <img width="956" alt="4" src="https://github.com/user-attachments/assets/931611c8-f058-4641-9b9f-785538070942">  


