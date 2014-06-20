import org.example.SecRole
import org.example.SecUser
import org.example.SecUserSecRole

class BootStrap {
    def springSecurityService

    def init = { servletContext ->

        def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
        def adminUser = SecUser.findByUsername('nico') ?: new SecUser (
            username: 'nico',
            password: 'joocinjo091!',
            enabled: true).save(failOnError: true)

        if (!adminUser.authorities.contains(adminRole)) {
            SecUserSecRole.create adminUser, adminRole
        }

    }
    def destroy = {
    }
}
