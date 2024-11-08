-- Tạo cơ sở dữ liệu Hikary Restaurant
CREATE DATABASE [HikariSuShi];
GO

-- Sử dụng cơ sở dữ liệu Hikary Restaurant
USE [HikariSuShi];
GO

-- Tạo bảng Roles
CREATE TABLE Roles (
    role_id INT IDENTITY(1,1) NOT NULL,
    role_name NVARCHAR(50) NULL,
    CONSTRAINT PK_Roles PRIMARY KEY CLUSTERED (role_id)
);
GO

-- Tạo bảng Users với khóa ngoại đến bảng Roles
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) NOT NULL,
    user_name NVARCHAR(50) NULL,
    email NVARCHAR(50) NOT NULL,
    password NVARCHAR(50) NOT NULL,
    address NVARCHAR(50) NULL,
    gender BIT NULL,
    phone NCHAR(11) NULL,
    role_id INT NULL,
    CONSTRAINT PK_Users PRIMARY KEY CLUSTERED (user_id),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
GO
CREATE PROCEDURE RegisterUser
    @user_name NVARCHAR(50),
    @email NVARCHAR(50),
    @password NVARCHAR(50),
    @address NVARCHAR(50),
    @gender BIT,
    @phone NCHAR(11)
AS
BEGIN
    INSERT INTO Users (user_name, email, password, address, gender, phone, role_id)
    VALUES (@user_name, @email, @password, @address, @gender, @phone, 1);
END;
GO


-- Tạo bảng Category
CREATE TABLE Category (
    category_id INT IDENTITY(1,1) NOT NULL,
    category_name NVARCHAR(50) NULL,
    CONSTRAINT PK_Category PRIMARY KEY CLUSTERED (category_id)
);
GO

-- Tạo bảng Product với khóa ngoại đến bảng Category
CREATE TABLE Product (
    product_id INT IDENTITY(1,1) NOT NULL,
    product_name NVARCHAR(50) COLLATE Vietnamese_CI_AS NULL,
    price FLOAT NULL,
    category_id INT NULL,
    img NVARCHAR(MAX) NULL, -- Sử dụng NVARCHAR(MAX) thay vì NTEXT
    description NVARCHAR(500) COLLATE Vietnamese_CI_AS NULL,
    releaseDate DATE NULL,
    CONSTRAINT PK_Product PRIMARY KEY CLUSTERED (product_id),
    CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) REFERENCES Category(category_id)
);


GO
ALTER TABLE Product
ADD rating FLOAT NULL,
    purchase_count INT NULL;
	
go

-- Tạo bảng Order với khóa ngoại đến bảng Users
CREATE TABLE [Order] (
    order_id INT IDENTITY(1,1) NOT NULL,
    user_id INT NULL,
    order_date DATE NULL,
    total FLOAT NULL,
    notes NVARCHAR(200) NULL,
    CONSTRAINT PK_Order PRIMARY KEY CLUSTERED (order_id),
    CONSTRAINT FK_Order_Users FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO
ALTER TABLE [Order]
ADD 
    user_name NVARCHAR(100) NULL,       
    phone_number NVARCHAR(20) NULL,      
    email NVARCHAR(100) NULL,            
    address NVARCHAR(200) NULL,          
    sub_total FLOAT NULL,                
    order_status NVARCHAR(50) NULL       
;
Go

-- Tạo bảng OrderDetail với khóa ngoại đến bảng Order và Product
CREATE TABLE OrderDetail (
    detail_id INT IDENTITY(1,1) NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price FLOAT NULL,
    quantity INT NULL,
    CONSTRAINT PK_OrderDetail PRIMARY KEY CLUSTERED (detail_id),
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (order_id) REFERENCES [Order](order_id),
    CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
GO

-- Thêm một số dữ liệu mẫu vào bảng Roles
INSERT INTO Roles (role_name) VALUES ('Admin');
INSERT INTO Roles (role_name) VALUES ('Staff');
INSERT INTO Roles (role_name) VALUES ('Customer');

GO
-- Tạo bảng UserCart
CREATE TABLE UserCart (
    userId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (userId, productId),
    FOREIGN KEY (userId) REFERENCES Users(user_id) ON DELETE CASCADE, -- Xóa giỏ hàng khi xóa người dùng
    FOREIGN KEY (productId) REFERENCES Product(product_id) ON DELETE CASCADE -- Xóa sản phẩm khi xóa sản phẩm
);
GO

go

-- Thêm vào bảng Category
INSERT INTO Category (category_name) 
VALUES 
('Sushi Cake'),
('Sashimi'),
('Sushi'),
('Salad'),
('Maki'),
('Tempura');
GO
-- Thêm vào bảng Product
-- Insert các sản phẩm vào bảng Product, có liên kết với bảng Category

-- Sashimi
INSERT INTO Product (product_name, price, category_id, img, description, rating, purchase_count, releaseDate) 
VALUES 
('AKAGAI SASHIMI', 179000, 2, 'images/Sashimi/akagai-1-300x300.jpg', N'Sashimi từ akagai tươi ngon, tuyệt vời cho sức khỏe.', 4.5, 25, '2023-05-10'),
('CHUBUNE SASHIMI', 1089000, 2, 'images/Sashimi/Artboard-19-copy-25@4x-100-300x300.jpg', N'Chubune sashimi mềm mại, làm từ cá tươi.', 4.7, 40, '2023-02-15'),
('CHUTORO SASHIMI', 819000, 2, 'images/Sashimi/Artboard-19-copy-26@4x-100-300x300.jpg', N'Chutoro sashimi đậm đà hương vị biển.', 4.8, 30, '2023-08-22'),
('DELUXE SASHIMI 1', 809000, 2, 'images/Sashimi/Artboard-19-copy-29@4x-100-300x300.jpg', N'Hỗn hợp sashimi cao cấp, thích hợp cho bữa tiệc.', 4.9, 20, '2023-03-30'),
('DELUXE SASHIMI 2', 859000, 2, 'images/Sashimi/Artboard-19-copy-31@4x-100-300x300.jpg', N'Sashimi deluxe với các loại cá đặc biệt.', 4.6, 15, '2023-09-15'),
('GOTEN SASHIMI', 399000, 2, 'images/Sashimi/Artboard-19-copy-33@4x-100-300x300.jpg', N'Goten sashimi tươi mát, ăn kèm với nước tương.', 4.4, 35, '2023-07-12'),
('HOKKIGAI SASHIMI', 149000, 2, 'images/Sashimi/Artboard-19-copy-34@4x-100-300x300.jpg', N'Hokkigai sashimi giòn rụm, thơm ngon.', 4.3, 50, '2023-01-25'),
('HON MAGURO OTORO', 1149000, 2, 'images/Sashimi/Artboard-19-copy-35@4x-100-300x300.jpg', N'Hon maguro otoro là món ăn tuyệt vời của Nhật.', 5.0, 10, '2023-06-19'),
('HOTATE SASHIMI', 169000, 2, 'images/Sashimi/Artboard-19-copy-36@4x-100-300x300.jpg', N'Hotate sashimi mềm mịn, hương vị thanh tao.', 4.6, 20, '2023-04-05'),
('IKA SASHIMI', 169000, 2, 'images/Sashimi/Artboard-19-copy-38@4x-100-300x300.jpg', N'Sashimi ika tươi ngon, đầy hấp dẫn.', 4.2, 28, '2023-10-01'),
('IKURA SASHIMI', 239000, 2, 'images/Sashimi/Artboard-19-copy-39@4x-100-300x300.jpg', N'Ikura sashimi với trứng cá hồi béo ngậy.', 4.7, 12, '2023-08-03'),
('KAKI SASHIMI', 109000, 2, 'images/Sashimi/Artboard-19-copy-40@4x-100-300x300.jpg', N'Kaki sashimi tươi sống, tốt cho sức khỏe.', 4.5, 18, '2023-09-20'),
('KANPACHI SASHIMI', 419000, 2, 'images/Sashimi/Artboard-19-copy-41@4x-100-300x300.jpg', N'Kanpachi sashimi nổi tiếng với vị ngọt.', 4.8, 23, '2023-05-22'),
('KOBUNE SASHIMI', 799000, 2, 'images/Sashimi/Artboard-19-copy-43@4x-100-300x300.jpg', N'Kobune sashimi đầy màu sắc, hấp dẫn.', 4.9, 14, '2023-06-28'),
('KOMOCHI NISHIN SASHIMI', 159000, 2, 'images/Sashimi/Artboard-19-copy-42@4x-100-300x300.jpg', N'Komoichi nishin sashimi thơm ngon, đậm đà.', 4.4, 27, '2023-02-11'),
('KOMOCHI YARIIKA SASHIMI', 269000, 2, 'images/Sashimi/Artboard-19-copy-44@4x-100-300x300.jpg', N'Komoichi yariika sashimi tươi mát.', 4.3, 36, '2023-07-17'),
('KUE SASHIMI', 139000, 2, 'images/Sashimi/Artboard-19-copy-45@4x-100-300x300.jpg', N'Kue sashimi dễ ăn, ngon miệng.', 4.1, 22, '2023-03-05'),
('MAGURO AKAMI SASHIMI', 499000, 2, 'images/Sashimi/Artboard-19-copy-46@4x-100-300x300.jpg', N'Maguro akami sashimi thượng hạng, không thể bỏ qua.', 5.0, 8, '2023-01-30'),
('MAGURO SASHIMI', 149000, 2, 'images/Sashimi/Artboard-19-copy-47@4x-100-300x300.jpg', N'Maguro sashimi tươi ngon, hương vị đích thực.', 4.6, 19, '2023-11-12'),
('OBUNE SASHIMI', 1599000, 2, 'images/Sashimi/Artboard-19-copy-50@4x-100-300x300.jpg', N'Obune sashimi là lựa chọn tuyệt vời cho thực khách sành ăn.', 4.9, 11, '2023-12-02'),
('SAKE SASHIMI', 159000, 2, 'images/Sashimi/Capture-6-300x300.png', N'Sake sashimi mềm mịn, thích hợp cho mọi bữa ăn.', 4.5, 33, '2023-04-15');


-- Sushi
INSERT INTO Product (product_name, price, category_id, img, description, rating, purchase_count, releaseDate) 
VALUES 
('AKAGAI SUSHI', 89000, 3, 'images/Sushi/Artboard-19-copy-51@4x-100-300x300.jpg', N'Akagai sushi là món ăn tinh tế, mang đậm hương vị biển cả. Những miếng sushi được chế biến từ sò Akagai tươi ngon, không chỉ có vị ngọt đặc trưng mà còn giữ được độ giòn sần sật hấp dẫn. Đây là lựa chọn hoàn hảo cho những ai yêu thích hải sản tươi sống.', 4.5, 25, '2023-03-22'),
('CHUSUSHI MORIAWASE', 1079000, 3, 'images/Sushi/Artboard-19-copy-52@4x-100-300x300.jpg', N'Moriawase là một bộ sưu tập sushi phong phú, kết hợp nhiều loại sushi thượng hạng từ hải sản tươi ngon. Được chế biến tinh xảo, món ăn này phù hợp cho những buổi tiệc lớn, mang đến trải nghiệm ẩm thực đầy màu sắc và hương vị.', 4.8, 40, '2023-05-14'),
('COMBO SASHIMI & SUSHI', 549000, 3, 'images/Sushi/Artboard-19-copy-53@4x-100-300x300.jpg', N'Combo sashimi và sushi mang đến sự kết hợp hoàn hảo giữa hai phong cách ẩm thực đặc trưng của Nhật Bản. Từ những miếng sashimi tươi rói đến sushi thơm ngon, đây là lựa chọn không thể bỏ qua cho những ai yêu thích sự đa dạng.', 4.6, 30, '2023-07-19'),
('DELUXE A', 659000, 3, 'images/Sushi/Artboard-19-copy-54@4x-100-300x300.jpg',	N'Sushi Deluxe A là sự kết hợp của nhiều loại hải sản tươi ngon, từ cá ngừ, cá hồi cho đến tôm. Mỗi miếng sushi đều được chế biến tỉ mỉ, giữ nguyên độ tươi ngọt tự nhiên của nguyên liệu, mang lại trải nghiệm ẩm thực tinh tế và đẳng cấp.', 4.9, 20, '2023-04-10'),
('DELUXE B', 349000, 3, 'images/Sushi/Artboard-19-copy-55@4x-100-300x300.jpg', N'Sushi Deluxe B là sự kết hợp đa dạng giữa các loại hải sản tươi sống và cơm sushi mềm dẻo. Món ăn này không chỉ làm hài lòng thị giác mà còn kích thích vị giác, tạo nên bữa tiệc sushi tuyệt vời cho mọi thực khách.', 4.7, 15, '2023-09-25'),
('EBI FURAI SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-56@4x-100-300x300.jpg', N'Ebi furai sushi là sự kết hợp hoàn hảo giữa tôm chiên giòn và cơm sushi dẻo thơm. Lớp vỏ giòn rụm của tôm hòa quyện cùng vị béo ngậy của cơm tạo nên món ăn vừa thơm ngon vừa độc đáo, hấp dẫn.', 4.3, 35, '2023-08-18'),
('EBI SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-57@4x-100-300x300.jpg', N'Ebi sushi với tôm tươi sống, mang lại hương vị ngọt thanh và dễ ăn. Đây là món ăn được ưa chuộng nhờ sự đơn giản nhưng không kém phần ngon miệng, phù hợp với mọi lứa tuổi.', 4.5, 20, '2023-10-11'),
('EBI TEM SUSHI', 79000, 3, 'images/Sushi/Artboard-19-copy-58@4x-100-300x300.jpg', N'Ebi tem sushi giòn rụm, với phần tôm tempura chiên giòn phủ lên cơm sushi dẻo. Món ăn này không chỉ thu hút bởi độ giòn mà còn giữ được vị tươi ngon đặc trưng của tôm.', 4.4, 28, '2023-11-30'),
('HOKKIGAI SUSHI', 89000, 3, 'images/Sushi/Artboard-19-copy-59@4x-100-300x300.jpg', N'Hokkigai sushi được chế biến từ sò đỏ tươi ngon, mang đến trải nghiệm ẩm thực độc đáo. Vị ngọt đặc trưng của sò đỏ cùng với cơm sushi tạo nên sự cân bằng hoàn hảo, hấp dẫn mọi thực khách.', 4.6, 35, '2023-06-23'),
('HOTATE SUSHI', 89000, 3, 'images/Sushi/Artboard-19-copy-60@4x-100-300x300.jpg', N'Hotate sushi là sự kết hợp tuyệt vời giữa cơm sushi dẻo và sò điệp tươi ngon. Vị ngọt tự nhiên của sò điệp cùng với chút chua nhẹ từ cơm sushi tạo nên một món ăn đầy tinh tế, khiến người ăn phải mê mẩn.', 4.7, 25, '2023-12-01'),
('IKA SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-61@4x-100-300x300.jpg', N'IKA sushi tươi ngon, dễ thưởng thức.', 4.2, 30, '2023-02-05'),
('IKA SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-61@4x-100-300x300.jpg', N'Ika sushi được làm từ mực tươi, giữ nguyên độ ngọt tự nhiên và độ giòn sần sật khi nhai. Đây là món sushi nhẹ nhàng, dễ thưởng thức và được nhiều người ưa thích bởi sự tươi ngon và đơn giản.', 4.2, 30, '2023-02-05'),
('IKURA SUSHI', 109000, 3, 'images/Sushi/Artboard-19-copy-63@4x-100-300x300.jpg', N'Ikura sushi nổi bật với phần trứng cá hồi tươi sống được đặt trên cơm sushi. Vị mặn mà và ngọt béo từ trứng cá hòa quyện cùng cơm sushi tạo nên món ăn đậm đà, đặc biệt phù hợp cho những người yêu thích hương vị biển.', 4.8, 12, '2023-01-28'),
('KANIKAMA SUSHI', 59000, 3, 'images/Sushi/Artboard-19-copy-63@4x-100-300x300.jpg', N'Kanikama sushi được làm từ thanh cua thơm ngon, là món ăn nhẹ nhàng, phù hợp để ăn khai vị. Vị ngọt thanh của thanh cua kết hợp với cơm sushi dẻo tạo nên sự hòa quyện hoàn hảo.', 4.5, 18, '2023-08-29'),
('KANPACHI SUSHI', 129000, 3, 'images/Sushi/Artboard-19-copy-65@4x-100-300x300.jpg', N'Kanpachi sushi được làm từ cá Kanpachi tươi ngon, với hương vị ngọt ngào và đậm đà. Mỗi miếng sushi đều giữ nguyên độ tươi mát và vị ngọt tự nhiên, mang đến trải nghiệm ẩm thực tuyệt vời.', 4.9, 22, '2023-03-15'),
('KOMOCHI NISSIN SUSHI', 79000, 3, 'images/Sushi/Artboard-19-copy-78@4x-100-300x300.jpg', N'Komoji Nissin sushi là sự kết hợp giữa cơm sushi dẻo và phần nhân bơ mềm mịn. Vị béo ngậy của bơ làm cho món ăn trở nên đặc biệt và hấp dẫn.', 4.5, 33, '2023-04-03'),
('KOSUSHI MORIAWASE', 689000, 3, 'images/Sushi/Artboard-19-copy-79@4x-100-300x300.jpg', N'Kosushi Moriawase là món sushi phong phú với nhiều loại nhân khác nhau. Được chế biến tỉ mỉ, món ăn này mang đến sự đa dạng về hương vị và tạo nên bữa ăn đầy màu sắc.', 4.6, 25, '2023-05-18'),
('KUE SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-80@4x-100-300x300.jpg', N'Kue sushi là sự kết hợp độc đáo giữa phô mai và cá hồi tươi, mang đến sự hài hòa giữa vị béo ngậy của phô mai và ngọt thanh của cá. Đây là món sushi đầy sáng tạo và cực kỳ ngon miệng.', 4.8, 15, '2023-06-09'),
('MAGURO SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-81@4x-100-300x300.jpg', N'Maguro sushi với cá ngừ tươi sống, được cắt lát mỏng và đặt lên cơm sushi mềm dẻo. Vị cá ngừ đậm đà kết hợp cùng cơm tạo nên hương vị tinh tế, là lựa chọn lý tưởng cho những người yêu thích sushi truyền thống.', 4.7, 20, '2023-07-11'),
('MATSU SUSHI', 379000, 3, 'images/Sushi/Artboard-19-copy-82@4x-100-300x300.jpg',  N'Matsu sushi là sự kết hợp hoàn hảo của cơm sushi và cá hồi tươi, mang đến sự tươi mát và thanh nhẹ. Mỗi miếng sushi đều được chế biến tinh tế, giữ nguyên độ tươi ngon và tạo cảm giác dễ chịu khi thưởng thức.', 4.9, 18, '2023-08-14'),
('OTORO SUSHI', 369000, 3, 'images/Sushi/Artboard-19-copy-83@4x-100-300x300.jpg',  N'Otoro sushi với phần cá ngừ béo ngậy, mang đến hương vị tinh tế và hấp dẫn. Đây là món sushi cao cấp với phần thịt cá ngừ được chọn lọc kỹ càng, đảm bảo độ tươi ngon và vị ngọt tự nhiên.', 4.5, 28, '2023-09-16'),
('SAKE SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-84@4x-100-300x300.jpg', N'Sake sushi sử dụng cá hồi tươi ngon, phần thịt mềm mại và vị ngọt thanh. Đây là món sushi dễ ăn và được nhiều người ưa thích nhờ hương vị nhẹ nhàng và sự hòa quyện giữa cơm và cá hồi.', 4.2, 35, '2023-10-20'),
('SAKE TORO ABURI SUSHI', 99000, 3, 'images/Sushi/Artboard-19-copy-85@4x-100-300x300.jpg', N'Sake Toro Aburi sushi được làm từ phần thịt cá hồi béo ngậy, được áp chảo nhẹ nhàng để giữ nguyên độ tươi. Món này nổi bật với hương vị đậm đà và lớp bề mặt thơm lừng, thích hợp cho những ai yêu thích hương vị độc đáo của sushi nướng.', 4.8, 22, '2023-11-21'),
('SAKE SALAD SUSHI', 69000, 3, 'images/Sushi/Artboard-19-copy-86@4x-100-300x300.jpg', N'Sake salad sushi là món sushi với phần nhân cá hồi tươi kết hợp cùng salad giòn mát. Sự cân bằng giữa độ béo của cá hồi và vị tươi mát của salad tạo nên hương vị dễ chịu, nhẹ nhàng.', 4.4, 20, '2023-03-12');

-- Sushi Cake
INSERT INTO Product (product_name, price, category_id, img, description, rating, purchase_count, releaseDate) 
VALUES 
('FUJI CAKE', 2490000, 1, 'images/Cake/4-1-300x300.jpg', N'Bánh Fuji là sự kết hợp độc đáo giữa hương vị truyền thống của sushi và nét ngọt ngào từ bánh ngọt. Lớp trên cùng là cá tươi sushi được bày trí đẹp mắt, hòa quyện cùng cơm dẻo, còn phần đế bánh được làm từ nguyên liệu cao cấp, mang đến cảm giác mềm mịn khi thưởng thức. Đây là món ăn không chỉ đẹp mắt mà còn chinh phục vị giác.', 4.8, 20, '2023-01-15'),
('JAMBON MAGURO', 219000, 1, 'images/Cake/5-1-300x300.jpg', N'Bánh jambon maguro là sự kết hợp hoàn hảo giữa jambon và cá ngừ tươi sống, tạo nên hương vị độc đáo và lôi cuốn. Lớp bánh mềm mịn kết hợp với jambon mặn mòi và cá maguro tươi tạo nên món ăn hấp dẫn. Đây là lựa chọn lý tưởng cho những ai yêu thích sự kết hợp giữa truyền thống và hiện đại trong món sushi.', 4.6, 25, '2023-02-20'),
('JAMBON MAGURO AVOCADO', 299000, 1, 'images/Cake/5-2-300x300.jpg', N'Sự kết hợp tuyệt vời giữa jambon, cá ngừ maguro tươi ngon và bơ mềm mịn đã tạo nên món bánh jambon maguro avocado. Hương vị bơ béo ngậy, quyện với vị tươi ngọt của cá ngừ và lớp bánh mềm tạo nên trải nghiệm ăn uống đáng nhớ. Một món ăn đặc biệt phù hợp cho những ai yêu thích sự sáng tạo trong ẩm thực.', 4.7, 30, '2023-03-12'),
('JAMBON SAKE – BACON', 249000, 1, 'images/Cake/6-1-300x300.jpg', N'Bánh jambon sake – bacon là món ăn độc đáo với sự kết hợp giữa vị mặn của jambon, cá hồi nướng sake và bacon giòn tan. Lớp bánh mềm được phủ bacon giòn rụm, tạo nên độ tương phản thú vị trong từng miếng cắn. Đây là món bánh đầy hương vị, phù hợp cho các bữa tiệc hoặc dịp đặc biệt.', 4.5, 18, '2023-04-18'),
('MIXED SALMON', 299000, 1, 'images/Cake/6-3-300x300.jpg', N'Bánh mixed salmon mang đến trải nghiệm tuyệt vời với lớp cá hồi tươi ngon được chế biến tỉ mỉ, kết hợp với lớp bánh ngọt mềm mịn. Sự hòa quyện giữa vị tươi ngọt của cá hồi và độ mịn màng của bánh tạo nên một món ăn cân bằng, nhẹ nhàng nhưng vẫn đậm đà. Đây là lựa chọn hoàn hảo cho những bữa tiệc sang trọng.', 4.9, 22, '2023-05-25'),
('MOMIJI CAKE', 2390000, 1, 'images/Cake/8-1-300x300.jpg', N'Mochi momiji là một loại bánh đặc trưng với hương vị tinh tế và độc đáo. Được làm từ nguyên liệu chất lượng cao, bánh có lớp ngoài mềm mịn với nhân ngọt bên trong, tạo nên cảm giác tan chảy ngay khi thưởng thức. Đây là món bánh thể hiện rõ sự tinh tế trong ẩm thực Nhật Bản, là lựa chọn tuyệt vời cho các dịp đặc biệt.', 4.8, 15, '2023-06-30'),
('MOMO CAKE', 2990000, 1, 'images/Cake/11-300x300.jpg', N'Bánh Momo là sự kết hợp hoàn hảo giữa lớp vỏ bánh mềm và lớp nhân ngọt dịu bên trong. Được làm từ nguyên liệu tự nhiên, bánh Momo không chỉ thơm ngon mà còn có hình dáng đẹp mắt, thu hút ngay từ cái nhìn đầu tiên. Đây là món bánh hoàn hảo cho các buổi tiệc trà hoặc dùng làm quà tặng.', 4.6, 12, '2023-07-05'),
('SAKURA CAKE', 1232144, 1, 'images/Cake/17-300x300.jpg', N'Bánh Sakura là biểu tượng của mùa xuân với thiết kế thanh lịch và hương vị nhẹ nhàng, thơm mát. Lớp bánh mềm mịn cùng với hương vị ngọt dịu của hoa anh đào mang đến trải nghiệm tinh tế và khó quên. Đây là món bánh lý tưởng để thưởng thức trong những buổi gặp mặt nhẹ nhàng hay dùng làm quà biếu.', 4.7, 28, '2023-08-10'),
('MONO CAKE', 3466577, 1, 'images/Cake/18-300x300.jpg', N'Bánh Mono gây ấn tượng với thiết kế sáng tạo và hương vị tuyệt hảo. Mỗi lớp bánh được làm từ nguyên liệu tự nhiên, mang đến vị ngọt thanh mát, kết hợp cùng lớp kem mịn màng và trang trí độc đáo. Đây là lựa chọn hoàn hảo cho những ai yêu thích sự mới lạ và sáng tạo trong ẩm thực.', 4.5, 19, '2023-09-15'),
('SAKURE CAKE', 314434, 1, 'images/Cake/19-300x300.jpg', N'Bánh Sakure không chỉ đẹp mắt mà còn có hương vị thơm ngon với lớp nhân hấp dẫn. Lớp vỏ bánh mềm mịn kết hợp cùng nhân ngọt vừa phải, phù hợp cho các bữa tiệc hoặc dùng làm món tráng miệng trong những dịp đặc biệt.', 4.6, 20, '2023-10-05'),
('NoNO CAKE', 564357, 1, 'images/Cake/mooncake-post-facebook-300x300.jpg', N'Bánh NoNO là sự lựa chọn hoàn hảo cho những ai yêu thích hương vị nhẹ nhàng và thanh mát. Lớp bánh mềm kết hợp với vị ngọt dịu, thích hợp cho mọi lứa tuổi và mọi dịp. Đây là món bánh lý tưởng cho các bữa tiệc gia đình hay các buổi họp mặt thân mật.', 4.4, 15, '2023-11-11'),
('Mani CAKE', 578578, 1, 'images/Cake/12-300x300.jpg', N'Bánh Mani là sự kết hợp của các nguyên liệu tinh tế, mang đến vị ngọt thanh và hương vị ngon miệng. Lớp bánh mềm mịn và nhân ngọt nhẹ bên trong tạo nên sự cân bằng hoàn hảo, thích hợp cho các bữa tiệc hoặc dùng làm quà tặng.', 4.8, 10, '2023-12-01'),
('SALMON MENTAI CREAM SAUCE', 499000, 1, 'images/Cake/13-300x300.jpg', N'Bánh cá hồi mentaiko sốt kem là sự pha trộn giữa hương vị đậm đà của cá hồi và sốt mentaiko đặc trưng, kết hợp cùng lớp kem béo ngậy. Đây là món bánh phù hợp cho những thực khách yêu thích hương vị phong phú và đậm đà.', 4.7, 17, '2023-01-20'),
('SAKE & MENTAIKO', 399000, 1, 'images/Cake/14-300x300.jpg', N'Bánh sake và mentaiko là sự hòa quyện tuyệt vời giữa vị ngọt của sake và vị mặn đậm đà của mentaiko. Mỗi miếng bánh đều mang lại hương vị độc đáo và mới lạ, phù hợp cho các buổi tiệc hoặc làm quà tặng.', 4.5, 15, '2023-02-14');

-- Salad
INSERT INTO Product (product_name, price, category_id, img, description, rating, purchase_count, releaseDate) 
VALUES 
('BEEF SALAD', 149000, 4, 'images/Salad/kaiso-salad-300x300.png', N'Salad bò tươi ngon với các loại rau xanh giòn giã như xà lách, cà chua bi, dưa leo. Thịt bò được nướng vừa chín tới, giữ được độ mềm ngọt và kết hợp cùng nước sốt chua ngọt đặc biệt.', 4.6, 25, '2023-01-10'),
('EBI TEN SALAD', 139000, 4, 'images/Salad/salad-bo-300x300.png', N'Salad tôm chiên giòn hấp dẫn, tôm tươi được nhúng bột tempura và chiên vàng giòn, ăn kèm với rau xanh tươi mát, tạo nên sự cân bằng giữa vị giòn của tôm và vị mát của rau.', 4.5, 30, '2023-02-15'),
('CHICKEN SALAD', 149000, 4, 'images/Salad/salad-ca-hoi-xong-khoi-300x300.png', N'Salad gà bổ dưỡng với thịt gà nướng thơm ngon, kết hợp với rau xanh, cà chua bi và dưa leo. Sốt mè rang béo ngậy được thêm vào tạo nên hương vị đặc trưng khó cưỡng.', 4.7, 40, '2023-03-20'),
('DUCK TEN SALAD', 139000, 4, 'images/Salad/salad-ca-ngu-300x300.png', N'Salad vịt với thịt vịt quay vàng giòn, hòa quyện cùng rau xanh tươi mới và sốt dấm balsamic. Món salad mang lại hương vị đậm đà và khác biệt.', 4.4, 22, '2023-04-25'),
('BUFFALO SALAD', 149000, 4, 'images/Salad/salad-cua-300x300.png', N'Salad Buffalo với thịt gà tẩm gia vị cay nồng đặc trưng của sốt Buffalo, ăn kèm rau xanh giòn, sốt kem chua và cà chua bi. Món ăn này mang lại sự kết hợp hoàn hảo giữa vị cay và mát.', 4.8, 35, '2023-05-30'),
('NIKKI TEN SALAD', 139000, 4, 'images/Salad/salad-hai-san-300x300.png', N'Salad hải sản tươi sống với các loại tôm, mực và cua, kết hợp cùng rau xanh và dưa leo giòn mát, thêm vào đó là sốt chanh dây chua nhẹ, tạo nên hương vị mát lạnh, tươi ngon.', 4.5, 18, '2023-06-15'),
('KUBO SALAD', 159000, 4, 'images/Salad/salad-tom-300x300.png', N'Salad tôm với sốt chua ngọt đặc biệt, tôm tươi được hấp vừa chín tới, giữ được vị ngọt tự nhiên, ăn kèm với rau xanh và các loại thảo mộc, mang lại cảm giác thanh mát, hấp dẫn.', 4.6, 20, '2023-07-10');


-- Maki
INSERT INTO Product (product_name, price, category_id, img, description, rating, purchase_count, releaseDate) 
VALUES 
('CALIFORNIA MAKI', 119000, 5, 'images/Maki/Capture-1-300x300.png', N'California maki ngọt ngào, với sự kết hợp hoàn hảo giữa thanh cua, bơ, và trứng cá, lớp rong biển và cơm giòn rụm.', 4.5, 50, '2023-08-05'),
('EBI TEM MAKI', 119000, 5, 'images/Maki/Capture-2-300x300.png', N'Ebi tem maki thơm lừng, tôm chiên giòn cuốn cùng rong biển và cơm, vị giòn tan và hấp dẫn.', 4.7, 33, '2023-09-10'),
('FUTO MAKI', 99000, 5, 'images/Maki/Capture-3-300x300.png', N'Futo maki đa dạng với nhiều loại nhân như rau củ, cá và trứng, tạo nên hương vị phong phú và ngon miệng.', 4.4, 28, '2023-10-01'),
('GYU NIKU MAKI', 129000, 5, 'images/Maki/Capture-4-300x300.png', N'Gyu niku maki cuốn thịt bò nướng mềm, kết hợp cùng rau củ tươi, tạo ra hương vị đậm đà.', 4.6, 15, '2023-11-02'),
('KANIKO SALAD MAKI', 39000, 5, 'images/Maki/Capture-5-300x300.png', N'Maki salad với thanh cua, trứng cá và rau củ tươi, mang lại vị tươi ngon và nhẹ nhàng.', 4.2, 22, '2023-12-10'),
('MAGURO CHIZU MAKI', 179000, 5, 'images/Maki/Capture-6-300x300.png', N'Maguo maki với cá ngừ tươi và phô mai béo ngậy, tạo sự cân bằng hoàn hảo giữa vị béo và vị tươi của cá.', 4.8, 12, '2023-01-25'),
('SAKE AVOCADO MAKI', 199000, 5, 'images/Maki/Capture-7-300x300.png', N'Sake avocado maki với cá hồi tươi và bơ béo ngậy, cung cấp nhiều chất dinh dưỡng và hương vị đậm đà.', 4.9, 20, '2023-02-20'),
('SAKE KAWA MAKI', 209000, 5, 'images/Maki/Capture-8-300x300.png', N'Sake kawa maki cuốn lớp da cá hồi giòn rụm, hòa quyện cùng cơm dẻo và rau củ, mang lại trải nghiệm ẩm thực độc đáo.', 4.7, 15, '2023-03-30'),
('SAKE MAKI', 89000, 5, 'images/Maki/Capture-9-300x300.png', N'Sake maki cuốn cá hồi tươi ngon, hương vị béo ngậy và thanh mát, rất phù hợp cho những ai yêu thích sushi truyền thống.', 4.5, 28, '2023-04-15'),
('SAKE NEGI TEM MAKI', 149000, 5, 'images/Maki/Capture-10-300x300.png', N'Sake negi tem maki với cá hồi và hành lá chiên giòn, tạo ra sự kết hợp độc đáo giữa giòn và mềm.', 4.6, 18, '2023-05-05'),
('SAKEKAWA AVOCADO MAKI', 379000, 5, 'images/Maki/Capture-11-300x300.png', N'Sakekawa avocado maki kết hợp lớp da cá hồi giòn tan và bơ tươi béo, mang lại hương vị ngon tuyệt.', 4.8, 22, '2023-06-07'),
('SALMON SALAD MAKI', 129000, 5, 'images/Maki/Capture-12-300x300.png', N'Maki salad cá hồi tươi, kết hợp với rau xanh tươi mát, rất bổ dưỡng và tốt cho sức khỏe.', 4.4, 16, '2023-07-20');

-- Tempura
INSERT INTO Product (product_name, price, category_id, img, description, rating, purchase_count, releaseDate) 
VALUES 
('EBI TEMPURA', 129000, 6, 'images/Tempura/Capture-8-300x300.png', N'Tempura tôm giòn rụm, được làm từ những con tôm tươi ngon, nhúng bột tempura và chiên vàng giòn, giữ được độ ngọt tự nhiên của tôm.', 4.7, 30, '2023-08-15'),
('IKA TEMPURA', 99000, 6, 'images/Tempura/Capture-9-300x300.png', N'Tempura mực mềm mại, sử dụng mực ống tươi, tẩm bột tempura mỏng nhẹ, chiên vừa phải để giữ độ dai và ngọt.', 4.5, 25, '2023-09-25'),
('HBT TEMPURA', 550000, 6, 'images/Tempura/Capture-8-300x300.png', N'Tempura hải sản đặc biệt với các loại hải sản tươi sống như tôm, mực và cá, nhúng bột tempura và chiên giòn. Phong phú và ngon miệng.', 4.9, 10, '2023-10-10'),
('TOKYO TEMPURA', 590000, 6, 'images/Tempura/Capture-11-300x300.png', N'Tempura Tokyo, mang hương vị độc quyền với sự kết hợp của các loại rau củ và hải sản tươi ngon, tạo ra sự cân bằng giữa giòn và mềm.', 4.6, 15, '2023-11-01'),
('KYOTO TEMPURA', 300000, 6, 'images/Tempura/Capture-12-300x300.png', N'Tempura Kyoto mang hương vị truyền thống, làm từ rau củ địa phương và các loại hải sản, bột tempura được pha chế theo công thức cổ truyền.', 4.4, 18, '2023-12-20'),
('TEMOMO TEMPURA', 230000, 6, 'images/Tempura/Capture-13-300x300.png', N'Tempura tôm tươi nhúng bột tempura giòn tan, chiên đến khi vàng ruộm, giữ được độ giòn và hương vị ngọt thanh của tôm.', 4.5, 20, '2023-01-12'),
('KIYO TEMPURA', 239000, 6, 'images/Tempura/Capture-14-300x300.png', N'Tempura đa dạng với sự kết hợp của rau củ và tôm chiên giòn, mang đến sự phong phú về hương vị và độ giòn tuyệt hảo.', 4.3, 25, '2023-02-10'),
('KOKO TEMPURA', 868905, 6, 'images/Tempura/Capture-15-300x300.png', N'Koko tempura đặc biệt, kết hợp giữa tôm, mực và cá chiên giòn, hương vị thơm ngon và độ giòn hoàn hảo.', 4.8, 12, '2023-03-05'),
('KING TEMPURA', 239000, 6, 'images/Tempura/Capture-17-300x300.png', N'King tempura với nguyên liệu chọn lọc, bao gồm các loại hải sản tươi và rau củ chiên giòn, tạo nên món ăn hảo hạng và hấp dẫn.', 4.6, 20, '2023-04-07'),
('QUEEN TEMPURA', 123849, 6, 'images/Tempura/Capture-18-300x300.png', N'Queen tempura, sử dụng nguyên liệu cao cấp với sự kết hợp giữa tôm, cá và rau củ, mang lại hương vị tinh tế và thanh lịch.', 4.9, 15, '2023-05-18'),
('JUU TEMPURA', 400995, 6, 'images/Tempura/Capture-19-300x300.png', N'Tempura Juu, nổi bật với sự đa dạng về nguyên liệu, từ rau củ cho đến hải sản, tất cả được nhúng bột tempura và chiên giòn vàng.', 4.4, 10, '2023-06-30'),
('NUNI TEMPURA', 123455, 6, 'images/Tempura/Capture-20-300x300.png', N'Nuni tempura, độc đáo với tôm và rau củ chiên giòn, lớp bột tempura mỏng và giòn tan, mang đến hương vị thơm ngon.', 4.5, 20, '2023-07-15'),
('NAMI TEMPURA', 9123049, 6, 'images/Tempura/Capture-16-300x300.png', N'Nami tempura, kết hợp giữa các loại hải sản cao cấp như tôm hùm, mực và cá, nhúng bột tempura mỏng giòn, tạo ra hương vị không thể chối từ.', 4.8, 5, '2023-08-01');


GO

-- Thêm dữ liệu mẫu vào bảng Order
INSERT INTO [Order] (user_id, order_date, total, notes)
VALUES (1, GETDATE(), 24.97, 'Takeout order');
INSERT INTO [Order] (user_id, order_date, total, notes)
VALUES (2, GETDATE(), 19.98, 'Dine-in order');
GO

-- Thêm tài khoản quản trị
INSERT INTO Users (user_name, email, password, address, gender, phone, role_id) 
VALUES 
('Admin', 'admin1@hikari.com', '123', 'Hanoi, Vietnam', 1, '0123456789', 3)  -- Quản lý

go

-- Thêm tài khoản nhân viên
INSERT INTO Users (user_name, email, password, address, gender, phone, role_id) 
VALUES 
('hihi', 'hihi@hikari.com', '123', 'Hanoi, Vietnam', 0, '0123456782', 1);
('hang', 'hang@hikari.com', '123', 'Hanoi, Vietnam', 1, '0123456781', 2),  -- Nhân viên
('hiepbq', 'hiep@hikari.com', '123', 'Hanoi, Vietnam', 0, '0123456782', 1);  -- Nhân viên
