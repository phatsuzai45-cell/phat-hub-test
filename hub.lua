-- Gọi hệ thống tạo hiệu ứng mượt (TweenService) của Roblox
local TweenService = game:GetService("TweenService")

-- Giả sử bạn đã có biến Trang Farm (Pages.FarmPage) từ code bài trước
-- Tạo một cái khung chứa công tắc và chữ
local ToggleContainer = Instance.new("Frame", Pages.FarmPage)
ToggleContainer.Size = UDim2.new(1, -20, 0, 40)
ToggleContainer.Position = UDim2.new(0, 10, 0, 10)
ToggleContainer.BackgroundTransparency = 1

-- Tiêu đề của công tắc
local ToggleLabel = Instance.new("TextLabel", ToggleContainer)
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Bật/Tắt Auto Farm"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.Font = Enum.Font.GothamSemibold
ToggleLabel.TextSize = 15
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 1. TẠO CÁI NỀN CỦA CÔNG TẮC (Track)
local ToggleTrack = Instance.new("Frame", ToggleContainer)
ToggleTrack.Size = UDim2.new(0, 50, 0, 24)
ToggleTrack.Position = UDim2.new(1, -60, 0.5, -12)
ToggleTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70) -- Màu xám khi tắt
local TrackCorner = Instance.new("UICorner", ToggleTrack)
TrackCorner.CornerRadius = UDim.new(1, 0) -- Bo tròn hoàn toàn thành hình viên thuốc

-- 2. TẠO CỤC TRÒN DI CHUYỂN BÊN TRONG (Circle)
local ToggleCircle = Instance.new("Frame", ToggleTrack)
ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
ToggleCircle.Position = UDim2.new(0, 2, 0.5, -10) -- Mặc định nằm bên trái
ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
local CircleCorner = Instance.new("UICorner", ToggleCircle)
CircleCorner.CornerRadius = UDim.new(1, 0)

-- 3. NÚT BẤM VÔ HÌNH ĐÈ LÊN TRÊN ĐỂ BẮT SỰ KIỆN CLICK
local ToggleButton = Instance.new("TextButton", ToggleTrack)
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Text = ""

-- 4. LOGIC HOẠT ĐỘNG
local isToggled = false -- Mặc định ban đầu là Tắt (false)

ToggleButton.MouseButton1Click:Connect(function()
    isToggled = not isToggled -- Đảo ngược trạng thái (Đang tắt thành bật, bật thành tắt)
    
    -- Cài đặt thông số cho hiệu ứng trượt (Trượt trong 0.3 giây)
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if isToggled then
        -- TRẠNG THÁI BẬT: 
        -- 1. Cục tròn trượt sang phải
        local moveCircle = TweenService:Create(ToggleCircle, tweenInfo, {Position = UDim2.new(1, -22, 0.5, -10)})
        -- 2. Đổi màu nền sang xanh dương sáng
        local changeColor = TweenService:Create(ToggleTrack, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 170, 255)})
        
        moveCircle:Play()
        changeColor:Play()
        
        -- (Chỗ này bạn sẽ bỏ code bắt đầu Auto Farm vào)
        print("Đã BẬT Auto Farm!")
    else
        -- TRẠNG THÁI TẮT:
        -- 1. Cục tròn trượt về lại bên trái
        local moveCircle = TweenService:Create(ToggleCircle, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10)})
        -- 2. Đổi màu nền về lại xám
        local changeColor = TweenService:Create(ToggleTrack, tweenInfo, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)})
        
        moveCircle:Play()
        changeColor:Play()
        
        -- (Chỗ này bạn sẽ bỏ code dừng Auto Farm vào)
        print("Đã TẮT Auto Farm!")
    end
end)
