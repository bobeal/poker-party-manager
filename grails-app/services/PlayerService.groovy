class PlayerService {
    
    def getAuthorizedToAdminChampionships() {
        return Player.findAllByCanManageChampionship(true)
    }
}