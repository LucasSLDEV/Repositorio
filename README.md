# Desafio SQL - GrowDEV | Análise de Dados E-Commerce (Olist Dataset)

Este repositório contém a solução do **Desafio SQL** proposto pela GrowDEV. O objetivo central foi explorar uma base de dados real de e-commerce com cerca de 100 mil pedidos, mapear os relacionamentos entre as tabelas e responder a perguntas estratégicas de negócio por meio do uso de SQL (DQL).



## 📌 Contexto do Projeto

Os dados do projeto foram importados de *Olist Brazilian E-Commerce Public Dataset* (2016-2018). O principal desafio técnico envolveu trabalhar em uma base cujas chaves estrangeiras não foram declaradas formalmente no schema, exigindo a identificação dos relacionamentos diretamente através das chaves primárias e colunas equivalentes[cite: 2].

### Competências Avaliadas
* **Modelagem Implícita e Relacionamentos:** Identificação de cardinalidade, integridade e junções adequadas[cite: 2].
* **Consultas DQL (Básico ao Avançado):** Uso de `SELECT`, `JOINs`, `GROUP BY`, `HAVING`, `Subqueries`, `CASE WHEN`, `CTEs`, `Views`, `Procedures` e `Window Functions`[cite: 2].

---

## 📂 Estrutura dos Arquivos

Os scripts SQL foram divididos rigorosamente por blocos funcionais[cite: 2]. Cada arquivo contém os comentários explicativos sobre cada pergunta de negócio respondida[cite: 2]:

| Arquivo | Descrição |
| :--- | :--- |
| `bloco_A.sql` | Consultas básicas (`SELECT`, `WHERE`, `ORDER BY`, `DISTINCT`)[cite: 2]. |
| `bloco_B.sql` | Junções de tabelas (`INNER JOIN`, `LEFT JOIN`) e consistência relacional[cite: 2]. |
| `bloco_C.sql` | Agregações de métricas (`SUM`, `AVG`, `COUNT`), `GROUP BY` e filtros `HAVING`[cite: 2]. |
| `bloco_D.sql` | Subqueries simples, correlacionadas e filtros dinâmicos com agregadores[cite: 2]. |
| `bloco_E.sql` | Regras e classificações condicionais com `CASE WHEN`[cite: 2]. |
| `bloco_F.sql` | Estruturação de consultas com `CTE` (Common Table Expressions)[cite: 2]. |
| `bloco_G.sql` | Construção de `Views` analíticas reutilizáveis[cite: 2]. |
| `bloco_H.sql` | `Procedures`/`Functions` de leitura parametrizadas[cite: 2]. |
| `bloco_I.sql` | Análises avançadas com `Window Functions` (`RANK`, `LAG`, `SUM OVER`)[cite: 2]. |

---

## 🛠️ Tecnologias e Ferramentas Utilizadas

* **SGBD:** PostgreSQL (Local)[cite: 2]
* **Cliente SQL:** DBeaver Community[cite: 2]
* **Dataset:** Olist Brazilian E-Commerce Dataset (Kaggle)[cite: 2]

---

## 📈 Principais Insights Encontrados

*(Substitua pelos dados e padrões identificados durante as suas consultas)*

* **Faturamento Geográfico:** Concentração massiva das vendas em estados da Região Sudeste, impulsionada por prazos de frete mais competitivos[cite: 2].
* **Desempenho de Entregas:** A maior parte dos pedidos é entregue dentro ou antes do prazo estimado, enquanto pedidos atrasados impactam diretamente nas notas das avaliações[cite: 2].
* **Categorias Críticas:** Identificação de categorias de produtos que registram alto volume de vendas, porém com médias de avaliação abaixo de 3.0[cite: 2].

---

## 🚀 Como Executar o Projeto

1. Clone este repositório:
   ```bash
   git clone [https://github.com/SEU-USUARIO/SEU-REPOSITORIO.git](https://github.com/SEU-USUARIO/SEU-REPOSITORIO.git)
