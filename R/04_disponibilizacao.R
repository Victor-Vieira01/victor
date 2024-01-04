# Criar conexão com banco de dados SQL
sql_tratados <- conectar_sql(local = "dados/dados_tratados.db")

# Transforma conexão em objeto Tibble com fonte externa
tbl_tratados <- dplyr::tbl(src = sql_tratados, from = "tbl_tratados")

# Salvar como arquivo CSV
readr::write_csv(
    x = dplyr::collect(tbl_tratados),
    file = "aplicacoes/dados_disponibilizados.csv"
)

# Encerrar conexão
DBI::dbDisconnect(conn = sql_tratados)
