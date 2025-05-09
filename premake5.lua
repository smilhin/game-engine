workspace "game-engine"
    architecture "x64"

    configurations 
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories realtive to the root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "game-engine/vendor/glfw/include"
IncludeDir["GLAD"] = "game-engine/vendor/glad/include"

include "game-engine/vendor/glfw"
include "game-engine/vendor/glad"

project "game-engine"
    location "game-engine"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "egpch.h"
    pchsource "game-engine/src/egpch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs 
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.GLAD}"
    }

    links 
    {
        "GLFW",
        "GLAD",
        "opengl32.lib",
	    "dwmapi.lib"
    }

    buildoptions
    {
        "/utf-8"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines 
        {
            "EG_PLATFORM_WINDOWS",
            "EG_BUILD_DLL",
            "GLFW_INCLUDE_NONE"
        }

        postbuildcommands 
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/game")
        }
    
    filter "configurations:Debug"
        defines "EG_DEBUG"
        buildoptions "/MDd"
        staticruntime "off"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines "EG_RELEASE"
        buildoptions "/MD"
        staticruntime "off"
        runtime "Release"
        optimize "On"

    filter "configurations:DIst"
        defines "EG_DIST"
        buildoptions "/MD"
        optimize "On"

project "game"
    location "game"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")   

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs 
    {
        "game-engine/vendor/spdlog/include",
        "game-engine/src"
    }

    links 
    {
        "game-engine"
    }
    
    buildoptions
    {
        "/utf-8"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines 
        {
            "EG_PLATFORM_WINDOWS"
        }
    
    filter "configurations:Debug"
        defines "EG_DEBUG"
        buildoptions "/MDd"
        staticruntime "off"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines "EG_RELEASE"
        buildoptions "/MD"
        staticruntime "off"
        runtime "Release"
        optimize "On"

    filter "configurations:DIst"
        defines "EG_DIST"
        buildoptions "/MD"
        optimize "On"