#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "testtreemodel.h"

std::multimap<QString, QString> model =
{
    {"parent0", "item00"},
    {"parent0", "item01"},
    {"parent0", "item02"},
    {"parent0", "item03"},
    {"parent1", "item10"},
    {"parent1", "item11"},
    {"parent1", "item12"},
    {"parent2", "item20"},
    {"parent2", "item21"},
    {"parent3", "item30"},
    {"parent4", "item40"}
};

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    TestTreeModel myTreeModel(model);
    engine.rootContext()->setContextProperty("MyTreeModel", &myTreeModel);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
