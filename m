Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D565B7916FF
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Sep 2023 14:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1693829929;
	bh=nWkM5E8aVFjTpHfmPewiJjdmneSbNCZBSReAtLpqW1Q=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Wevnr4FlkuZtqeOcjK2bSFLF9+mq8+y96Gw3+hU9/2NtIAhEZB7wp+K7riB52Pzud
	 bt1k4FjsCZb1Tg5HryrhdAjfMlC/ui9R0HAH9zMk+2Q0bbgB/5idyHn8r0XAEQ3MG1
	 CxJ7BvCpjWL35patDQfwUrV7YlkT0Qy6cFOlcOUIVwdAZAU87Q8KZK6fkMrnY146Vw
	 DwUVomBy8QvlvfD+lc1S8oaFotWLcYDr/lBdX215cH6jzL7XVE0i+t5oBgqYzcsLbo
	 QGZKKWgGkZuo69XKodpSVJN2y5CCvhm1CkmoZ/D/zeMbAtGoAwpvtDIL3wi3Dqi7cR
	 FPxjkJHIpZW9w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RfSNT1B8wz3bV7
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Sep 2023 22:18:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=guoxuenan@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RfSNL4knXz2xwD
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Sep 2023 22:18:38 +1000 (AEST)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RfSHv2NdfzNn2D;
	Mon,  4 Sep 2023 20:14:51 +0800 (CST)
Received: from [10.174.177.238] (10.174.177.238) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 20:18:30 +0800
Message-ID: <e8d63bd1-c5cd-cef1-fd34-95ded77abc58@huawei.com>
Date: Mon, 4 Sep 2023 20:18:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 RESEND] erofs-utils: fsck: refuse illegel filename
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20230904095127.61351-1-hsiangkao@linux.alibaba.com>
 <20230904095311.65096-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20230904095311.65096-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.238]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,
On 2023/9/4 17:53, Gao Xiang wrote:
> From: Guo Xuenan <guoxuenan@huawei.com>
>
> In some crafted erofs images, fsck.erofs may write outside the
> destination directory, which may be used to do some dangerous things.
>
> This commit fixes by checking all directory entry names with a '/'
> character when fscking.  Squashfs also met the same situation [1],
> and have already fixed it here [2].
>
> [1] https://github.com/plougher/squashfs-tools/issues/72
> [2] https://github.com/plougher/squashfs-tools/commit/79b5a555058eef4e1e7ff220c344d39f8cd09646
> Fixes: 412c8f908132 ("erofs-utils: fsck: add --extract=X support to extract to path X")
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/r/20230531072612.2643983-2-guoxuenan@huawei.com
>
> changes since v1:
>   - check this only if fsck is enabled (extraction and fsck is impacted);
>
>   - don't treat the middle '\0' as an illegel name since such cases are
>     actually reserved and can be handled properly.
>
>   lib/dir.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/lib/dir.c b/lib/dir.c
> index fff0bc0..3731f0c 100644
> --- a/lib/dir.c
> +++ b/lib/dir.c
> @@ -4,6 +4,19 @@
>   #include "erofs/print.h"
>   #include "erofs/dir.h"
>   
> +/* filename should not have a '/' in the name string */
> +static bool erofs_validate_filename(const char *dname, int size)
> +{
> +	char *name = (char *)dname;
> +
> +	while (name - dname < size) {
> +		if (*name == '/')
> +			return false;
> +		++name;
> +	}
> +	return true;
> +}
> +
>   static int traverse_dirents(struct erofs_dir_context *ctx,
>   			    void *dentry_blk, unsigned int lblk,
>   			    unsigned int next_nameoff, unsigned int maxsize,
> @@ -102,6 +115,10 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
>   				}
>   				break;
>   			}
> +		} else if (fsck &&
> +			   !erofs_validate_filename(de_name, de_namelen)) {
> +			errmsg = "corrupted dirent with illegal filename";
> +			goto out;
>   		}
>   		ret = ctx->cb(ctx);
>   		if (ret) {
Reviewed-by： Guo Xuenan <guoxuenan@huawei.com>

Thanks
Xuenan

-- 
Guo Xuenan [OS Kernel Lab]
-----------------------------
Email: guoxuenan@huawei.com

