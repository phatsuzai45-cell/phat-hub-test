local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 1. XÓA HUB CŨ NẾU ĐANG MỞ ĐỂ TRÁNH TRÙNG LẶP
if PlayerGui:FindFirstChild("PhatHubV4") then
    PlayerGui.PhatHubV4:Destroy()
end

-- 2. TẠO MÀN HÌNH VÀ BẢNG CHÍNH
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "PhatHubV4"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Nút Tắt (X) ở góc trên cùng
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- 3. TẠO SIDEBAR (MENU BÊN TRÁI) VÀ CONTAINER CHỨA TRANG
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local PageContainer = Instance.new("Frame", MainFrame)
PageContainer.Size = UDim2.new(1, -140, 1, -20)
PageContainer.Position = UDim2.new(0, 135, 0, 10)
PageContainer.BackgroundTransparency = 1

-- 4. HÀM TẠO TRANG VÀ NÚT CHUYỂN TRANG
local Pages = {}
local function CreatePage(pageName)
    local Page = Instance.new("Frame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    
    local Title = Instance.new("TextLabel", Page)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = pageName .. " MENU"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    return Page
end

local function CreateTab(tabName, targetPage)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(0, 110, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Btn.Text = tabName
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        for _, page in pairs(Pages) do page.Visible = false end
        targetPage.Visible = true
        for _, otherBtn in pairs(Sidebar:GetChildren()) do
            if otherBtn:IsA("TextButton") then otherBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55) end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
end

-- KHỞI TẠO CÁC TRANG VÀ TAB
Pages.Farm = CreatePage("☁️ FARM")
Pages.Player = CreatePage("👤 PLAYER")
Pages.Settings = CreatePage("⚙️ SETTINGS")

CreateTab("Farm", Pages.Farm)
CreateTab("Player", Pages.Player)
CreateTab("Settings", Pages.Settings)

-- Mặc định mở trang Farm đầu tiên
Pages.Farm.Visible = true
Sidebar:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(0, 150, 255)

-- ==========================================
-- 🚀 TRANG FARM: TÍNH NĂNG CÔNG TẮC BẬT/TẮT
-- ==========================================
local ToggleBg = Instance.new("Frame", Pages.Farm)
ToggleBg.Size = UDim2.new(1, -20, 0, 45)
ToggleBg.Position = UDim2.new(0, 10, 0, 40)
ToggleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 6)

local ToggleLabel = Instance.new("TextLabel", ToggleBg)
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Auto Farm (Chức năng mẫu)"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.Font = Enum.Font.GothamSemibold
ToggleLabel.TextSize = 14
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleTrack = Instance.new("Frame", ToggleBg)
ToggleTrack.Size = UDim2.new(0, 46, 0, 22)
ToggleTrack.Position = UDim2.new(1, -60, 0.5, -11)
ToggleTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
Instance.new("UICorner", ToggleTrack).CornerRadius = UDim.new(1, 0)

local ToggleCircle = Instance.new("Frame", ToggleTrack)
ToggleCircle.Size = UDim2.new(0, 18, 0, 18)
ToggleCircle.Position = UDim2.new(0, 2, 0.5, -9)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1, 0)

local ToggleBtn = Instance.new("TextButton", ToggleTrack)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

local isFarmOn = false
ToggleBtn.MouseButton1Click:Connect(function()
    isFarmOn = not isFarmOn
    local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
    if isFarmOn then
        TweenService:Create(ToggleCircle, ti, {Position = UDim2.new(1, -20, 0.5, -9)}):Play()
        TweenService:Create(ToggleTrack, ti, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
    else
        TweenService:Create(ToggleCircle, ti, {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
        TweenService:Create(ToggleTrack, ti, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end
end)

-- ==========================================
-- 🚀 TRANG PLAYER: HACK TỐC ĐỘ VÀ BẢNG MÁU
-- ==========================================
-- 1. Hack Tốc Độ
local SliderBg = Instance.new("Frame", Pages.Player)
SliderBg.Size = UDim2.new(1, -20, 0, 60)
SliderBg.Position = UDim2.new(0, 10, 0, 40)
SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 6)

local SliderLabel = Instance.new("TextLabel", SliderBg)
SliderLabel.Size = UDim2.new(1, -30, 0, 30)
SliderLabel.Position = UDim2.new(0, 15, 0, 0)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Hack Tốc Độ Chạy (WalkSpeed)"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.Font = Enum.Font.GothamSemibold
SliderLabel.TextSize = 14
SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedValue = Instance.new("TextLabel", SliderBg)
SpeedValue.Size = UDim2.new(0, 50, 0, 30)
SpeedValue.Position = UDim2.new(1, -60, 0, 0)
SpeedValue.BackgroundTransparency = 1
SpeedValue.Text = "16"
SpeedValue.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextSize = 14

local SetSpeedBtn = Instance.new("TextButton", SliderBg)
SetSpeedBtn.Size = UDim2.new(1, -30, 0, 20)
SetSpeedBtn.Position = UDim2.new(0, 15, 0, 30)
SetSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SetSpeedBtn.Text = "BẬT MAX TỐC ĐỘ"
SetSpeedBtn.TextColor3 = Color3.fromRGB(255,255,255)
SetSpeedBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SetSpeedBtn).CornerRadius = UDim.new(0, 4)

SetSpeedBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        if humanoid.WalkSpeed == 16 then
            humanoid.WalkSpeed = 100
            SetSpeedBtn.Text = "TẮT MAX TỐC ĐỘ"
            SetSpeedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            SpeedValue.Text = "100"
        else
            humanoid.WalkSpeed = 16
            SetSpeedBtn.Text = "BẬT MAX TỐC ĐỘ"
            SetSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            SpeedValue.Text = "16"
        end
    end
end)

-- 2. Bảng Theo Dõi Máu (Live Status)
local StatusBg = Instance.new("Frame", Pages.Player)
StatusBg.Size = UDim2.new(1, -20, 0, 45)
StatusBg.Position = UDim2.new(0, 10, 0, 110)
StatusBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", StatusBg).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel", StatusBg)
StatusLabel.Size = UDim2.new(1, -30, 1, 0)
StatusLabel.Position = UDim2.new(0, 15, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Xin chào: " .. player.Name
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(0.5) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local health = math.floor(player.Character.Humanoid.Health)
            local maxHealth = math.floor(player.Character.Humanoid.MaxHealth)
            StatusLabel.Text = "Xin chào: " .. player.Name .. " | Máu: " .. health .. "/" .. maxHealth
            if health < (maxHealth * 0.3) then
                StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            else
                StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
        end
    end
end)

-- ==========================================
-- 🚀 TRANG SETTINGS: REJOIN VÀ XÓA HUB
-- ==========================================
-- 1. Nút Rejoin Server
local RejoinBtn = Instance.new("TextButton", Pages.Settings)
RejoinBtn.Size = UDim2.new(1, -20, 0, 45)
RejoinBtn.Position = UDim2.new(0, 10, 0, 40)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
RejoinBtn.Text = "🔄 REJOIN SERVER (Vào lại phòng này)"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 14
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)

RejoinBtn.MouseButton1Click:Connect(function()
    RejoinBtn.Text = "Đang kết nối lại..."
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- 2. Nút Panic (Xóa Hub)
local DestroyBtn = Instance.new("TextButton", Pages.Settings)
DestroyBtn.Size = UDim2.new(1, -20, 0, 45)
DestroyBtn.Position = UDim2.new(0, 10, 0, 95)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
DestroyBtn.Text = "🗑️ XÓA BỎ HUB KHỎI MÀN HÌNH"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyBtn.Font = Enum.Font.GothamBold
DestroyBtn.TextSize = 14
Instance.new("UICorner", DestroyBtn).CornerRadius = UDim.new(0, 6)

DestroyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
