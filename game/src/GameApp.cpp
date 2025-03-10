#include <Engine.h>


class ExampleLayer : public Engine::Layer
{
public:
	ExampleLayer()
		:Layer("Example")
	{

	}

	void OnUpdate() override
	{
		EG_INFO("ExampleLayer::Update");
	}

	void OnEvent(Engine::Event& event) override
	{
		EG_TRACE("{0}", event.ToString());
	}
};

class GameApp : public Engine::Application
{

public:
	GameApp()
	{
		PushLayer(new ExampleLayer());
	}
	~GameApp()
	{

	}

};


Engine::Application* Engine::CreateApplication()
{
	return new GameApp();
}