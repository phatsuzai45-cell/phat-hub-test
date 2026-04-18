local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ==========================================
-- 🛠️ HỆ THỐNG BYPASS GIAO DIỆN CHUẨN CỦA DELTA
-- ==========================================
local guiParent = gethui and gethui() or game:GetService("CoreGui")

if guiParent:FindFirstChild("PhatHubDelta") then
    guiParent.PhatHubDelta:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhatHubDelta"
ScreenGui.Parent = guiParent
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling -- Ép Delta hiển thị đúng lớp
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 260)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- NÚT ĐÓNG (X)
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- MENU BÊN TRÁI (SIDEBAR)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.Position = UDim2.new(0, 5, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- KHUNG CHỨA TRANG (Chỉnh lại thành Frame thường để Delta đỡ lag)
local PageContainer = Instance.new("Frame", MainFrame)
PageContainer.Size = UDim2.new(1, -135, 1, -45)
PageContainer.Position = UDim2.new(0, 130, 0, 35)
PageContainer.BackgroundTransparency = 1

-- ==========================================
-- 🛠️ HÀM TẠO TRANG DÀNH RIÊNG CHO DELTA
-- ==========================================
local Pages = {}

local function CreatePage(pageName)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0, 0, 2, 0) -- Rất quan trọng với Delta
    Page.Visible = false
    
    local layout = Instance.new("UIListLayout", Page)
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local Title = Instance.new("TextLabel", Page)
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.BackgroundTransparency = 1
    Title.Text = " " .. pageName
    Title.TextColor3 = Color3.fromRGB(0, 200, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    return Page
end

local function CreateTab(tabName, targetPage)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(0, 110, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Btn.Text = tabName
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        for _, page in pairs(Pages) do page.Visible = false end
        targetPage.Visible = true
        for _, otherBtn in pairs(Sidebar:GetChildren()) do
            if otherBtn:IsA("TextButton") then otherBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50) end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
end

-- KHỞI TẠO TAB VÀ TRANG
Pages.Farm = CreatePage("FARM MENU")
Pages.Player = CreatePage("PLAYER MENU")

CreateTab("☁️ FARM", Pages.Farm)
CreateTab("👤 PLAYER", Pages.Player)

-- ÉP HIỂN THỊ TRANG ĐẦU TIÊN
Pages.Farm.Visible = true
Sidebar:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(0, 150, 255)

-- ==========================================
-- 🚀 ĐỔ NÚT BẤM VÀO (FIX LỖI MẤT NÚT)
-- ==========================================

-- 1. NÚT TĂNG TỐC ĐỘ (Bỏ vào trang Farm cho bạn dễ test)
local SpeedBtn = Instance.new("TextButton", Pages.Farm)
SpeedBtn.Size = UDim2.new(1, -10, 0, 45)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedBtn.Text = "🚀 CHẠY SIÊU NHANH (BẬT)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.TextSize = 14
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

SpeedBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        if player.Character.Humanoid.WalkSpeed == 16 then
            player.Character.Humanoid.WalkSpeed = 100
            SpeedBtn.Text = "🛑 CHẠY BÌNH THƯỜNG (TẮT)"
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        else
            player.Character.Humanoid.WalkSpeed = 16
            SpeedBtn.Text = "🚀 CHẠY SIÊU NHANH (BẬT)"
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end
    end
end)

-- 2. BẢNG THEO DÕI MÁU (Bỏ vào trang Player)
local StatusBg = Instance.new("Frame", Pages.Player)
StatusBg.Size = UDim2.new(1, -10, 0, 45)
StatusBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Instance.new("UICorner", StatusBg).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel", StatusBg)
StatusLabel.Size = UDim2.new(1, -20, 1, 0)
StatusLabel.Position = UDim2.new(0, 10, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Đang tải máu..."
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(0.5) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            StatusLabel.Text = "Máu hiện tại: " .. math.floor(player.Character.Humanoid.Health)
        end
    end
end)
