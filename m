Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241B904C2
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 17:37:07 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4696rJ0H5CzDrcP
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Aug 2019 01:37:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDX4w929"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4696r63QXzzDrQP
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Aug 2019 01:36:53 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id i18so3112842pgl.11
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding;
 bh=n8+SUr18MVE5Bfw6D/Wa9GNuDObrbDAjDbTgfy0PuxQ=;
 b=aDX4w929TQwQAwNz9QZJ1ScXQGbcR1F6dgHhGroXYLSMfN7rm+7ykXyE2ja3y+Few5
 viGibvydo/fP0K1OcnrpGiqaLtbM5dIJKmpw0LgeusO8nE32Ne8x6bEdNq8l8ct5zyDB
 hzQ8WieJ8xeTO1LvApk0WzCf/+kdIP6acBghkV7ilEBKN3hUgPizj9X2Op65717TtNaW
 sAfLMvILm9gYEafG/fuPBGuJktJ4/G/wt+YltbyEeRCw3sYfr80wQw0fjH4WBNId9sRj
 D9ihpDKpnpGwGLGsWBb148yb5MpIjaok/3GfgFWD7G+nAepGFqFeKAaP9jhrWfVa4KRi
 tDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=n8+SUr18MVE5Bfw6D/Wa9GNuDObrbDAjDbTgfy0PuxQ=;
 b=BImSFDNAM4AJhSjQxlzQmXld63bReCirtZHWVb2aC3diBF07h8vMqGaE5jvaRivrQA
 alt3t6MGOODg9PbLHUT8LU/2ZBeViZg4+/W0bxbfso4PMmKeb8chMpL9UIr2C6jAR2Hm
 cw8+CrjJ66FFTQMQQ4T6F8ZXQFFkLBR1ghK/RhuuSqPM/uijNbrXRfIz4+JnyTHkfkh8
 qSjlupRh2wNUztavjw6BJbpdDU/feUH9wAYe1EhBtEn8+IMTw5Bmgdn2E7nBLW0X677r
 ohPJo74767vVacIDbSfiFYGOyK6ZcSwG1hPsJeROEvGhYKOTrREhwOFsxNNQr5AQUIPk
 a9XQ==
X-Gm-Message-State: APjAAAUbj4qo1uzqN6K5Dc7StMHFZTmHxi3+qKqo5Bg3bYucHGZNbtC7
 f0PAzqeYzp2wIPMOMWoxRBM=
X-Google-Smtp-Source: APXvYqxdBE0HMIzU7TX3qsAMJA4xWhTqw8iORUPWVSFQieW9Gmq8wTwMFAO3ZuXU+NZKz8ruI8OMIw==
X-Received: by 2002:a17:90a:1a1a:: with SMTP id
 26mr7911643pjk.118.1565969809514; 
 Fri, 16 Aug 2019 08:36:49 -0700 (PDT)
Received: from [0.0.0.0] (li104-163.members.linode.com. [72.14.189.163])
 by smtp.gmail.com with ESMTPSA id 185sm10705827pff.54.2019.08.16.08.36.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Aug 2019 08:36:49 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: Fail the image creation when source path is
 not a directory file.
To: Pratik Shinde <pratikshinde320@gmail.com>, linux-erofs@lists.ozlabs.org,
 bluce.liguifu@huawei.com, miaoxie@huawei.com, fangwei1@huawei.com
References: <20190816085620.22266-1-pratikshinde320@gmail.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <b6574e5c-22f8-02d1-bf0a-eeb81f300219@gmail.com>
Date: Fri, 16 Aug 2019 23:36:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190816085620.22266-1-pratikshinde320@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


在 2019/8/16 16:56, Pratik Shinde 写道:
> In the erofs.mkfs utility, if the source path is not a directory,image
> creation should not proceed.since root of the filesystem needs to be a directory.
> 
> moving the check to main function.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

It looks good.
Reviewed-by Li Guifu <blucerlee@gmail.com>
Thanks


> ---
>   mkfs/main.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 93cacca..8fbfced 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -12,6 +12,7 @@
>   #include <stdlib.h>
>   #include <limits.h>
>   #include <libgen.h>
> +#include <sys/stat.h>
>   #include "erofs/config.h"
>   #include "erofs/print.h"
>   #include "erofs/cache.h"
> @@ -187,6 +188,7 @@ int main(int argc, char **argv)
>   	struct erofs_buffer_head *sb_bh;
>   	struct erofs_inode *root_inode;
>   	erofs_nid_t root_nid;
> +	struct stat64 st;
>   
>   	erofs_init_configure();
>   	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
> @@ -197,6 +199,15 @@ int main(int argc, char **argv)
>   			usage();
>   		return 1;
>   	}
> +	err = lstat64(cfg.c_src_path, &st);
> +	if (err)
> +		return 1;
> +	if ((st.st_mode & S_IFMT) != S_IFDIR) {
> +		erofs_err("root of the filesystem is not a directory - %s",
> +			  cfg.c_src_path);
> +		usage();
> +		return 1;
> +	}
>   
>   	err = dev_open(cfg.c_img_path);
>   	if (err) {
> 
