Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 424C192CB39
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 08:37:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Djm9MNPz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJp7Q6rtCz3cXy
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 16:37:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Djm9MNPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJp7J1S9Sz2yvv
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 16:37:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720593429; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rGP81HZzoTJ1cn0go3sEAWxrerv1dPGfkrSXx390wa4=;
	b=Djm9MNPzrNrOoV6wmFqxrrRXIIJlEHaZNngIffoe2bCFyYBTkWQ0uRtlvE72H2l2Du0qOBAe4mlHqhK3AV1iEetbkyS/TJKAF+538IZucckUrVxXItAoyDnSRVFbWntHbGceeQ2FOr7lA1E0zoBOjBAT56W5QKSHeFZh4A0AyWI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WAE7q-D_1720593425;
Received: from 30.97.48.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAE7q-D_1720593425)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 14:37:06 +0800
Message-ID: <c16f79f0-ee13-4be3-9d49-9835af19a520@linux.alibaba.com>
Date: Wed, 10 Jul 2024 14:37:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add OCI register operation
To: saz97 <sa.z@qq.com>, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
 chao@kernel.org
References: <tencent_1745AA30E8E771EF21C49D597421CCF36308@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_1745AA30E8E771EF21C49D597421CCF36308@qq.com>
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

Hi,

On 2024/7/10 14:13, saz97 wrote:

The patch author still needs to be fixed, you
could use, git commit --amend --author="Changzhi Xie <sa.z@qq.com>" to
achieve that.

Also the patch name should be at least:

[PATCH vX] erofs-utils: add OCI registry support

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

Could you fold it into the original patch
instead (rather than make a new patch on the original
patch..)?

Also you could send patches to yourself for previewing,
anyway.


Thanks,
Gao Xiang
