package study.jspspringbootbbs.security.config;


import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import study.jspspringbootbbs.domain.member.repository.MemberRepository;
import study.jspspringbootbbs.domain.member.service.MemberService;
import study.jspspringbootbbs.security.filter.CustomAuthenticationFilter;
import study.jspspringbootbbs.security.filter.CustomVerificationFilter;
import study.jspspringbootbbs.security.handler.MemberAuthenticationFailureHandler;
import study.jspspringbootbbs.security.handler.MemberAuthenticationSuccessHandler;
import study.jspspringbootbbs.security.jwt.JwtService;
import study.jspspringbootbbs.security.jwt.JwtTokenizer;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtTokenizer jwtTokenizer;
    private final JwtService jwtService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        http
                .csrf().disable()
                .headers().frameOptions().disable()
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .formLogin().disable()
                .httpBasic().disable()
                .apply(new CustomFilterConfigurer())
                .and()
                .exceptionHandling()
                .and()
                .authorizeRequests()
                .anyRequest().permitAll();
        return http.build();
    }


    public class CustomFilterConfigurer extends AbstractHttpConfigurer<CustomFilterConfigurer, HttpSecurity> {
        @Override
        public void configure(HttpSecurity builder) throws Exception {
            AuthenticationManager authenticationManager = builder.getSharedObject(AuthenticationManager.class);

            CustomAuthenticationFilter customAuthenticationFilter = new CustomAuthenticationFilter(authenticationManager, jwtTokenizer,jwtService);
            customAuthenticationFilter.setFilterProcessesUrl("/api/member/login");
            customAuthenticationFilter.setAuthenticationSuccessHandler(new MemberAuthenticationSuccessHandler());
            customAuthenticationFilter.setAuthenticationFailureHandler(new MemberAuthenticationFailureHandler());

            CustomVerificationFilter customVerificationFilter = new CustomVerificationFilter(jwtTokenizer);

            builder
                    .addFilter(customAuthenticationFilter)
                    .addFilterAfter(customVerificationFilter, CustomAuthenticationFilter.class);
        }
    }
}
