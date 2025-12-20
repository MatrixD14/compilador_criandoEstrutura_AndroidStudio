# 📦 o que é, como usa android-init.sh e o android-builds.sh

Este guia explica **como criar e gerar um APK Android** usando apenas dois scripts Bash, sem Android Studio e sem Gradle.

A ideia é bem simples:

1. **`android-init.sh`** → cria a estrutura do projeto
2. **`android-builds.sh`** → compila e gera o APK

---

## 🎯 Objetivo

Permitir que qualquer pessoa:
- Crie um projeto Android em Java
- Use uma estrutura organizada (core + android)
- Gere um APK funcional usando apenas scripts

Tudo de forma leve e controlada.

---

## 🧱 Passo 1 – Criar o projeto (`android-init.sh`)

Execute:

```bash
./android-init.sh MeuApp com.exemplo.app
```

Informe:

```text
nome do app: MeuApp
package ex.: com.exemplo.app: com.exemplo.app
```

Isso cria um **novo diretório do projeto** com tudo pronto para começar.

---

## 📁 Estrutura de pasta com sera criada

```text
MeuApp/
├── AndroidManifest.xml
├── src/
│   └── com/exemplo/app/
│       ├── core/
│       │   └── AppCore.java
│       └── android/
│           └── MainActivity.java
├── res/
│   └── values/
│       └── strings.xml
├── assets/
└── libs/
```

### Organização

- **core/** → lógica do app (não depende do Android)
- **android/** → interface e código específico da plataforma

---

## 🧠 O que o projeto inicial já faz

- Define o **package** corretamente
- Cria o **AndroidManifest.xml** básico
- Gera uma `MainActivity`
- Cria uma classe `AppCore` separada da UI
- Mostra um app funcional com botão e contador

A interface é feita **diretamente em Java**, sem XML.

---

## 🧩 Separação de responsabilidades

### AppCore (lógica)

- Não depende de Android
- Pode ser reutilizado ou testado isoladamente
- Controla o estado do app (ex: contador)

### MainActivity (UI)

- Cria a interface
- Chama o core quando o usuário interage

Essa separação facilita manutenção e evolução do projeto.

---

## 🛠️ Passo 2 – Gerar o APK (`android-builds.sh`)

Dentro da pasta do projeto, execute:

```bash
./android-builds.sh
```
- ele vai pega o nome a pasta automaticamente
---

## 📦 Resultado

Ao final do processo:

```text
build/apk/NomePath.apk
```

O APK:
- Já está alinhado
- Já está assinado (debug)
- Já pode ser instalado

## 🔗‍️ Como connect e instala o apk o adb no dispositivo

```pair
adb pair ip:port codigo
```
- o ip:port e o codigo voce acha no **depuração por wifi** no dispositivo, tem que clica no **parear dispositivo**
  
```connected
adb connect ip:port
```
- o ip:port voce acha no **depuração por wifi** no dispositivo na tela de inicio dela, vai esta mais ou menos assim **123.456.78.90:12345**

```bash
adb install MeuApp.apk
```


❗e mais o meno como esta no video, mais seria pc conecta no dispositivo, os comandos vai ser no pc ❗
  
  link: https://youtu.be/APolZrPHSms?si=alNwfnL0FddGzTaV
  
---

## 🔁 Fluxo resumido

```text
android-init.sh
        ↓
Projeto criado
        ↓
Editar código (opcional)
        ↓
android-builds.sh
        ↓
APK pronto
```

---

## ⚠️ Observações importantes

- É necessário ter o **Android SDK configurado**
- A variável `ANDROID_HOME` deve estar definida
- O projeto usa **API 31**
- O APK gerado é **debug**
- link do youtube, como baixa e configura: https://youtu.be/2cvwXCd3htc?si=EXSPRUPv71FWQqMk

---

## 🚀 Para quem este fluxo é ideal

- Quem quer aprender Android por baixo dos panos
- Quem usa **Linux / Termux**
- Quem prefere controle total do build
- **Quem não quer depender de Gradle, compilador pesado**
