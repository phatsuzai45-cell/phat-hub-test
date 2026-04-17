-- BƯỚC 1: TẠO MÀN HÌNH CHÍNH
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Nếu mở Hub nhiều lần, xóa Hub cũ đi để không bị chồng lên nhau
if PlayerGui:FindFirstChild("PhatHubTest") then
    PlayerGui.PhatHubTest:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhatHubTest"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- BẢNG CHÍNH (LÀM TO HƠN)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 400, 0, 300) -- Kích thước mới: Rộng 400, Cao 300
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Căn giữa màn hình
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40) -- Đổi màu xám đen sang trọng hơn
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép kéo thả

-- THÊM BO GÓC CHO BẢNG CHÍNH THÊM HIỆN ĐẠI
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10) -- Bo tròn 10 pixel
MainCorner.Parent = MainFrame

-- TIÊU ĐỀ HUB
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌟 PHAT HUB - TỐI ƯU HÓA 🌟"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- NÚT TẮT (CLOSE) Ở GÓC PHẢI
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Màu đỏ
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- Gắn chức năng tắt Hub cho nút X
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- KHUNG CHỨA CÁC NÚT (Có thanh cuộn nếu nhiều nút)
local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Parent = MainFrame
ButtonContainer.Size = UDim2.new(1, -20, 1, -50)
ButtonContainer.Position = UDim2.new(0, 10, 0, 40)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.BorderSizePixel = 0

-- Lệnh thần thánh giúp tự động xếp các nút thẳng hàng
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonContainer
UIListLayout.Padding = UDim.new(0, 10) -- Khoảng cách giữa các nút là 10 pixel
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- BƯỚC 2: HÀM TẠO NÚT (Viết 1 lần để dùng cho nhiều nút, code đỡ dài)
local function CreateButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonContainer
    btn.Size = UDim2.new(1, -10, 0, 45) -- Nút cao 45 pixel
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 15
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

-- BƯỚC 3: TẠO CÁC NÚT VÀ GẮN CHỨC NĂNG

-- CHỨC NĂNG 1: TĂNG FPS (Như cũ)
local FpsBtn = CreateButton("🚀 Xóa Texture & Bóng râm (Tăng FPS)", Color3.fromRGB(0, 150, 100))
FpsBtn.MouseButton1Click:Connect(function()
    FpsBtn.Text = "Đang xử lý..."
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
    wait(0.5)
    FpsBtn.Text = "✅ Đã Xóa Texture!"
end)

-- CHỨC NĂNG 2: XÓA HIỆU ỨNG (Giảm lag khi tung chiêu)
local EffectBtn = CreateButton("💨 Xóa Hiệu ứng (Skill, Khói, Lửa)", Color3.fromRGB(200, 100, 0))
EffectBtn.MouseButton1Click:Connect(function()
    EffectBtn.Text = "Đang dọn dẹp hiệu ứng..."
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Tắt các hiệu ứng hạt, đuôi sáng, khói, lửa
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
    wait(0.5)
    EffectBtn.Text = "✅ Đã Xóa Hiệu Ứng!"
end)

-- CHỨC NĂNG 3: BẬT SÁNG TOÀN BẢN ĐỒ (Dễ nhìn đồ vật trong bóng tối)
local LightBtn = CreateButton("☀️ Sáng Toàn Bản Đồ (Fullbright)", Color3.fromRGB(50, 100, 200))
LightBtn.MouseButton1Click:Connect(function()
    LightBtn.Text = "Đang thắp sáng..."
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 2
    lighting.ClockTime = 14 -- Chỉnh thời gian trong game luôn là 2h chiều
    lighting.FogEnd = 100000 -- Đẩy sương mù ra tít xa
    lighting.GlobalShadows = false
    lighting.Ambient = Color3.fromRGB(255, 255, 255)
    wait(0.5)
    LightBtn.Text = "✅ Đã Bật Sáng!"
end)
