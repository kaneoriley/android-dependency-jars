# Android Dependency Jars
Github hosted Maven repo for Android dependency jars, so I can access the classes in non-Android modules. 
<br>
## Usage
* Add the repository
<br>
```gradle
repositories {
    maven {
        url = 'https://github.com/oriley-me/android-dependency-jars/raw/master'
    }
}
```
* Add the configuration and dependencies
<br>
```gradle
configurations {
    bundled
    configurations.compile.extendsFrom(configurations.bundled)
}

dependencies {
    ...
    // Normal dependencies here
    ...

    // Use bundled to include classes in jar, but not as a POM dependency
    bundled 'android:support-v7-preference:23.4.0'
    bundled 'android:support-v4:23.4.0'
    bundled 'android:framework:23'
}

// Bundle the classes in the output jar
jar {
    from {
        configurations.bundled.collect { it.isDirectory() ? it : zipTree(it) }
    }
}
```
<br>
__NOTE: Do not use this for building modules specifically targetted for Android.
         This is purely a workaround to allow referencing previously unusable
         classes from i.e. an annotation processor.__
