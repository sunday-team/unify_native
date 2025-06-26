#include <jni.h>

JNIEXPORT jstring JNICALL
Java_com_example_MainActivity_helloFromJNI(JNIEnv* env, jobject thiz) {
    return (*env)->NewStringUTF(env, "Hello from C!");
}
