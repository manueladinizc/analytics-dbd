# Desafio Final de Dados

## Documentos

[Diagrama conceitual](/documents/conceptual_diagram_adw.pdf)

[Relatório do projeto](/documents/report_adw.pdf)

[Arquivo para o dashboard](/documents/bi_adw.pbix)

[Video com a apresentação do dashboard](https://youtu.be/iivDvnnTS80)

[Notebook de previsão de demanda](/analytics_adw/sales_analytics.ipynb)

## Resumo do projeto

O projeto para a Adventure Works foca em transformar a análise de dados da empresa com três etapas principais:

1. Modelagem Dimensional: Criação de um data warehouse usando Google BigQuery e dbt, organizando dados de vendas e produção.
2. Visualização de Dados: Desenvolvimento de dashboards interativos para análise visual dos dados.
3. Previsão de Demanda: Aplicação de modelos de séries temporais para prever a demanda futura e identificar padrões sazonais.


## Instruções

*Configuração de ambiente*

1. Clone o repositório
```
  git clone https://github.com/manueladinizc/analytics-dbd.git
  cd analytics-dbt 
```

2. Criar ambiente virtual
  ```
  python -m venv venv
  source venv/bin/activate
  ```

3. Instalar dependencias
```
  pip install -r requirements.txt
```

4. Configure o perfil do DBT no arquivo profiles.yml

5. Certifique-se de que as credenciais do BigQuery estão corretamente configuradas no arquivo profiles.yml

6. Rodar e testar modelo
```
  dbt run

  dbt test
```