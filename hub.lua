local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- HỆ THỐNG VƯỢT TƯỜNG LỬA GIAO DIỆN CỦA DELTA
local guiParent = gethui and gethui() or game:GetService("CoreGui")

if guiParent:FindFirstChild("PhatHubV6") then
    guiParent.PhatHubV6:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhatHubV6"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global -- Ép vẽ đè lên mọi thứ
ScreenGui.Parent = guiParent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 260)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- NÚT ĐÓNG
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- SIDEBAR MENU
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.Position = UDim2.new(0, 5, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.Parent = Sidebar

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -135, 1, -45)
PageContainer.Position = UDim2.new(0, 130, 0, 35)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

-- HÀM TẠO TRANG ÉP DELTA RENDER
local Pages = {}

local function CreatePage(pageName)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.AutomaticSize = Enum.AutomaticSize.Y -- Chìa khóa trị bệnh Delta
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = PageContainer
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = Page
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = " " .. pageName
    Title.TextColor3 = Color3.fromRGB(0, 200, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Page
    
    return Page
end

local function CreateTab(tabName, targetPage)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 110, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Btn.Text = tabName
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.Parent = Sidebar
    
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

Pages.Farm.Visible = true
Sidebar:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(0, 150, 255)

-- ==========================================
-- ĐỔ NÚT BẤM (GÁN PARENT CUỐI CÙNG ĐỂ CHỐNG LỖI)
-- ==========================================

-- 1. NÚT TEST FARM (Trang Farm)
local FarmBtn = Instance.new("TextButton")
FarmBtn.Size = UDim2.new(1, -10, 0, 45)
FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
FarmBtn.Text = "BẬT AUTO FARM (Test Hiển Thị)"
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.TextSize = 14
Instance.new("UICorner", FarmBtn).CornerRadius = UDim.new(0, 6)
FarmBtn.Parent = Pages.Farm -- Gán parent cuối cùng!

local isFarm = false
FarmBtn.MouseButton1Click:Connect(function()
    isFarm = not isFarm
    if isFarm then
        FarmBtn.Text = "ĐANG FARM... (TẮT)"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        FarmBtn.Text = "BẬT AUTO FARM"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    end
end)

-- 2. NÚT TĂNG TỐC ĐỘ (Trang Player)
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, -10, 0, 45)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedBtn.Text = "🚀 BẬT HACK TỐC ĐỘ"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.TextSize = 14
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)
SpeedBtn.Parent = Pages.Player -- Gán parent cuối cùng!

SpeedBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        if player.Character.Humanoid.WalkSpeed == 16 then
            player.Character.Humanoid.WalkSpeed = 100
            SpeedBtn.Text = "🛑 TẮT HACK TỐC ĐỘ"
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        else
            player.Character.Humanoid.WalkSpeed = 16
            SpeedBtn.Text = "🚀 BẬT HACK TỐC ĐỘ"
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end
    end
end)
