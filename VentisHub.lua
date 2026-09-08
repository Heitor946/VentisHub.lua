--[[
    VENTIS HUB
    Free Version
    Created by Ventis
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer

-- =========================
-- CONFIG
-- =========================

local HUB_NAME = "Ventis Hub"

local COLORS = {
    Background = Color3.fromRGB(8, 14, 10),
    Card = Color3.fromRGB(14, 24, 17),
    Header = Color3.fromRGB(18, 35, 23),
    Green = Color3.fromRGB(70, 220, 120),
    DarkGreen = Color3.fromRGB(25, 100, 50),
    Text = Color3.fromRGB(225, 255, 235),
    SubText = Color3.fromRGB(145, 185, 155),
    Red = Color3.fromRGB(255, 90, 90)
}

-- =========================
-- FUNÇÕES
-- =========================

local function New(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Tween(object, properties, duration)
    TweenService:Create(
        object,
        TweenInfo.new(
            duration or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    ):Play()
end

local function Notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = HUB_NAME,
            Text = text,
            Duration = 3
        })
    end)
end

-- =========================
-- GUI
-- =========================

local Gui = New("ScreenGui", {
    Name = "VentisHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Global
}, game:GetService("CoreGui"))

local Background = New("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.45,
    BorderSizePixel = 0
}, Gui)

local Card = New("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(400, 250),
    BackgroundColor3 = COLORS.Card,
    BorderSizePixel = 0
}, Gui)

New("UICorner", {
    CornerRadius = UDim.new(0, 15)
}, Card)

New("UIStroke", {
    Color = COLORS.Green,
    Thickness = 1.5,
    Transparency = 0.3
}, Card)

-- =========================
-- HEADER
-- =========================

local Header = New("Frame", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = COLORS.Header,
    BorderSizePixel = 0
}, Card)

New("UICorner", {
    CornerRadius = UDim.new(0, 15)
}, Header)

New("TextLabel", {
    Position = UDim2.fromOffset(18, 0),
    Size = UDim2.new(1, -60, 1, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = HUB_NAME,
    TextColor3 = COLORS.Text,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left
}, Header)

local Close = New("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -12, 0.5, 0),
    Size = UDim2.fromOffset(28, 28),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "×",
    TextColor3 = COLORS.Red,
    TextSize = 22
}, Header)

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- =========================
-- INFORMAÇÕES
-- =========================

local GameName = "Unknown Game"

pcall(function()
    local MarketplaceService = game:GetService("MarketplaceService")
    local Info = MarketplaceService:GetProductInfo(game.PlaceId)

    if Info and Info.Name then
        GameName = Info.Name
    end
end)

New("TextLabel", {
    Position = UDim2.fromOffset(20, 72),
    Size = UDim2.new(1, -40, 0, 25),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "Olá, " .. Player.DisplayName .. " 👋",
    TextColor3 = COLORS.Text,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left
}, Card)

New("TextLabel", {
    Position = UDim2.fromOffset(20, 102),
    Size = UDim2.new(1, -40, 0, 35),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Jogo: " .. GameName,
    TextColor3 = COLORS.SubText,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left
}, Card)

local Status = New("TextLabel", {
    Position = UDim2.fromOffset(20, 145),
    Size = UDim2.new(1, -40, 0, 22),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "● Free Version",
    TextColor3 = COLORS.Green,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Center
}, Card)

-- =========================
-- BOTÃO FREE
-- =========================

local FreeButton = New("TextButton", {
    Position = UDim2.new(0, 20, 1, -58),
    Size = UDim2.new(1, -40, 0, 40),
    BackgroundColor3 = COLORS.DarkGreen,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Font = Enum.Font.GothamBold,
    Text = "FREE VERSION",
    TextColor3 = COLORS.Text,
    TextSize = 14
}, Card)

New("UICorner", {
    CornerRadius = UDim.new(0, 9)
}, FreeButton)

New("UIStroke", {
    Color = COLORS.Green,
    Thickness = 1,
    Transparency = 0.25
}, FreeButton)

FreeButton.MouseEnter:Connect(function()
    Tween(FreeButton, {
        BackgroundColor3 = Color3.fromRGB(40, 135, 70)
    }, 0.12)
end)

FreeButton.MouseLeave:Connect(function()
    Tween(FreeButton, {
        BackgroundColor3 = COLORS.DarkGreen
    }, 0.15)
end)

FreeButton.MouseButton1Click:Connect(function()

    Status.Text = "● Free Version ativada!"
    Status.TextColor3 = COLORS.Green

    Notify("Ventis Hub ativado! 💚")

    -- ==========================================
    -- COLOQUE AQUI AS FUNÇÕES DO SEU HUB
    -- ==========================================

    local GameId = game.GameId

    if GameId == 994732206 then

        -- Blox Fruits
        print("[Ventis Hub] Blox Fruits Free")

    elseif GameId == 9186719164 then

        -- Sailor Piece
        print("[Ventis Hub] Sailor Piece Free")

    elseif GameId == 8191429227 then

        -- Cut Trees
        print("[Ventis Hub] Cut Trees Free")

    else

        Status.Text = "● Jogo não suportado"
        Status.TextColor3 = Color3.fromRGB(255, 170, 70)

        Notify("Este jogo ainda não possui versão Free.")

    end
end)

Notify("Ventis Hub carregado! 💚")
