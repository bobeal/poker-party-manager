class DemoDataSource {
   boolean pooling = true
   String dbCreate = "update" // one of 'create', 'create-drop','update'
   String url = "jdbc:hsqldb:file:ppm.db"
   String driverClassName = "org.hsqldb.jdbcDriver"
   String username = "sa"
   String password = ""
}

