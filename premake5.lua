workspace "game-engine"
    architecture "x64"

    configurations 
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
project "game-engine"
    location "game-engine"
    kind "SharedLib"
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
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include"
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
            "EG_BUILD_DLL"
        }

        postbuildcommands 
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/game")
        }
    
    filter "configurations:Debug"
        defines "EG_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "EG_RELEASE"
        optimize "On"

    filter "configurations:DIst"
        defines "EG_DIST"
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
        symbols "On"

    filter "configurations:Release"
        defines "EG_RELEASE"
        optimize "On"

    filter "configurations:DIst"
        defines "EG_DIST"
        optimize "On"