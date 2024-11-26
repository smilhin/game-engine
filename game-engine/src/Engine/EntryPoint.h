#pragma once


#ifdef EG_PLATFORM_WINDOWS

extern Engine::Application* Engine::CreateApplication();

int main(int argc, char** argv)
{

	auto app = Engine::CreateApplication(); 

	Engine::Log::Init();
	EG_CORE_WARN("Initialised Core Logger");
	int a = 5;
	EG_CLIENT_INFO("Initialised Client Logger, Var = {0}", a);

	app->Run();
	delete app;

}

#endif