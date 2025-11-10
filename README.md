# Desafio Técnico: GitHub Repo Viewer (Gendo/SuperAgendador)

## Contexto

Este é um aplicativo de desafio técnico desenvolvido em Flutter para a Gendo/SuperAgendador. O objetivo é consumir a API pública do GitHub para listar os repositórios (públicos e favoritados) de um usuário específico.

O foco principal é demonstrar uma arquitetura limpa e escalável em Flutter, separando a lógica de negócios, o acesso a dados e a interface do usuário (UI).

## 🚀 Requisitos Funcionais

1.  **Entrada de Usuário:** Um campo de texto para que o usuário possa digitar um nome de usuário do GitHub.
2.  **Interface com Abas:** Após a busca, a tela deve exibir uma `TabBar` com duas abas:
    * **Aba 1: Repositórios:** Lista os repositórios *públicos* do usuário.
    * **Aba 2: Favoritados:** Lista os repositórios que o usuário *favoritou* ("starred").
3.  **Consumo de API:** O app deve fazer chamadas de rede para a API do GitHub.
4.  **Exibição de Dados:** Cada item da lista deve mostrar, no mínimo, o nome e a descrição do repositório.

## 🛠️ Tecnologias Utilizadas

* **Flutter (SDK)**: Framework principal para a UI.
* **Dart**: Linguagem de programação.
* **Provider**: Para gerenciamento de estado (State Management) de forma simples e reativa.
* **http**: Pacote para realizar as chamadas de API (HTTP).
* **url_launcher**: (Opcional) Para abrir o link do repositório no navegador ao ser clicado.

## 🎯 Objetivos de Aprendizado (Clean Architecture & SOLID)

* **Arquitetura Limpa (Mobile):** Implementar uma estrutura de pastas clara que separe `Domain` (Entidades), `Data` (Repositórios e DataSources) e `Presentation` (Pages, Widgets, ViewModels).
* **Princípio da Responsabilidade Única (SRP):** Garantir que o ViewModel/Provider tenha a *única* responsabilidade de gerenciar o estado da tela, enquanto o Repositório gerencia *apenas* os dados.
* **Injeção de Dependência (DIP):** Abstrair o acesso à API usando uma interface (Repositório) e injetar sua implementação na camada de apresentação.
* **Consumo de API (Async):** Lidar corretamente com operações assíncronas, estados de `loading`, `error` e `success`.
* **Flutter Widgets:** Composição de widgets complexos como `TabBarView`, `ListView.builder` e `FutureBuilder`/`Consumer`.

## Endpoints da API (GitHub)

| Método | URI | Descrição |
| :--- | :--- | :--- |
| `GET` | `https://api.github.com/users/{username}/repos` | Lista repositórios públicos. |
| `GET` | `https://api.github.com/users/{username}/starred` | Lista repositórios favoritados. |
