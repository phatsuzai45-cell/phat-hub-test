-- ==========================================
-- 🔥 PHAT HUB V-PRO | PREMIUM EDITION 🔥
-- Tối ưu hóa 100% cho Delta / Fluxus
-- ==========================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 Phat Hub V-Pro | Premium Edition",
    LoadingTitle = "Đang khởi động Phat Hub...",
    LoadingSubtitle = "Bản quyền thuộc về Phat",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhatHubPro",
        FileName = "Config_V1"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    -- 🔐 BẬT HỆ THỐNG KEY ĐỂ TRÔNG PRO HƠN
    KeySystem = true,
    KeySettings = {
        Title = "Phat Hub | Xác Thực",
        Subtitle = "Vui lòng nhập Key để sử dụng",
        Note = "Mật khẩu là: PHATVIP (Viết hoa)",
        FileName = "PhatHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"PHATVIP"} 
    }
})

-- ==========================================
-- ⚔️ TAB 1: COMBAT & FARM
-- ==========================================
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)

local VirtualUser = game:GetService("VirtualUser")
local isAutoClick = false
local weaponToEquip = ""

CombatTab:CreateSection("Cài đặt Vũ Khí")

-- Nút chọn vũ khí để tự động cầm
local WeaponDropdown = CombatTab:CreateDropdown({
    Name = "Chọn Vũ Khí Để Tự Cầm",
    Options = {"Melee", "Sword", "Fruit"},
    CurrentOption = {"Melee"},
    MultipleOptions = false,
    Flag = "WeaponSelect",
    Callback = function(Option)
        weaponToEquip = Option[1]
    end,
})

CombatTab:CreateSection("Chức năng Đánh")

CombatTab:CreateToggle({
    Name = "⚡ Bật Auto Click (Chém siêu tốc)",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        isAutoClick = Value
        if isAutoClick then
            task.spawn(function()
                while isAutoClick do
                    task.wait(0.05) -- Tốc độ chém siêu nhanh
                    -- Tự động cầm vũ khí
                    if game.Players.LocalPlayer.Character then
                        for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if tool:IsA("Tool") and tool.ToolTip == weaponToEquip then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                            end
                        end
                    end
                    -- Tự động click
                    VirtualUser:CaptureController()
                    VirtualUser:Button1Down(Vector2.new(0,0))
                end
            end)
        end
    end,
})

-- ==========================================
-- 👤 TAB 2: PLAYER HACKS
-- ==========================================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSection("Tùy chỉnh Di chuyển")

PlayerTab:CreateSlider({
    Name = "🏃 Hack Tốc Độ Chạy",
    Range = {16, 150},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "SpeedHack",
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

PlayerTab:CreateSlider({
    Name = "🚀 Hack Sức Bật (Nhảy Cao)",
    Range = {50, 300},
    Increment = 1,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "JumpHack",
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end,
})

-- Tính năng Nhảy Vô Hạn (Nhảy trên không trung)
local UserInputService = game:GetService("UserInputService")
local infJumpToggle = false

PlayerTab:CreateToggle({
    Name = "☁️ Nhảy Vô Hạn (Infinite Jump)",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(Value)
        infJumpToggle = Value
    end,
})

UserInputService.JumpRequest:Connect(function()
    if infJumpToggle and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ==========================================
-- ⚙️ TAB 3: TỐI ƯU & MISC
-- ==========================================
local MiscTab = Window:CreateTab("⚙️ Tối Ưu", 4483362458)

MiscTab:CreateButton({
    Name = "🗑️ Tăng FPS Tối Đa (Giảm Lag)",
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                obj:Destroy()
            end
        end
        Rayfield:Notify({
            Title = "Đã tối ưu!",
            Content = "Đồ họa đã được giảm mức thấp nhất.",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

MiscTab:CreateButton({
    Name = "☀️ Bật Sáng Toàn Bản Đồ (Fullbright)",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
    end,
})

-- ==========================================
-- ℹ️ TAB 4: THÔNG TIN (CREDITS)
-- ==========================================
local CreditTab = Window:CreateTab("ℹ️ Thông tin", 4483362458)

CreditTab:CreateLabel("💡 Phat Hub V-Pro")
CreditTab:CreateLabel("👤 Phát triển bởi: Phát")
CreditTab:CreateLabel("🛡️ Trạng thái: An toàn (Bypass Delta)")

-- Bấm nút này sẽ copy một cái gì đó cho ngầu
CreditTab:CreateButton({
    Name = "Sao chép link Discord (Mẫu)",
    Callback = function()
        setclipboard("https://discord.gg/phathubvip")
        Rayfield:Notify({
            Title = "Thành công",
            Content = "Đã copy link Discord vào khay nhớ tạm!",
            Duration = 2,
            Image = 4483362458
        })
    end,
})
