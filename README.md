# 📱 Documentação – Script `android-builds.sh`

Este script Bash automatiza **todo o processo de build de um APK Android** sem usar o Android Studio, utilizando diretamente as ferramentas oficiais do SDK Android (`aapt2`, `javac`, `d8`, `zipalign`, `apksigner`).

Ele é ideal para **ambientes Linux**, **Termux**, ou para quem prefere **build manual e controlado**.

---

## 📌 Objetivo

Gerar um arquivo **APK assinado (debug)** a partir de um projeto Android em Java, contendo:
- Recursos (`res/`)
- Código Java (`src/`)
- `AndroidManifest.xml`

---

## 📁 Estrutura esperada do projeto

Antes de executar o script, seu projeto deve estar organizado assim:

```
projeto/
├── AndroidManifest.xml
├── res/
│   ├── layout/
│   ├── values/
│   └── drawable/
├── src/
│   └── com/seu/pacote/
│       └── MainActivity.java
└── android-builds.sh
```

---

## ⚙️ Requisitos

### Ferramentas necessárias

Certifique-se de que estas ferramentas estão instaladas e acessíveis no `PATH`:

- `aapt2`
- `javac` (Java 8)
- `d8`
- `zipalign`
- `apksigner`
- `keytool`

### Variáveis de ambiente

A variável abaixo **deve estar configurada**:

```bash
ANDROID_HOME=/caminho/do/Android/Sdk
```

E o Android 31 deve existir:

```
$ANDROID_HOME/platforms/android-31/android.jar
```

---

## ▶️ Como usar

1. Dê permissão de execução:

```bash
chmod +x android-builds.sh
```

2. Execute o script:

```bash
./android-builds.sh
```

3. Informe o nome do APK quando solicitado:

```text
nome do apk: MeuApp
```

📦 APK final:

```
build/apk/MeuApp.apk
```

---

## ✅ Resultado final

```text
APK gerado: build/apk/NomeDoApp.apk
```

Pronto para instalar com:

```bash
adb install NomeDoApp.apk
```

---

## 🚀 Observações finais

- Ideal para **builds manuais**, **CI**, **Termux**
- Não depende de Gradle
- Fácil de adaptar para release

Se quiser, posso:
- Adaptar para **APK release**
- Converter para **script interativo**
- Criar versão com **logs detalhados**
- Ajustar para **outras APIs Android**
