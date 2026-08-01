#include <QApplication>
#include <QQmlApplicationEngine>

#include "environment.h"

int main(int argc, char *argv[])
{
    set_qt_environment();
    qputenv("QT_QUICK3D_MEDIUM_PRECISION", "1");
    qputenv("QSG_RENDER_LOOP", "threaded");

#ifdef __ANDROID__

    QAndroidRaaSApplication app(argc, argv);
    setSustainedPerformanceMode(app);

    QAndroidSurfaceRenderEngine *engine = new QAndroidSurfaceRenderEngine();

    const QUrl url(serviceQmlFile);
#else
    QApplication app(argc, argv);
    app.setOrganizationName("Qt Group");
    app.setOrganizationDomain("qt.io");
    app.setApplicationName("Outpace Square");
    QQmlApplicationEngine *engine = new QQmlApplicationEngine();
    const QUrl url(mainQmlFile);
#endif

    engine->addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine->addImportPath(":/");

    engine->load(url);

    return app.exec();
}
