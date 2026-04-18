-- Gọi thư viện Rayfield (Bao mượt trên Delta, không bao giờ mất nút)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub | Delta Fixed Version",
    LoadingTitle = "Đang khởi động Phat Hub...",
    LoadingSubtitle = "Bản hoàn chỉnh dùng Rayfield",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "PhatHub"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

-- ==========================================
-- ☁️ TAB 1: AUTO FARM (Đã thêm Auto Click)
-- ==========================================
local FarmTab = Window:CreateTab("☁️ Farm", 4483362458) -- Icon đám mây

local VirtualUser = game:GetService("VirtualUser")
local isAutoClick = false

FarmTab:CreateToggle({
    Name = "Bật Auto Click (Tự động chém/đánh)",
    CurrentValue = false,
    Flag = "AutoClick", 
    Callback = function(Value)
        isAutoClick = Value
        
        -- Tạo vòng lặp tàng hình để tự động click chuột
        if isAutoClick then
            task.spawn(function()
                while isAutoClick do
                    task.wait(0.1) -- Tốc độ chém (0.1 giây / lần)
                    -- Lệnh ép hệ thống tự động nhấn chuột trái
                    VirtualUser:CaptureController()
                    VirtualUser:Button1Down(Vector2.new(0,0))
                end
            end)
        end
    end,
})

FarmTab:CreateLabel("Lưu ý: Hãy trang bị Kiếm hoặc Võ trước khi bật Auto Click!")

-- ==========================================
-- 👤 TAB 2: PLAYER (Hack Tốc độ)
-- ==========================================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSlider({
    Name = "Hack Tốc Độ (WalkSpeed)",
    Range = {16, 120}, -- Kéo từ 16 (Bình thường) đến 120 (Siêu nhân)
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "SpeedSlider", 
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

-- ==========================================
-- ⚡ TAB 3: TỐI ƯU HÓA (Tăng FPS)
-- ==========================================
local FpsTab = Window:CreateTab("⚡ Tối Ưu", 4483362458)

FpsTab:CreateButton({
    Name = "Tăng FPS (Xóa Texture & Bóng Râm)",
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                obj:Destroy()
            end
        end
        
        -- Hiện thông báo xịn xò của Rayfield
        Rayfield:Notify({
            Title = "Thành công!",
            Content = "Đã xóa toàn bộ chi tiết thừa. Game sẽ mượt hơn!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})
