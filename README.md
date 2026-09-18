# Desafio SQL - GrowDEV | Análise de Dados E-Commerce (Olist Dataset)

Este repositório contém a solução do **Desafio SQL** proposto pela GrowDEV. O objetivo central foi explorar uma base de dados real de e-commerce com cerca de 100 mil pedidos, mapear os relacionamentos entre as tabelas e responder a perguntas estratégicas de negócio por meio do uso de SQL (DQL).

## 📌 Contexto do Projeto

Os dados do projeto foram importados de *Olist Brazilian E-Commerce Public Dataset* (2016-2018). O principal desafio técnico envolveu trabalhar em uma base cujas chaves estrangeiras não foram declaradas formalmente no schema, exigindo a identificação dos relacionamentos diretamente através das chaves primárias e colunas equivalentes.

### Competências Avaliadas
* **Modelagem Implícita e Relacionamentos:** Identificação de cardinalidade, integridade e junções adequadas.
* **Consultas DQL (Básico ao Avançado):** Uso de `SELECT`, `JOINs`, `GROUP BY`, `HAVING`, `Subqueries`, `CASE WHEN`, `CTEs`, `Views`, `Procedures` e `Window Functions`.

---

## 📂 Estrutura dos Arquivos

Os scripts SQL foram divididos rigorosamente por blocos funcionais. Cada arquivo contém os comentários explicativos sobre cada pergunta de negócio respondida:

| Arquivo | Descrição |
| :--- | :--- |
| `bloco_A.sql` | Consultas básicas (`SELECT`, `WHERE`, `ORDER BY`, `DISTINCT`). |
| `bloco_B.sql` | Junções de tabelas (`INNER JOIN`, `LEFT JOIN`) e consistência relacional. |
| `bloco_C.sql` | Agregações de métricas (`SUM`, `AVG`, `COUNT`), `GROUP BY` e filtros `HAVING`. |
| `bloco_D.sql` | Subqueries simples, correlacionadas e filtros dinâmicos com agregadores. |
| `bloco_E.sql` | Regras e classificações condicionais com `CASE WHEN`. |
| `bloco_F.sql` | Estruturação de consultas com `CTE` (Common Table Expressions). |
| `bloco_G.sql` | Construção de `Views` analíticas reutilizáveis. |
| `bloco_H.sql` | `Procedures`/`Functions` de leitura parametrizadas. |
| `bloco_I.sql` | Análises avançadas com `Window Functions` (`RANK`, `LAG`, `SUM OVER`). |

---

## 🛠️ Tecnologias e Ferramentas Utilizadas

* **SGBD:** PostgreSQL (Local)
* **Cliente SQL:** DBeaver Community
* **Dataset:** Olist Brazilian E-Commerce Dataset (Kaggle)

---

## 📈 Principais Insights Encontrados

*(Substitua pelos dados e padrões identificados durante as suas consultas)*

* **Faturamento Geográfico:** Concentração massiva das vendas em estados da Região Sudeste, impulsionada por prazos de frete mais competitivos.
* **Desempenho de Entregas:** A maior parte dos pedidos é entregue dentro ou antes do prazo estimado, enquanto pedidos atrasados impactam diretamente nas notas das avaliações.
* **Categorias Críticas:** Identificação de categorias de produtos que registram alto volume de vendas, porém com médias de avaliação abaixo de 3.0.

---

## 🚀 Como Executar o Projeto

1. Clone este repositório:
   ```bash
   git clone [https://github.com/LucasSLDEV]([https://https://github.com/LucasSLDEV](https://github.com/LucasSLDEV)
