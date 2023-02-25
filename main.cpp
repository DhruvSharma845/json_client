#include <nlohmann/json.hpp>

int main(int argc, char **argv)
{
    nlohmann::json ex1 = nlohmann::json::parse(R"({ "pi": 3.141, "happy": true })");

    return 0;
}