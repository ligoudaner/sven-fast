package com.sven.modules.oss.cloud;


import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.exception.CosClientException;
import com.qcloud.cos.exception.CosServiceException;
import com.qcloud.cos.model.ObjectMetadata;
import com.qcloud.cos.model.PutObjectRequest;
import com.qcloud.cos.model.PutObjectResult;
import com.qcloud.cos.region.Region;
import com.sven.common.exception.RRException;

import java.io.InputStream;

/**
 * 腾讯云存储
 *
 * @author Sven i_xiangwei@163.com
 */
public class QcloudCloudStorageService extends CloudStorageService {
    private COSClient client;

    public QcloudCloudStorageService(CloudStorageConfig config) {
        this.config = config;

        //初始化
        init();
    }

    private void init() {
        COSCredentials credentials = new BasicCOSCredentials(config.getQcloudSecretId(),
                config.getQcloudSecretKey());

        //初始化客户端配置
        ClientConfig clientConfig = new ClientConfig();
        //设置bucket所在的区域，华南：gz 华北：tj 华东：sh
        clientConfig.setRegion(new Region(config.getQcloudRegion()));

        client = new COSClient(credentials, clientConfig);
    }

    @Override
    public String upload(byte[] data, String path) {
        return null;
    }

    @Override
    public String upload(InputStream inputStream, String path) {
        //腾讯云必需要以"/"开头
        if (!path.startsWith("/")) {
            path = "/" + path;
        }
        PutObjectRequest putObjectRequest = new PutObjectRequest(config.getQcloudBucketName(), path, inputStream,null);
        // 设置自定义属性(如 content-type, content-disposition 等)
        ObjectMetadata objectMetadata = new ObjectMetadata();
        // 设置 Content type, 默认是 application/octet-stream
        objectMetadata.setContentType("image/jpeg");
        putObjectRequest.setMetadata(objectMetadata);
        try {
            PutObjectResult putObjectResult = client.putObject(putObjectRequest);
            // putobjectResult 会返回文件的 etag
            return config.getQcloudDomain() + path;
        } catch (CosServiceException e) {
            e.printStackTrace();
            throw new RRException("文件上传失败，" + e.getMessage());
        } catch (CosClientException e) {
            e.printStackTrace();
            throw new RRException("文件上传失败，" + e.getMessage());
        }
    }

    @Override
    public String uploadSuffix(byte[] data, String suffix) {
        return upload(data, getPath(config.getQcloudPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        return upload(inputStream, getPath(config.getQcloudPrefix(), suffix));
    }

    @Override
    public void delete(String key) {
        try {
            client.deleteObject(config.getQcloudBucketName(),key.replace(config.getQcloudDomain(),""));
        }catch (CosServiceException e) {
            e.printStackTrace();
            throw new RRException("文件删除失败，" + e.getMessage());
        } catch (CosClientException e) {
            e.printStackTrace();
            throw new RRException("文件删除失败，" + e.getMessage());
        }
    }
}
