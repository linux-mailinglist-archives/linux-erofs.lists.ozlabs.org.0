Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395C92CB17
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 08:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1720593022;
	bh=nDS999X3woD0Ttghx8sXn9X+YATNWOvzSuz77GsKBlQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ADFZYl5ygdbbInY+Q/zaa5FdNrteLMKuThTb9/aF7nJYZhCWvlrSbmoCI54tTrYfL
	 4CLGVmPmQmoeYx0cOmMibD9XEo/EOeAyhzIB33Ee7u4H7bdWON/hYMczCh5H2XWM7P
	 Q9U2URDOYBUlS94zc8Dnwg646v1BQ2ikDj/k+sli4nLe7RRYng8ojIxBng5VRR8YM6
	 G6o5+62cfhlzlMcMK/YRDl7GFKJPdOFOYC/GjaQrnM686nSDSyxsxWWMtRxel2QvJO
	 5ShMMoBQ+CcqfJMcGsGYeNhdAMyZe3ezuZ72RW63QfIfPsaVpO6hQjpsg5x0FGsL3Q
	 Px3i6yXXJ3ESg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJnzL1yDrz3cY1
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 16:30:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=g5oZiRfO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.155; helo=out203-205-221-155.mail.qq.com; envelope-from=sa.z@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WJnzC4cY1z30Np
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 16:30:15 +1000 (AEST)
Received: from localhost.localdomain ([140.210.195.243])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 2643B269; Wed, 10 Jul 2024 14:09:36 +0800
X-QQ-mid: xmsmtpt1720591776t398gu2ri
Message-ID: <tencent_5904FA7E5C4B484EA73E5D1B33C35885AA06@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jEeXAaJFtAIh/4XjEJwAZGOrmMbEVrjEz0XjAr9VEJSQSjPswGB
	 ZgGRQYgM+SNWnLhS9iGqlAibITHaBHJqvjVI8DO6pgPj6t2HTfSCvWy4VewAbJ65lQxMXNP/4qYP
	 /EKRkED5CX2YKpvv/2Sw8vbun27b0qno0PCkJsJhI+QKEPT5WGB5Bz8Gnm23xrhXCWh7wJq/PQKT
	 07CazWxoV8A5J1Bbt7HwO7CIkz2OP/oWOb3IhYROEzbGhrVOHXJDjxpWLKSUG2ADkHU7BUtPAAh7
	 /mzyFWdkexfEmT7RF8bDvCE9WoA714RjEY5KkvIw5zdmg3XDzK9HNDN+mM+x3GRBKhqHfG+kbBPe
	 1Odzt040t0YWZETzERc7Xqp+nrhBoOUo6VROR8xHYZ3/Vh+TzYPPjky+gkmuWe054ihxjuDyKKbG
	 p/mibyaCfmC1GDfqddmD9Dt26N2Fmlsuu82EcyYjWxlLI+30nEAqwmX5t4BHZnzyhWOvcyrwdQRd
	 /aP4rBRjgj8PEZjt3sAZLxOsqW3HqRBIEtqf3UABISm3uIE3o18QDEIfpmIOJnbUHWN2WMfmaDpF
	 ljOlC5MQsuX+a1MPgiOE3EjC++TskdZoxDvb6Cm2hEPckuZk3v/mEefe8PiCNmpxfSX6PB0Hv0TV
	 6bHktFj00PaUXfcBYuuo4LnNrC0gNodnYSykoceIuZw4M92Yk3JurmQm3P+ZEdl/xbLVlyAze5tg
	 FMlxAs+f0zyjqXsbrwXXLt+kVQGl3n71t7W83k7nr0jp5bD4r11xIelzIKSa48bh723fSsuOkC2m
	 ndm3T5hVSxQdzaYuXa0Jjsp/YNWTAJqV60jkctkUaU041afZOUoO0WV/InTvKliLrldFNyg9XLQT
	 I817QX9dlCSnOj+3SE1GFUgqw5gcCanbMdLFVekzx07m+bHQ60/IOWl/s0T/AEGpQa078lQ5nF
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH 1/1] Add OCI register operation
Date: Wed, 10 Jul 2024 14:09:29 +0800
X-OQ-MSGID: <20240710060929.2685798-1-sa.z@qq.com>
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

