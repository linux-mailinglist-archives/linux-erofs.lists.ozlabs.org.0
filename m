Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6667236CF
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 07:27:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZzWk5PBKz3cjW
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 15:27:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZzWf1q7Gz3bsS
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 15:27:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkUvX9S_1686029253;
Received: from 30.97.48.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkUvX9S_1686029253)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 13:27:34 +0800
Message-ID: <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
Date: Tue, 6 Jun 2023 13:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: dump: add some superblock fields display
To: Guo Xuenan <guoxuenan@huawei.com>, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230606035511.1114101-1-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230606035511.1114101-1-guoxuenan@huawei.com>
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xuenan,

On 2023/6/6 11:55, Guo Xuenan wrote:
> dump.erofs show compression algothrims and sb_exslots,

			     ^ algorithms and sb_extslots

> and update feature information.
> 
> th current super block info displayed as follows:

The proposed super block info is shown as below:

> Filesystem magic number:                      0xE0F5E1E2
> Filesystem blocks:                            4637
> Filesystem inode metadata start block:        0
> Filesystem shared xattr metadata start block: 0
> Filesystem root nid:                          37
> Filesystem compr_algs:                        lz4 lzma
> Filesystem sb_extslots:                       0
> Filesystem inode count:                       36
> Filesystem created:                           Tue Jun  6 10:23:02 2023
> Filesystem features:                          sb_csum mtime lz4_0padding compr_cfgs big_pcluster
> Filesystem UUID:                              not available
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>   dump/main.c              | 34 +++++++++++++++++++++++++++++++++-
>   include/erofs/internal.h |  1 +
>   lib/super.c              |  5 +++++
>   3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index efbc82b..20e1456 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -93,13 +93,25 @@ struct erofsdump_feature {
>   static struct erofsdump_feature feature_lists[] = {
>   	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
>   	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
> -	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
> +	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "lz4_0padding" },

Better to keep it as is (see kernel code.)

> +	{ false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
>   	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
>   	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
>   	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
>   	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
>   	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
>   	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
> +	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
> +};
> +
> +struct available_alg {
> +	int type;
> +	const char *name;
> +};

Could we use lib/compressor.c instead?

Thanks,
Gao Xiang
