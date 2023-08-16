package bo.edu.ucb.todo.api;

import bo.edu.ucb.todo.bl.AuthBl;
import bo.edu.ucb.todo.dto.*;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*")
class AuthApi {

    @PostMapping("/api/v1/auth/login")
    public ResponseDto<TokenDto> login(@RequestBody LoginDto login) {
        ResponseDto<TokenDto> response = new ResponseDto<>();
        AuthBl authBl = new AuthBl();
        TokenDto tokenDto = authBl.login(login);
        if (tokenDto == null) {
            response.setCode("0001");
            response.setResponse(null);
            response.setErrorMessage("Invalid credentials");
        } else {
            response.setCode("0000");
            response.setResponse(tokenDto);
        }
        return response;
    }
    //Endpoint de un get que te devuelve un Hola mundo
    @GetMapping("/api/v1/auth/hello")
    public ResponseDto<String> hello() {
        ResponseDto<String> response = new ResponseDto<>();

            response.setCode("0000");
            response.setResponse("Hello gei");
        return response;
    }

    
}
