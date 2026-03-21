package com.ngimnee.service.impl;

import com.ngimnee.constant.SystemConstant;
import com.ngimnee.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FileServiceImpl implements FileService {
    @Override
    public String upload(MultipartFile file) {
        try {
            validateFile(file);

            String originalName = file.getOriginalFilename();
            if (originalName == null) {
                throw new RuntimeException("Tên file không hợp lệ");
            }

            int dotIndex = originalName.lastIndexOf(".");
            String extension = (dotIndex != -1) ? originalName.substring(dotIndex).toLowerCase() : "";

            if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)$")) {
                throw new RuntimeException("Định dạng ảnh không hợp lệ");
            }

            String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID() + extension;

            Path path = Paths.get(SystemConstant.UPLOAD_DIR, fileName);
            Files.createDirectories(path.getParent());
            Files.write(path, file.getBytes());

            return SystemConstant.UPLOAD_URL + fileName;
        } catch (IOException e) {
            throw new RuntimeException("Upload file thất bại", e);
        }
    }

    @Override
    public void delete(String path) {
        try {
            String fileName = path.substring(path.lastIndexOf("/") + 1);
            if (path == null || path.isEmpty()) return;
            Path filePath = Paths.get(SystemConstant.UPLOAD_DIR, fileName);
            Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void validateFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new RuntimeException("File rỗng");
        }

        if (file.getSize() > 10 * 1024 * 1024) {
            throw new RuntimeException("File quá lớn (max 10MB)");
        }

        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new RuntimeException("Chỉ cho phép upload ảnh");
        }
    }
}
