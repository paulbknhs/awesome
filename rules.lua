--      ██████╗ ██╗   ██╗██╗     ███████╗███████╗
--      ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
--      ██████╔╝██║   ██║██║     █████╗  ███████╗
--      ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
--      ██║  ██║╚██████╔╝███████╗███████╗███████║
--      ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================

local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

-- define screen height and width
local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width

-- define module table
local rules = {}

-- ===================================================================
-- Rules
-- ===================================================================

-- return a table of client rules including provided keys / buttons
function rules.create(clientkeys, clientbuttons)
	local rofi_rule = {}

	if beautiful.name == "mirage" then
		rofi_rule = {
			rule_any = { name = { "rofi" } },
			properties = { floating = true, titlebars_enabled = false },
			callback = function(c)
				if beautiful.name == "mirage" then
					awful.placement.left(c)
				end
			end,
		}
	else
		rofi_rule = {
			rule_any = { name = { "rofi" } },
			properties = { maximized = true, floating = true, titlebars_enabled = false },
		}
	end

	return {
		-- All clients will match this rule.
		{
			rule = {},
			properties = {
				titlebars_enabled = beautiful.titlebars_enabled,
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				keys = clientkeys,
				buttons = clientbuttons,
				screen = awful.screen.preferred,
				placement = awful.placement.centered,
			},
		},
		-- Floating clients.
		{
			rule_any = {
				instance = {
					"DTA",
					"copyq",
				},
				class = {
					"Nm-connection-editor",
					"Blueman-manager",
				},
				name = {
					"Event Tester",
					"Steam Guard - Computer Authorization Required",
				},
				role = {
					"pop-up",
					"GtkFileChooserDialog",
				},
				type = {
					"dialog",
				},
			},
			properties = { floating = true },
		},

		-- Fullscreen clients
		{
			rule_any = {
				class = {
					"Terraria.bin.x86",
				},
			},
			properties = { fullscreen = true },
		},

		-- "Switch to tag"
		-- These clients make you switch to their tag when they appear
		{
			rule_any = {
				class = {
					"firefox",
					"google-chrome-stable",
				},
			},
			properties = { switchtotag = true },
		},
		-- Terminal emulators
		ruled.client.append_rule({
			id = "terminals",
			rule_any = {
				class = {
					"URxvt",
					"XTerm",
					"UXTerm",
					"kitty",
					"K3rmit",
				},
			},
			properties = {
				tag = "1",
				switch_to_tags = true,
				size_hints_honor = false,
				titlebars_enabled = true,
			},
		}),

		-- Browsers and chats
		ruled.client.append_rule({
			id = "internet",
			rule_any = {
				class = {
					"firefox",
					"Tor Browser",
					"discord",
					"Chromium",
					"google-chrome-stable",
					"TelegramDesktop",
				},
			},
			properties = {
				tag = "2",
			},
		}),

		-- Text editors and word processing
		ruled.client.append_rule({
			id = "text",
			rule_any = {
				class = {
					"Geany",
					"Atom",
					"Subl3",
					"code-oss",
					"Kate",
				},
				name = {
					"LibreOffice",
					"libreoffice",
				},
			},
			properties = {
				tag = "3",
			},
		}),

		-- File managers
		ruled.client.append_rule({
			id = "files",
			rule_any = {
				class = {
					"ark",
					"Nemo",
					"File-roller",
					"Thunar",
				},
			},
			properties = {
				tag = "4",
				switch_to_tags = true,
			},
		}),

		-- Multimedia
		ruled.client.append_rule({
			id = "multimedia",
			rule_any = {
				class = {
					"vlc",
					"spotify",
				},
			},
			properties = {
				tag = "5",
				switch_to_tags = true,
				placement = awful.placement.centered,
			},
		}),

		-- Gaming
		ruled.client.append_rule({
			id = "gaming",
			rule_any = {
				class = {
					"lutris",
					"steam",
					"Steam",
					"stardew valley",
					"supertuxkart",
				},
				name = { "Steam", "Stardew Valley", "Lutris" },
			},
			properties = {
				tag = "6",
				skip_decoration = true,
				switch_to_tags = true,
				placement = awful.placement.centered,
			},
		}),

		-- Multimedia Editing
		ruled.client.append_rule({
			id = "graphics",
			rule_any = {
				class = {
					"Gimp-2.10",
					"Inkscape",
					"Flowblade",
					"Photoshop",
				},
			},
			properties = {
				tag = "9",
				switch_to_tags = true,
			},
		}),

		-- Sandboxes and VMs
		ruled.client.append_rule({
			id = "sandbox",
			rule_any = {
				class = {
					"VirtualBox Manage",
					"VirtualBox Machine",
					"Gnome-boxes",
					"Virt-manager",
				},
			},
			properties = {
				tag = "8",
				switch_to_tags = true,
			},
		}),

		-- Spotify
		ruled.client.append_rule({
			id = "spotify",
			rule_any = {
				class = {
					"Spotify",
				},
			},
			properties = {
				tag = "7",
			},
		}),
		-- Visualizer
		{
			rule_any = { name = { "cava", "rofi" } },
			properties = {
				floating = true,
				maximized_horizontal = true,
				sticky = true,
				ontop = false,
				skip_taskbar = true,
				below = true,
				focusable = false,
				height = screen_height * 0.40,
				opacity = 0.6,
			},
			callback = function(c)
				decorations.hide(c)
				awful.placement.bottom(c)
			end,
		},

		-- rofi rule determined above
		rofi_rule,

		-- File chooser dialog
		{
			rule_any = { role = { "GtkFileChooserDialog" } },
			properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.65 },
		},

		-- Pavucontrol & Bluetooth Devices
		{
			rule_any = { class = { "Pavucontrol" }, name = { "blueman-applet" } },
			properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.45 },
		},
	}
end

-- return module table
return rules
