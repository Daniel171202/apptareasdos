package bo.edu.ucb.todo.bl;

import bo.edu.ucb.todo.dto.FileDto;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;

public class FileService {

    public FileService() {

    }

    // Función para subir un archivo
    public void uploadFile(MultipartFile file){
        Path uploadDirectory = Paths.get("C:\\Users\\Administrator\\Documents\\GitHub\\apptareasdos\\todo-1\\src\\main\\fotingos");
        try(InputStream inputStream = file.getInputStream()){
            Path filePath = uploadDirectory.resolve(Objects.requireNonNull(file.getOriginalFilename()));
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new RuntimeException("No se pudo almacenar el archivo. Error: " + e.getMessage());
        }
    }
   
    
}