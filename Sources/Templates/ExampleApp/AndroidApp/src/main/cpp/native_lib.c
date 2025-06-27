#include <jni.h>

// Déclaration de la fonction Swift
extern void swift_platform_bridge_start_application(void);

// Pointeur global vers l'environnement JNI
static JavaVM* g_jvm = NULL;
static jobject g_activity = NULL;

// Fonction appelée par Kotlin pour initialiser l'environnement
JNIEXPORT void JNICALL
Java_com_example_MainActivity_initializeEnvironment(JNIEnv* env, jobject activity) {
    // Sauvegarder le JavaVM pour un usage ultérieur
    (*env)->GetJavaVM(env, &g_jvm);
    
    // Sauvegarder une référence globale à l'activité
    g_activity = (*env)->NewGlobalRef(env, activity);
    
    // Appeler la fonction Swift pour démarrer l'application
    swift_platform_bridge_start_application();
}

// Fonction pour obtenir un JNIEnv* depuis Swift
JNIEnv* get_jni_env() {
    JNIEnv* env;
    if (g_jvm) {
        (*g_jvm)->AttachCurrentThread(g_jvm, &env, NULL);
        return env;
    }
    return NULL;
}

// Fonction de test existante
JNIEXPORT jstring JNICALL
Java_com_example_MainActivity_helloFromJNI(JNIEnv* env, jobject thiz) {
    return (*env)->NewStringUTF(env, "Hello from C!");
}

// Fonction de nettoyage
JNIEXPORT void JNICALL
Java_com_example_MainActivity_cleanup(JNIEnv* env, jobject thiz) {
    if (g_activity) {
        (*env)->DeleteGlobalRef(env, g_activity);
        g_activity = NULL;
    }
}
