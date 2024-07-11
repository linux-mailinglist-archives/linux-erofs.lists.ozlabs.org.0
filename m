Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665B92E093
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2024 09:10:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hljRMXCk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WKQqD0K56z3cXd
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2024 17:10:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hljRMXCk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WKQq64W4jz30WP
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jul 2024 17:10:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720681820; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N+slXL3tOGcdINGfkslk3PYNCJRUV7RuHS9+QNp3Oo4=;
	b=hljRMXCkX1A5ohK5bpeDyNQSHOComQ/huzst+hk1tSwYqD1LzeoUEZ6kmxGauOgelmaE0P5pNJz547dswgU/isYlkrOKO+r7qQ/vqrw6lPQS1RM/ES90x3Hp0SMFN7Mlr3OGDHZl4aUem1zfCXiadfPZxBguUDHlRFdR9KlzqUw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WAIvm6i_1720681817;
Received: from 30.97.48.190(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAIvm6i_1720681817)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 15:10:19 +0800
Message-ID: <9dbcbbbf-0a09-4619-bb56-d958fa216539@linux.alibaba.com>
Date: Thu, 11 Jul 2024 15:10:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v1] erofs-utils: add OCI registry support
To: saz97 <sa.z@qq.com>, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
 chao@kernel.org
References: <tencent_78540FD071E38E438A3A91E924999DC78409@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_78540FD071E38E438A3A91E924999DC78409@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2024/7/11 13:42, saz97 wrote:
> From: Changzhi Xie <sa.z@qq.com>


The patch title is still wrong:
[PATCH] [PATCH v1] erofs-utils: add OCI registry support

should be
[PATCH] erofs-utils: add OCI registry support
or
[PATCH v1] erofs-utils: add OCI registry support

> 
> This patch adds support for handling OCI registry operations in the EROFS. The following functionalities are included:
> 
> 1. `oci_registry_read`: Reads data from the OCI registry memory structure.
> 2. `oci_registry_pread`: Reads data from a specified offset within the OCI registry memory structure.
> 3. `oci_registry_lseek`: Adjusts the file offset within the OCI registry memory structure.
> 4. `open_oci_registry`: Main function to handle the opening of the OCI registry.
> 
> These changes include the following adjustments:
> - Renaming structures and functions to follow the EROFS naming conventions.
> 
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> ---
>   include/erofs/io.h |   1 -
>   lib/oci_registry.c | 183 ++++++++++++++++++---------------------------
>   2 files changed, 73 insertions(+), 111 deletions(-)
> 
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index e8b6008..f53abed 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -16,7 +16,6 @@ extern "C"
>   #define _GNU_SOURCE
>   #endif
>   #include <unistd.h>
> -
>   #include "defs.h"
>   
>   #ifndef O_BINARY
> diff --git a/lib/oci_registry.c b/lib/oci_registry.c
> index 37fe357..3c21e2d 100644
> --- a/lib/oci_registry.c
> +++ b/lib/oci_registry.c
> @@ -10,24 +10,23 @@
>   #define MANIFEST_MODE 3
>   #define BLOB_MODE 4
>   
> -struct MemoryStruct {
> +struct erofs_oci_registry_memory {
>       char *memory;
>       size_t size;
>   };
>   
> -CURLM *get_multi_handle() {
> +CURLM *erofs_oci_registry_get_multi_handle(void) {

Why it still have a diff?

Could you send it to your email privately (and try to `git am`
first on -dev branch) before sending out to the mailing list?

Thanks,
Gao Xiang
