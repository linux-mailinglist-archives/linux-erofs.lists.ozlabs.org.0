Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4D92AFBF
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 08:06:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w+sy0hKQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJ9Ty5q8jz3fpn
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 16:06:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w+sy0hKQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJ9Tn4yTCz3fp3
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 16:06:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720505159; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qiG9iTWFRLXk9MrfDdoAcmOGa3FcwOVgfbUQNHHQiP0=;
	b=w+sy0hKQrioO7HVKg+WLPdPX3nigg9R6BAeGBDY/hsyrC53WjdNZEC/AwMQqWrTPW7Z6D7ZvLsYo0g/b0R9+tTTYVqft9l9p+4GTzemfBWPRfyNFRjo+bL/mJGNd1h/wKWt5u1oujyUG5D570poHyx7MqbmEJYo7ze/g+NerZb0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WAAa3s4_1720505158;
Received: from 30.97.49.57(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAAa3s4_1720505158)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 14:05:59 +0800
Message-ID: <d59d9d1f-f166-430f-b511-85caa2c8a758@linux.alibaba.com>
Date: Tue, 9 Jul 2024 14:05:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add OCI register operation
To: saz97 <sa.z@qq.com>, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
 chao@kernel.org
References: <tencent_2D38DE10CD4E353A41E6B7B130550AF4E607@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_2D38DE10CD4E353A41E6B7B130550AF4E607@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,


On 2024/7/5 14:15, saz97 wrote:

Thanks for the patch!

it would be better to write a commit message for this, and
write your SoB here, see:
https://erofs.docs.kernel.org/en/latest/developers.html

> ---
>   include/erofs/io.h |   1 +
>   lib/oci_registry.c | 511 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 512 insertions(+)
>   create mode 100644 lib/oci_registry.c
> 
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index f53abed..e8b6008 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -16,6 +16,7 @@ extern "C"
>   #define _GNU_SOURCE
>   #endif
>   #include <unistd.h>
> +
>   #include "defs.h"

It's an unnecessary change, I think you could just drop this.

>   
>   #ifndef O_BINARY
> diff --git a/lib/oci_registry.c b/lib/oci_registry.c
> new file mode 100644
> index 0000000..37fe357
> --- /dev/null
> +++ b/lib/oci_registry.c
> @@ -0,0 +1,511 @@
> +#include <stdio.h>
> +#include <curl/curl.h>
> +#include <json-c/json.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "erofs/io.h"
> +
> +#define TOKEN_MODE 1
> +#define IMAGE_INDEX_MODE 2
> +#define MANIFEST_MODE 3
> +#define BLOB_MODE 4



> +
> +struct MemoryStruct {

erofs-utils doesn't use this coding style, please also
see the web page above.

> +    char *memory;
> +    size_t size;
> +};
> +
> +CURLM *get_multi_handle() {

please add erofs_ prefix at least, also I think it could
be

CURLM *erofs_oci_registry_get_multi_handle(void)
{
}

> +    static CURLM *multi_handle = NULL;
> +    if (multi_handle == NULL) {
> +        multi_handle = curl_multi_init();
> +    }
> +    return multi_handle;
> +}
> +
> +static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp) {

naming needs to be changed too.

> +    size_t realSize = size * nmemb;
> +    struct MemoryStruct *mem = (struct MemoryStruct *)userp;
> +
> +    char *ptr = realloc(mem->memory, mem->size + realSize + 1); // +1 for null terminator
> +    if (ptr == NULL) {
> +        fprintf(stderr, "realloc failed\n");
> +        return 0;
> +    }
> +
> +    mem->memory = ptr;
> +    memcpy(&(mem->memory[mem->size]), contents, realSize);
> +    mem->size += realSize;
> +    mem->memory[mem->size] = 0; // Null terminator
> +    return realSize;
> +}
> +
> +ssize_t oci_registry_read(struct erofs_vfile *vf, void *buf, size_t len) {
> +    // 取出指向 MemoryStruct 的指针

We don't use Chinese comment in the whole project.

> +    struct MemoryStruct *memoryStruct = (struct MemoryStruct *)(vf->payload);
> +
> +    // 检查读取长度是否超出 memory 的大小


// comment should be avoided, /* */ is preferred.

> +    if (len > memoryStruct->size) {
> +        len = memoryStruct->size; // 限制读取长度为 memory 的大小
> +    }

if the block contains only one statement, the brace pair is unneeded.


> +
> +    // 将 memoryStruct->memory 中的数据拷贝到 buf 中
> +    memcpy(buf, memoryStruct->memory, len);
> +
> +    // 返回实际读取的字节数
> +    return len;
> +}
> +
> +ssize_t oci_registry_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len) {
> +    // 取出指向 MemoryStruct 的指针
> +    struct MemoryStruct *memoryStruct = (struct MemoryStruct *)(vf->payload);
> +
> +    // 检查 offset 是否超出 memory 的大小
> +    if (offset >= memoryStruct->size) {
> +        return 0; // 如果 offset 超出大小，返回0表示没有读取任何数据
> +    }
> +
> +    // 检查读取长度是否超出 memory 剩余的大小
> +    if (offset + len > memoryStruct->size) {
> +        len = memoryStruct->size - offset; // 限制读取长度为 memory 剩余的大小
> +    }
> +
> +    // 将 memoryStruct->memory 中从 offset 开始的数据拷贝到 buf 中
> +    memcpy(buf, memoryStruct->memory + offset, len);
> +
> +    // 返回实际读取的字节数
> +    return len;
> +}
> +
> +off_t oci_registry_lseek(struct erofs_vfile *vf, u64 offset, int whence) {
> +    // 取出指向 MemoryStruct 的指针
> +    struct MemoryStruct *memoryStruct = (struct MemoryStruct *)(vf->payload);
> +
> +    u64 new_offset = 0;
> +
> +    // 根据 whence 参数计算新的偏移量
> +    switch (whence) {
> +        case SEEK_SET:
> +            new_offset = offset;
> +            break;
> +        case SEEK_CUR:
> +            new_offset = vf->offset + offset;
> +            break;
> +        case SEEK_END:
> +            new_offset = memoryStruct->size + offset;
> +            break;
> +        default:
> +            return -1; // 无效的 whence 参数
> +    }
> +
> +    // 检查新的偏移量是否超出文件大小
> +    if (new_offset > memoryStruct->size) {
> +        return -1; // 超出文件大小，返回错误
> +    }
> +
> +    // 更新结构体中的偏移量
> +    vf->offset = new_offset;
> +
> +    // 返回新的偏移量
> +    return new_offset;
> +}
> +
> +char *get_token(struct MemoryStruct *data) {

erofs_oci_registry_get_token...

Please fix all similar cases, anyway..

Thanks,
Gao Xiang

