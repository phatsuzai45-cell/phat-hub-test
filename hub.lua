local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 1. XÓA HUB CŨ
if PlayerGui:FindFirstChild("PhatHubMobile") then
    PlayerGui.PhatHubMobile:Destroy()
end

-- 2. TẠO MÀN HÌNH CHÍNH (Dành cho Mobile)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "PhatHubMobile"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 280) -- Thu nhỏ lại chút cho vừa đt
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true -- Cắt phần thừa khi thu nhỏ
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- ==========================================
-- TẠO CÁC NÚT ĐIỀU KHIỂN (ĐỎ: ĐÓNG | VÀNG: THU NHỎ)
-- ==========================================
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 50)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 40), "Out", "Quad", 0.3, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 450, 0, 280), "Out", "Quad", 0.3, true)
    end
end)

-- ==========================================
-- SIDEBAR VÀ VÙNG CHỨA NỘI DUNG (Kéo thả, vuốt mượt)
-- ==========================================
local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Size = UDim2.new(0, 110, 1, -40)
Sidebar.Position = UDim2.new(0, 5, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Sidebar.ScrollBarThickness = 2
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local PageContainer = Instance.new("Frame", MainFrame)
PageContainer.Size = UDim2.new(1, -125, 1, -45)
PageContainer.Position = UDim2.new(0, 120, 0, 40)
PageContainer.BackgroundTransparency = 1

-- ==========================================
-- HỆ THỐNG TẠO TRANG THÔNG MINH (Tự động xếp dòng)
-- ==========================================
local Pages = {}
local function CreatePage(pageName)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3 -- Vuốt trên điện thoại
    Page.CanvasSize = UDim2.new(0, 0, 1.5, 0) -- Cho phép cuộn dài
    Page.Visible = false
    
    local layout = Instance.new("UIListLayout", Page)
    layout.Padding = UDim.new(0, 8) -- Khoảng cách giữa các nút là 8px
    
    local Title = Instance.new("TextLabel", Page)
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.BackgroundTransparency = 1
    Title.Text = "  " .. pageName
    Title.TextColor3 = Color3.fromRGB(200, 200, 200)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    return Page
end

local function CreateTab(tabName, targetPage)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(0, 100, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Btn.Text = tabName
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
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

-- KHỞI TẠO CÁC TAB
Pages.Farm = CreatePage("☁️ FARM")
Pages.Player = CreatePage("👤 PLAYER")
Pages.Settings = CreatePage("⚙️ SETTINGS")

CreateTab("Farm", Pages.Farm)
CreateTab("Player", Pages.Player)
CreateTab("Settings", Pages.Settings)

Pages.Farm.Visible = true
Sidebar:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(0, 150, 255)

-- ==========================================
-- 🚀 ĐỔ VÀO TRANG FARM: CÔNG TẮC
-- ==========================================
local ToggleBg = Instance.new("Frame", Pages.Farm)
ToggleBg.Size = UDim2.new(1, -10, 0, 45) -- Không cần tọa độ (Position) nữa vì UIList tự xếp
ToggleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 6)

local ToggleLabel = Instance.new("TextLabel", ToggleBg)
ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Auto Farm Level"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.Font = Enum.Font.GothamSemibold
ToggleLabel.TextSize = 13
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleTrack = Instance.new("Frame", ToggleBg)
ToggleTrack.Size = UDim2.new(0, 40, 0, 20)
ToggleTrack.Position = UDim2.new(1, -50, 0.5, -10)
ToggleTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
Instance.new("UICorner", ToggleTrack).CornerRadius = UDim.new(1, 0)

local ToggleCircle = Instance.new("Frame", ToggleTrack)
ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1, 0)

local ToggleBtn = Instance.new("TextButton", ToggleTrack)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

local isFarmOn = false
ToggleBtn.MouseButton1Click:Connect(function()
    isFarmOn = not isFarmOn
    if isFarmOn then
        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        TweenService:Create(ToggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
    else
        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        TweenService:Create(ToggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end
end)

-- ==========================================
-- 🚀 ĐỔ VÀO TRANG PLAYER: HACK TỐC ĐỘ VÀ MÁU
-- ==========================================
local SliderBg = Instance.new("Frame", Pages.Player)
SliderBg.Size = UDim2.new(1, -10, 0, 60)
SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 6)

local SliderLabel = Instance.new("TextLabel", SliderBg)
SliderLabel.Size = UDim2.new(1, -10, 0, 30)
SliderLabel.Position = UDim2.new(0, 10, 0, 0)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Hack Tốc Độ (WalkSpeed: 16)"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.Font = Enum.Font.GothamSemibold
SliderLabel.TextSize = 13
SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

local SetSpeedBtn = Instance.new("TextButton", SliderBg)
SetSpeedBtn.Size = UDim2.new(1, -20, 0, 20)
SetSpeedBtn.Position = UDim2.new(0, 10, 0, 30)
SetSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SetSpeedBtn.Text = "BẬT MAX TỐC ĐỘ"
SetSpeedBtn.TextColor3 = Color3.fromRGB(255,255,255)
SetSpeedBtn.Font = Enum.Font.GothamBold
SetSpeedBtn.TextSize = 12
Instance.new("UICorner", SetSpeedBtn).CornerRadius = UDim.new(0, 4)

SetSpeedBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        if player.Character.Humanoid.WalkSpeed == 16 then
            player.Character.Humanoid.WalkSpeed = 100
            SetSpeedBtn.Text = "TẮT MAX TỐC ĐỘ"
            SetSpeedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            SliderLabel.Text = "Hack Tốc Độ (WalkSpeed: 100)"
        else
            player.Character.Humanoid.WalkSpeed = 16
            SetSpeedBtn.Text = "BẬT MAX TỐC ĐỘ"
            SetSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            SliderLabel.Text = "Hack Tốc Độ (WalkSpeed: 16)"
        end
    end
end)

local StatusBg = Instance.new("Frame", Pages.Player)
StatusBg.Size = UDim2.new(1, -10, 0, 40)
StatusBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Instance.new("UICorner", StatusBg).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel", StatusBg)
StatusLabel.Size = UDim2.new(1, -20, 1, 0)
StatusLabel.Position = UDim2.new(0, 10, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Đang tải máu..."
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextSize = 13
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(0.5) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            StatusLabel.Text = "Máu: " .. math.floor(player.Character.Humanoid.Health) .. " / " .. math.floor(player.Character.Humanoid.MaxHealth)
        end
    end
end)

-- ==========================================
-- 🚀 ĐỔ VÀO TRANG SETTINGS: REJOIN
-- ==========================================
local RejoinBtn = Instance.new("TextButton", Pages.Settings)
RejoinBtn.Size = UDim2.new(1, -10, 0, 45)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
RejoinBtn.Text = "🔄 REJOIN SERVER"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 14
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 6)

RejoinBtn.MouseButton1Click:Connect(function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)
