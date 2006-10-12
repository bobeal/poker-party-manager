class DevelopmentDataSource {
   boolean pooling = true
   String dbCreate = "update" // one of 'create', 'create-drop','update'
   String url = "jdbc:postgresql://localhost:5432/bor"
   String driverClassName = "org.postgresql.Driver"
   String username = "bor"
   String password = "bor"
}

