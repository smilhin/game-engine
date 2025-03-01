#pragma once


#ifdef EG_PLATFORM_WINDOWS

extern Engine::Application* Engine::CreateApplication();

int main(int argc, char** argv)
{
	Engine::Log::Init();

	auto app = Engine::CreateApplication(); 

	EG_CORE_WARN("Initialised Core Logger: SUCCESS");
	EG_INFO("Initialised Client Logger: SUCCESS");

	app->Run();
	delete app;

}

#endif