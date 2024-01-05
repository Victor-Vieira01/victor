
# Tratamento de dados -----------------------------------------------------

# Trata tabela da DBNOMICS
dados <- dados_brutos %>% 
  dplyr::select(
    "data" = "period",
    "pais" = "country",
    "variavel" = "indicator",
    "valor" = "value",
    "atualizacao" = "indexed_at"
    ) %>% 
  dplyr::mutate(
    variavel = dplyr::recode(
      .x = variavel,
      "FP.CPI.TOTL.ZG" = "Inflação (anual, %)",
      "FR.INR.DPST" = "Juros (depósito, %)",
      "NY.GDP.MKTP.KD.ZG" = "PIB (cresc. anual, %)",
      "PA.NUS.FCRF" = "Câmbio (média, UMC/US$)",
      "SL.UEM.TOTL.NE.ZS" = "Desemprego (total, %)"
      ),
    pais = countrycode::countrycode(
      sourcevar   = pais,
      origin      = "iso3c",
      destination = "country.name"
      )
    ) %>% 
  tidyr::drop_na() %>% 
  dplyr::as_tibble() 


# Salvar dados ------------------------------------------------------------

# Salvar tabelas como arquivo CSV
if (!dir.exists("dados")) {dir.create("dados")}
readr::write_csv(x = dados, file = "dados/dados.csv")
