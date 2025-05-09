project "GLAD"

	kind "StaticLib"

	language "C"



	targetdir ("bin/" .. outputdir .. "/%{prj.name}")

	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")



	files
	{

		"include/glad/glad.h",

		"include/khr/khrplatform.h",

		"src/glad.c"

	}

	includedirs 
	{
		"include"
	}

	filter "configurations:Debug"

		runtime "Debug"

		symbols "on"



	filter "configurations:Release"

		runtime "Release"

		optimize "on"

	filter "system:windows"
		systemversion "latest"
		staticruntime "on"
	
	filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"