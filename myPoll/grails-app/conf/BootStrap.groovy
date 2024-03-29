import org.example.SecRole
import org.example.SecUser
import org.example.SecUserSecRole
import grails.util.Environment

class BootStrap {
    def springSecurityService

    def init = { servletContext ->

        def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN').save(failOnError: true)
        def adminUser = SecUser.findByUsername('nico') ?: new SecUser (
            username: 'nico',
            password: 'BAnb/ss14',
            enabled: true).save(failOnError: true)

        if (!adminUser.authorities.contains(adminRole)) {
            SecUserSecRole.create adminUser, adminRole
        }

        switch(Environment.current) {
            case Environment.DEVELOPMENT:
                def testUser = SecUser.findByUsername('test') ?: new SecUser (
                    username: 'test',
                    password: 'test',
                    enabled: true).save(failOnError: true)
        }
    }
    def destroy = {
    }
}
