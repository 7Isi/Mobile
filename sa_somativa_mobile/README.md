---

# App de Registro de Ponto com Geolocalização e Biometria

Aplicativo móvel desenvolvido em **Flutter** que permite aos funcionários registrar seu ponto de trabalho de forma segura e conveniente, utilizando geolocalização e biometria para validação.

---

## Funcionalidades

### Autenticação Múltipla

* Login tradicional com NIF/email e senha.
* Reconhecimento facial via biometria para acesso rápido e seguro.

### Controle de Localização

* Verificação de geolocalização em tempo real.
* Registro permitido apenas dentro do raio de 100 metros do local de trabalho.
* Validação automática da proximidade antes do registro.

### Registro de Ponto

* Captura automática da data e hora do registro.
* Armazenamento da localização exata no momento do registro.
* Histórico completo de registros para consulta.

### Integração com Firebase

* Autenticação de usuários via **Firebase Auth**.
* Armazenamento em tempo real dos registros usando **Cloud Firestore**.
* Sincronização automática dos dados entre dispositivos.

---

## Tecnologias Utilizadas

* **Flutter** - Framework principal para desenvolvimento mobile.
* **Dart** - Linguagem de programação.
* **Firebase Auth** - Serviço de autenticação de usuários.
* **Cloud Firestore** - Banco de dados NoSQL para armazenamento em nuvem.
* **Geolocator** - Serviço para obtenção da geolocalização do dispositivo.
* **Local Auth** - Autenticação biométrica (reconhecimento facial).
* **Flutter Map** - Exibição de mapas interativos (opcional).

---

## Pré-requisitos

* Flutter SDK 3.0 ou superior instalado.
* Dispositivo móvel com GPS habilitado.
* Biometria facial disponível (opcional para login).
* Conta Firebase configurada com Auth e Firestore.

---

