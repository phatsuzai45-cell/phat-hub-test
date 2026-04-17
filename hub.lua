-- BƯỚC 1: TẠO GIAO DIỆN (GUI)
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Tạo một cái màn hình chứa GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Tạo một cái Khung (Frame) làm nền
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép kéo thả

-- Tạo Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "FPS BOOSTER HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.TextSize = 18

-- Tạo Nút bấm (Button)
local BoostButton = Instance.new("TextButton")
BoostButton.Parent = MainFrame
BoostButton.Size = UDim2.new(0.8, 0, 0.4, 0)
BoostButton.Position = UDim2.new(0.1, 0, 0.4, 0)
BoostButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
BoostButton.Text = "XÓA ĐỒ VẬT (TĂNG FPS)"
BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BoostButton.Font = Enum.Font.SourceSansBold
BoostButton.TextSize = 16

-- BƯỚC 2: GẮN CHỨC NĂNG VÀO NÚT BẤM
BoostButton.MouseButton1Click:Connect(function()
    -- Đổi trạng thái nút khi bắt đầu chạy
    BoostButton.Text = "Đang xử lý..."
    BoostButton.BackgroundColor3 = Color3.fromRGB(170, 170, 0)
    
    -- Quét và xóa các vật thể gây lag trong game
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
    
    -- Thông báo hoàn tất
    wait(1)
    BoostButton.Text = "ĐÃ TỐI ƯU XONG!"
    BoostButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end)
