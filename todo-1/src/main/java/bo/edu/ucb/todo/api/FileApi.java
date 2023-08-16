package bo.edu.ucb.todo.api;
import java.util.*;

import org.springframework.context.annotation.Description;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import bo.edu.ucb.todo.dto.*;
import bo.edu.ucb.todo.bl.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@CrossOrigin(origins = "*")
class FileApi {
    @PostMapping(path = "/uploadFile")
    public ResponseDto<String> uploadFile(@RequestParam("file") MultipartFile multipartFile) {
        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
        long  fileSize = multipartFile.getSize();
        System.out.println("File Name: " + fileName);
        FileService fileBl = new FileService();
        fileBl.uploadFile(multipartFile);
        ResponseDto<String> responseDto = new ResponseDto<String>();
        responseDto.setResponse("Archivo subido correctamente");
        return responseDto;
    }

}