class DevelopmentDataSource {
   boolean pooling = true
   String dbCreate = "update" // one of 'create', 'create-drop','update'
   String url = "jdbc:postgresql://localhost:5432/poker"
   String driverClassName = "org.postgresql.Driver"
   String username = "poker"
   String password = "p0ker!!"
}

