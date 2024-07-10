Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372B92CB03
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 08:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1720592821;
	bh=nDS999X3woD0Ttghx8sXn9X+YATNWOvzSuz77GsKBlQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ZWXCWrQn0iHho64nY3eQTZjcZRANCYKdVjXpiwl7HsM3PudTCO+d6v9PJcpJcZDZF
	 igBS+81h3WYeqri4WFiYgi7cma3ATgfw4Y9D23/WDoTCKgv+OvmFCko6GWEZ1GKbn1
	 7HA19/8s2nErP0fRgBBISCdWTEx4FFa67yrPHPR6y+ZtiDhPIFcTzchQHAgjJgZn6G
	 OvSr6rrfEbJj+BWZS9NIREFyXCdGYOCYUBiuOei40s/baeBg7VkP2D4U+AYU64x/JI
	 6D4jdP4LV7juPn1yCMaVwBJNEltpg9+pVxJMyJR16na8yegJNQa6CR7QJ066ZijyNG
	 NUOBCgh7q3URg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJnvT1lgdz3cY1
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 16:27:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=J81S87gV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=162.62.57.49; helo=out162-62-57-49.mail.qq.com; envelope-from=sa.z@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 249 seconds by postgrey-1.37 at boromir; Wed, 10 Jul 2024 16:26:51 AEST
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WJnvH2kxhz3c3H
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 16:26:48 +1000 (AEST)
Received: from localhost.localdomain ([140.210.195.243])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 37AB527A; Wed, 10 Jul 2024 14:13:58 +0800
X-QQ-mid: xmsmtpt1720592038t9geaa93e
Message-ID: <tencent_1745AA30E8E771EF21C49D597421CCF36308@qq.com>
X-QQ-XMAILINFO: NG7xP+P+sy64uTTgsB+ewRkLqEa3idv7m7MGHzo4EwVTE+vTK8k0dE8HMRi/YE
	 aPA+urvapYvmVhJDNksm5SV506JCF4iAJ+WdckH/Ex0NokHTk7foWElAcVHzaV3w6sZGhfdmfTtD
	 JG4tU1OkgOssNoyOo27Ogheac+qM04+Nk0krJWG9btuJgLBlX4gKO4vqVbk6OelLIwbjf22G77wz
	 5cGlH3QLGiM5V/kME/XXt7oxpiTOHfbmpd3eaOgxjQm77DSpn3mcSwPrFGO/xLLFcvtKJmkeO2DJ
	 HCFZmGf4F8C5XS0K4FMGWAEB4Bk/Mh6ggdd7uM/AeE+5Oam/XxFJmjiRgHl2nfxttQlx7XNJNsTv
	 7zE2nZhJLh01AdYqfie4aosM5xo1sfZGZDCCYaVxFNifnnPgD4DdyxlFgoeTaqrp4/bVQjzVcFv+
	 7ICxkbADtNmwSR1rhfgztyk7wK9HE6/4KyXmzGYspeyQdr2qOO7Rk8vKLkVEWcxUpf+mRwnChkkw
	 xC1Hjomx9VwpBN/KVgngEu8tX3+ADfmfwvXoRC3VQFx9O99JyyXMCYod3W1pqCVoT20Uhire2d/d
	 a0dV/EFfb4vwDyWyDuoDuvcDa6a8HpqgaWetNUO/k5c3V1+5tHrT/IOHAWd6PjWyMuGQB6ijfi+9
	 yuJspxHRCfokRQez/7c5Vmvox4cssReM+g94tu3EViJt8QMoZgSuicT5McuG2vq4s7YSU7TV9SoR
	 +HjjmQIv7qSMzPlpAoYzl21hLfPdYea0ISgUlX9ojyxAips+wqQ8gtmZaTZtXlL/Pu5SChNszk/d
	 QoaHwb+D+hfrRJY0YLGOrrpq7MYqhQcINtwKSvoeeP0zFRUfxBRdxEbR/U2D5KFc7zFZYgKP74sO
	 e457Olkre/92EjuvgPNfpL6ON4JiPOJ4bn0XQL+GbrN0clTJTbX/fYroKkSEzTFQRWbdwmHu13Jk
	 hD0p94x+rAPmvJdfdGqvRpfDi+wxc+KUqsUL5n5Yk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v2] Add OCI register operation
Date: Wed, 10 Jul 2024 14:13:52 +0800
X-OQ-MSGID: <20240710061352.2686253-1-sa.z@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: saz97 via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: saz97 <sa.z@qq.com>
Cc: saz97 <sa.z@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds support for handling OCI registry operations in the EROFS. The following functionalities are included:

1. `oci_registry_read`: Reads data from the OCI registry memory structure.
2. `oci_registry_pread`: Reads data from a specified offset within the OCI registry memory structure.
3. `oci_registry_lseek`: Adjusts the file offset within the OCI registry memory structure.
4. `open_oci_registry`: Main function to handle the opening of the OCI registry.

These changes include the following adjustments:
- Renaming structures and functions to follow the EROFS naming conventions.

Signed-off-by: Changzhi Xie <sa.z@qq.com>
---
 include/erofs/io.h |   1 -
 lib/oci_registry.c | 183 ++++++++++++++++++---------------------------
 2 files changed, 73 insertions(+), 111 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index e8b6008..f53abed 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -16,7 +16,6 @@ extern "C"
 #define _GNU_SOURCE
 #endif
 #include <unistd.h>
-
 #include "defs.h"
 
 #ifndef O_BINARY
diff --git a/lib/oci_registry.c b/lib/oci_registry.c
index 37fe357..3c21e2d 100644
--- a/lib/oci_registry.c
+++ b/lib/oci_registry.c
@@ -10,24 +10,23 @@
 #define MANIFEST_MODE 3
 #define BLOB_MODE 4 
 
-struct MemoryStruct {
+struct erofs_oci_registry_memory {
     char *memory;
     size_t size;
 };
 
-CURLM *get_multi_handle() {
+CURLM *erofs_oci_registry_get_multi_handle(void) {
     static CURLM *multi_handle = NULL;
-    if (multi_handle == NULL) {
+    if (multi_handle == NULL) 
         multi_handle = curl_multi_init();
-    }
     return multi_handle;
 }
 
-static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp) {
+static size_t erofs_oci_registry_write_callback(void *contents, size_t size, size_t nmemb, void *userp) {
     size_t realSize = size * nmemb;
-    struct MemoryStruct *mem = (struct MemoryStruct *)userp;
+    struct erofs_oci_registry_memory *mem = (struct erofs_oci_registry_memory *)userp;
 
-    char *ptr = realloc(mem->memory, mem->size + realSize + 1); // +1 for null terminator
+    char *ptr = realloc(mem->memory, mem->size + realSize + 1); 
     if (ptr == NULL) {
         fprintf(stderr, "realloc failed\n");
         return 0;
@@ -36,54 +35,41 @@ static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, voi
     mem->memory = ptr;
     memcpy(&(mem->memory[mem->size]), contents, realSize);
     mem->size += realSize;
-    mem->memory[mem->size] = 0; // Null terminator
+    mem->memory[mem->size] = 0;
     return realSize;
 }
 
 ssize_t oci_registry_read(struct erofs_vfile *vf, void *buf, size_t len) {
-    // 取出指向 MemoryStruct 的指针
-    struct MemoryStruct *memoryStruct = (struct MemoryStruct *)(vf->payload);
+    struct erofs_oci_registry_memory *memoryStruct = (struct erofs_oci_registry_memory *)(vf->payload);
 
-    // 检查读取长度是否超出 memory 的大小
     if (len > memoryStruct->size) {
-        len = memoryStruct->size; // 限制读取长度为 memory 的大小
+        len = memoryStruct->size;
     }
 
-    // 将 memoryStruct->memory 中的数据拷贝到 buf 中
     memcpy(buf, memoryStruct->memory, len);
 
-    // 返回实际读取的字节数
     return len;
 }
 
 ssize_t oci_registry_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len) {
-    // 取出指向 MemoryStruct 的指针
-    struct MemoryStruct *memoryStruct = (struct MemoryStruct *)(vf->payload);
+    struct erofs_oci_registry_memory *memoryStruct = (struct erofs_oci_registry_memory *)(vf->payload);
 
-    // 检查 offset 是否超出 memory 的大小
-    if (offset >= memoryStruct->size) {
-        return 0; // 如果 offset 超出大小，返回0表示没有读取任何数据
-    }
+    if (offset >= memoryStruct->size)
+        return 0;
 
-    // 检查读取长度是否超出 memory 剩余的大小
-    if (offset + len > memoryStruct->size) {
-        len = memoryStruct->size - offset; // 限制读取长度为 memory 剩余的大小
-    }
+    if (offset + len > memoryStruct->size)
+        len = memoryStruct->size - offset;
 
-    // 将 memoryStruct->memory 中从 offset 开始的数据拷贝到 buf 中
     memcpy(buf, memoryStruct->memory + offset, len);
 
-    // 返回实际读取的字节数
     return len;
 }
 
 off_t oci_registry_lseek(struct erofs_vfile *vf, u64 offset, int whence) {
-    // 取出指向 MemoryStruct 的指针
-    struct MemoryStruct *memoryStruct = (struct MemoryStruct *)(vf->payload);
+    struct erofs_oci_registry_memory *memoryStruct = (struct erofs_oci_registry_memory *)(vf->payload);
 
     u64 new_offset = 0;
 
-    // 根据 whence 参数计算新的偏移量
     switch (whence) {
         case SEEK_SET:
             new_offset = offset;
@@ -95,22 +81,18 @@ off_t oci_registry_lseek(struct erofs_vfile *vf, u64 offset, int whence) {
             new_offset = memoryStruct->size + offset;
             break;
         default:
-            return -1; // 无效的 whence 参数
+            return -1;
     }
 
-    // 检查新的偏移量是否超出文件大小
-    if (new_offset > memoryStruct->size) {
-        return -1; // 超出文件大小，返回错误
-    }
+    if (new_offset > memoryStruct->size)
+        return -1;
 
-    // 更新结构体中的偏移量
     vf->offset = new_offset;
 
-    // 返回新的偏移量
     return new_offset;
 }
 
-char *get_token(struct MemoryStruct *data) {
+char *erofs_oci_registry_get_token(struct erofs_oci_registry_memory *data) {
     if (data->memory == NULL) {
         fprintf(stderr, "No data received\n");
         return NULL;
@@ -138,29 +120,24 @@ char *get_token(struct MemoryStruct *data) {
     strcat(auth_header, token);
 
     json_object_put(parsed_json);
-    //printf("Token: %s\n", auth_header);
     free(data->memory);
     data->memory = NULL;
     data->size = 0;
     return auth_header;
 }
 
-// 获取镜像索引函数
-char *get_image_index(struct MemoryStruct *data, const char *arch, const char *os, char *mediaType) {
-    // 检查是否接收到数据
+char *erofs_oci_registry_get_image_index(struct erofs_oci_registry_memory *data, const char *arch, const char *os, char *mediaType) {
     if (data->memory == NULL) {
         fprintf(stderr, "No data receive\n");
         return NULL;
     }
 
-    // 解析 JSON 数据
     json_object *parsed_json = json_tokener_parse(data->memory);
     if (parsed_json == NULL) {
         fprintf(stderr, "Parse JSON failed\n");
         return NULL;
     }
 
-    // 获取 manifests 数组
     json_object *manifests_array;
     if (!json_object_object_get_ex(parsed_json, "manifests", &manifests_array)) {
         fprintf(stderr, "Can not JSON find manifests\n");
@@ -168,32 +145,26 @@ char *get_image_index(struct MemoryStruct *data, const char *arch, const char *o
         return NULL;
     }
 
-    // 遍历 manifests 数组
     int len = json_object_array_length(manifests_array);
     for (int i = 0; i < len; i++) {
         json_object *manifest = json_object_array_get_idx(manifests_array, i);
         json_object *platform_json;
         
-        // 检查 platform 对象
         if (json_object_object_get_ex(manifest, "platform", &platform_json)) {
             json_object *arch_json, *os_json, *digest_json, *mediaType_json;
             
-            // 获取 architecture, os 和 digest
             if (json_object_object_get_ex(platform_json, "architecture", &arch_json) &&
                 json_object_object_get_ex(platform_json, "os", &os_json) &&
                 json_object_object_get_ex(manifest, "digest", &digest_json)) {
                 
                 const char *manifest_arch = json_object_get_string(arch_json);
                 const char *manifest_os = json_object_get_string(os_json);
-                //printf("image_index[%d]: arch = %s, os = %s\n", i, manifest_arch, manifest_os);
 
-                // 检查是否匹配指定的架构和操作系统
                 if (strcmp(manifest_arch, arch) == 0 && strcmp(manifest_os, os) == 0) {
                     char *digest = strdup(json_object_get_string(digest_json));
                     if (json_object_object_get_ex(manifest, "mediaType", &mediaType_json)) {
                         const char* manifest_mediaType = json_object_get_string(mediaType_json);
                         sprintf(mediaType, "Accept: %s", manifest_mediaType);
-                        //printf("mediaType: %s\n", mediaType);
                     }
                     json_object_put(parsed_json);
                     free(data->memory);
@@ -205,7 +176,6 @@ char *get_image_index(struct MemoryStruct *data, const char *arch, const char *o
         }
     }
 
-    // 释放 JSON 对象和内存
     json_object_put(parsed_json);
     free(data->memory);
     data->memory = NULL;
@@ -215,7 +185,7 @@ char *get_image_index(struct MemoryStruct *data, const char *arch, const char *o
     return NULL;
 }
 
-char* get_manifest(struct MemoryStruct *data, char *mediaType, int count) {
+char* erofs_oci_registry_get_manifest(struct erofs_oci_registry_memory *data, char *mediaType, int count) {
     json_object *parsed_json = json_tokener_parse(data->memory);
     if (!parsed_json) {
         fprintf(stderr, "Failed to parse JSON\n");
@@ -240,14 +210,13 @@ char* get_manifest(struct MemoryStruct *data, char *mediaType, int count) {
     json_object *layer = json_object_array_get_idx(layers_array, count);
     json_object *digest_json, *mediaType_json;
     char *digest = NULL;
-    if (!json_object_object_get_ex(layer, "digest", &digest_json)) {
+    if (!json_object_object_get_ex(layer, "digest", &digest_json))
         fprintf(stderr, "Digest not found in layer #%d\n", count);
-    } else {
+    else {
         digest = strdup(json_object_get_string(digest_json));
         if (json_object_object_get_ex(layer, "mediaType", &mediaType_json)) {
             const char* manifest_mediaType = json_object_get_string(mediaType_json);
             sprintf(mediaType, "Accept: %s", manifest_mediaType);
-            //printf("mediaType: %s\n", mediaType);
         }
     }
 
@@ -255,7 +224,7 @@ char* get_manifest(struct MemoryStruct *data, char *mediaType, int count) {
     return digest;
 }
 
-void curl_io(CURLM *multi_handle, int *still_running) {
+void erofs_oci_registry_curl_io(CURLM *multi_handle, int *still_running) {
     CURLMcode mc;
     do {
         mc = curl_multi_perform(multi_handle, still_running);
@@ -265,7 +234,7 @@ void curl_io(CURLM *multi_handle, int *still_running) {
         }
         if (*still_running) {
             int numfds;
-            mc = curl_multi_poll(multi_handle, NULL, 0, 1000, &numfds); // wait for 1 second
+            mc = curl_multi_poll(multi_handle, NULL, 0, 1000, &numfds);
             if (mc != CURLM_OK) {
                 fprintf(stderr, "curl_multi_poll failed: %s\n", curl_multi_strerror(mc));
                 break;
@@ -274,11 +243,11 @@ void curl_io(CURLM *multi_handle, int *still_running) {
     } while (*still_running > 0);
 }
 
-struct MemoryStruct* curl_setopt(CURLM *multi_handle, CURL* curl, const char* auth_header, const char* mediaType, const char* url, int mode){
-    struct MemoryStruct *data = malloc(sizeof(struct MemoryStruct));
+struct erofs_oci_registry_memory* erofs_oci_registry_curl_setopt(CURLM *multi_handle, CURL* curl, const char* auth_header, const char* mediaType, const char* url, int mode){
+    struct erofs_oci_registry_memory *data = malloc(sizeof(struct erofs_oci_registry_memory));
     struct curl_slist *headers = NULL;
     if (data == NULL) {
-        fprintf(stderr, "Failed to allocate memory for MemoryStruct\n");
+        fprintf(stderr, "Failed to allocate memory for erofs_oci_registry_memory\n");
         return NULL;
     }
     data->memory = NULL;
@@ -286,15 +255,13 @@ struct MemoryStruct* curl_setopt(CURLM *multi_handle, CURL* curl, const char* au
     switch (mode)
     {
         case TOKEN_MODE:
-            //printf("TOKEN_MODE operation\n");
-            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
+            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, erofs_oci_registry_write_callback);
             curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
             curl_easy_setopt(curl, CURLOPT_URL, url);
             curl_multi_add_handle(multi_handle, curl);
             break;
         case IMAGE_INDEX_MODE:
-            //printf("IMAGE_INDEX_MODE operation\n");
-            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
+            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, erofs_oci_registry_write_callback);
             curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
             headers = curl_slist_append(headers, auth_header);
             curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
@@ -302,8 +269,7 @@ struct MemoryStruct* curl_setopt(CURLM *multi_handle, CURL* curl, const char* au
             curl_multi_add_handle(multi_handle, curl);
             break;
         case MANIFEST_MODE:
-            //printf("MANIFEST_MODE operation\n");
-            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
+            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, erofs_oci_registry_write_callback);
             curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
             headers = curl_slist_append(headers, auth_header);
             headers = curl_slist_append(headers, mediaType);
@@ -312,8 +278,7 @@ struct MemoryStruct* curl_setopt(CURLM *multi_handle, CURL* curl, const char* au
             curl_multi_add_handle(multi_handle, curl);		
             break;
         case BLOB_MODE:
-            //printf("BLOB_MODE operation\n");
-            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
+            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, erofs_oci_registry_write_callback);
             curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
             headers = curl_slist_append(headers, auth_header);
             headers = curl_slist_append(headers, mediaType);
@@ -338,10 +303,9 @@ struct erofs_vfile* open_oci_registry(const char* url) {
     char mediaType_blob[512];
     char url_blob[512];
     int digest = 0;
-    int still_running; // For curl_multi_perform
+    int still_running;
     int mode = 0;
 
-    // 解析出repository和url_front
     const char* repo_start = strstr(url, "/library/");
     if (repo_start == NULL) {
         printf("Invalid URL: missing /library/\n");
@@ -361,48 +325,42 @@ struct erofs_vfile* open_oci_registry(const char* url) {
     strncpy(url_front, url, repo_start - url);
     url_front[repo_start - url] = '\0';
 
-    //获取token
     char url_token[512];
     snprintf(url_token, sizeof(url_token), "https://auth.docker.io/token?service=registry.docker.io&scope=repository:library/%s:pull", repository);
     CURL* curl_token = curl_easy_init();
-    struct MemoryStruct* data_token = curl_setopt(get_multi_handle(), curl_token, NULL, NULL, url_token, TOKEN_MODE);
-    curl_io(get_multi_handle(), &still_running);
-    char *token_header = get_token(data_token);
-    curl_multi_remove_handle(get_multi_handle(), curl_token);
+    struct erofs_oci_registry_memory* data_token = erofs_oci_registry_curl_setopt(erofs_oci_registry_get_multi_handle(), curl_token, NULL, NULL, url_token, TOKEN_MODE);
+    erofs_oci_registry_curl_io(erofs_oci_registry_get_multi_handle(), &still_running);
+    char *token_header = erofs_oci_registry_get_token(data_token);
+    curl_multi_remove_handle(erofs_oci_registry_get_multi_handle(), curl_token);
     curl_easy_cleanup(curl_token);
-    if (data_token) free(data_token);
+    if (data_token) 
+        free(data_token);
 
     const char* blob_start = strstr(repo_end, "/blobs/");
     if (blob_start != NULL) {
-        // 获取 digest
         const char* digest_start = blob_start + strlen("/blobs/");
         const char* digest_end = strchr(digest_start, '/');
-        if (digest_end == NULL) {
+        if (digest_end == NULL)
             digest_end = digest_start + strlen(digest_start);
-        }
+
         strncpy(digest_value, digest_start, digest_end - digest_start);
         digest_value[digest_end - digest_start] = '\0';
 
-        // 获取 mediaType
         const char* mediaType_start = strstr(digest_end, "Accept: ");
-        if (mediaType_start != NULL) {
+        if (mediaType_start != NULL) 
             strcpy(mediaType_value, mediaType_start);
-        } else {
+        else 
             strcpy(mediaType_value, "");
-        }
 
-        // 构建url_blob
         snprintf(url_blob, sizeof(url_blob), "%s%s/blobs/%s", url_front, repository, digest_value);
         mode = 1;
         goto pull_blob_mode;
     } 
     else {
-        // 设置默认值
         strcpy(arch, "amd64");
         strcpy(os, "linux");
         digest = 0;
 
-        // 继续解析arch, os, digest
         const char* params = repo_end + 1;
         while (params && *params != '\0') {
             if (strncmp(params, "arch-", 5) == 0) {
@@ -433,7 +391,8 @@ struct erofs_vfile* open_oci_registry(const char* url) {
                 break;
             } else {
                 params = strchr(params, '/');
-                if (params) params++;
+                if (params) 
+                    params++;
             }
         }
 	/*
@@ -443,45 +402,48 @@ struct erofs_vfile* open_oci_registry(const char* url) {
         printf("OS: %s\n", os);
         printf("Digest: %d\n", digest);
 	*/
-        //获取image index中的digest
         char url_image_index[512], mediaType[512];
         snprintf(url_image_index, sizeof(url_image_index), "%s%s/manifests/latest", url_front, repository);
         CURL* curl_image_index = curl_easy_init();
-        struct MemoryStruct* data_image_index = curl_setopt(get_multi_handle(), curl_image_index, token_header, NULL, url_image_index, IMAGE_INDEX_MODE);
-        curl_io(get_multi_handle(), &still_running);
-        char* digest_image_index = get_image_index(data_image_index, arch, os, mediaType);
-        //printf("digest_image_index = %s\n", digest_image_index);
-        if (data_image_index) free(data_image_index);
-        curl_multi_remove_handle(get_multi_handle(), curl_image_index);
+        struct erofs_oci_registry_memory* data_image_index = erofs_oci_registry_curl_setopt(erofs_oci_registry_get_multi_handle(), curl_image_index, token_header, NULL, url_image_index, IMAGE_INDEX_MODE);
+        erofs_oci_registry_curl_io(erofs_oci_registry_get_multi_handle(), &still_running);
+        char* digest_image_index = erofs_oci_registry_get_image_index(data_image_index, arch, os, mediaType);
+        if (data_image_index) 
+            free(data_image_index);
+        
+        curl_multi_remove_handle(erofs_oci_registry_get_multi_handle(), curl_image_index);
         curl_easy_cleanup(curl_image_index);
 
-        //获取manifest中的digest
         char url_manifest[512];
         snprintf(url_manifest, sizeof(url_manifest), "%s%s/manifests/%s", url_front, repository, digest_image_index);
-        if (digest_image_index) free(digest_image_index);
+        if (digest_image_index) 
+            free(digest_image_index);
+        
         CURL* curl_manifest = curl_easy_init();
-        struct MemoryStruct* data_manifest = curl_setopt(get_multi_handle(), curl_manifest, token_header, mediaType, url_manifest, MANIFEST_MODE);
-        curl_io(get_multi_handle(), &still_running);
-        char* digest_manifest = get_manifest(data_manifest, mediaType_blob, digest);
-        //printf("digest_manifest = %s\n", digest_manifest);
-        if (data_manifest) free(data_manifest);
-        curl_multi_remove_handle(get_multi_handle(), curl_manifest);
+        struct erofs_oci_registry_memory* data_manifest = erofs_oci_registry_curl_setopt(erofs_oci_registry_get_multi_handle(), curl_manifest, token_header, mediaType, url_manifest, MANIFEST_MODE);
+        erofs_oci_registry_curl_io(erofs_oci_registry_get_multi_handle(), &still_running);
+        char* digest_manifest = erofs_oci_registry_get_manifest(data_manifest, mediaType_blob, digest);
+        if (data_manifest) 
+            free(data_manifest);
+        
+        curl_multi_remove_handle(erofs_oci_registry_get_multi_handle(), curl_manifest);
         curl_easy_cleanup(curl_manifest);
 
-        //获取blob
         snprintf(url_blob, sizeof(url_blob), "%s%s/blobs/%s", url_front, repository, digest_manifest);
-        if (digest_manifest) free(digest_manifest);
+        if (digest_manifest) 
+            free(digest_manifest);
     }
 
 pull_blob_mode:
     CURL* curl_blob = curl_easy_init();
-    struct MemoryStruct* data_blob;
+    struct erofs_oci_registry_memory* data_blob;
     if (mode == 1)
-    data_blob = curl_setopt(get_multi_handle(), curl_blob, token_header, mediaType_value, url_blob, BLOB_MODE);
+        data_blob = erofs_oci_registry_curl_setopt(erofs_oci_registry_get_multi_handle(), curl_blob, token_header, mediaType_value, url_blob, BLOB_MODE);
     else
-    data_blob = curl_setopt(get_multi_handle(), curl_blob, token_header, mediaType_blob, url_blob, BLOB_MODE);
-    curl_io(get_multi_handle(), &still_running); 
-    curl_multi_remove_handle(get_multi_handle(), curl_blob);
+        data_blob = erofs_oci_registry_curl_setopt(erofs_oci_registry_get_multi_handle(), curl_blob, token_header, mediaType_blob, url_blob, BLOB_MODE);
+    
+    erofs_oci_registry_curl_io(erofs_oci_registry_get_multi_handle(), &still_running); 
+    curl_multi_remove_handle(erofs_oci_registry_get_multi_handle(), curl_blob);
     curl_easy_cleanup(curl_blob);
 
     struct erofs_vfile* vf = malloc(sizeof(struct erofs_vfile));
@@ -489,7 +451,7 @@ pull_blob_mode:
     vf->ops->read = oci_registry_read;
     vf->ops->pread = oci_registry_pread;
     vf->ops->lseek = oci_registry_lseek;
-    *((struct MemoryStruct**)(vf->payload)) = data_blob;
+    *((struct erofs_oci_registry_memory**)(vf->payload)) = data_blob;
 
     if (mode == 1) {
     /*
@@ -504,7 +466,8 @@ pull_blob_mode:
     
     
     
-    if (token_header) free(token_header);
+    if (token_header) 
+        free(token_header);
     printf("%s is open\n",repository);
     return vf;
 }
-- 
2.25.1

