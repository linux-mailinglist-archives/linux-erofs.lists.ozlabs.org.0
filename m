Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5B7295A5
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 11:41:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qcx10662Rz3f8y
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 19:41:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcx0W2W7bz3f6p
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 19:40:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkhjUWT_1686303653;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkhjUWT_1686303653)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 17:40:54 +0800
Message-ID: <ebe06bc7-13fd-4213-1333-a30a74ab715c@linux.alibaba.com>
Date: Fri, 9 Jun 2023 17:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] erofs-utils: dump: add some superblock fields
To: Guo Xuenan <guoxuenan@huawei.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230609085041.14987-1-guoxuenan@huawei.com>
 <20230609085041.14987-5-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230609085041.14987-5-guoxuenan@huawei.com>
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



On 2023/6/9 16:50, Guo Xuenan via Linux-erofs wrote:
> dump.erofs show compression algorithms and sb_extslots,
> and update feature information.
> 
> The proposed super block info is shown as below:
> Filesystem magic number:                      0xE0F5E1E2
> Filesystem blocks:                            4624
> Filesystem inode metadata start block:        0
> Filesystem shared xattr metadata start block: 0
> Filesystem root nid:                          37
> Filesystem compr_algs:                        lz4, lz4hc, lzma
> Filesystem sb_extslots:                       0
> Filesystem inode count:                       6131
> Filesystem created:                           Wed Jun  7 17:15:44 2023
> Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster
> Filesystem UUID:                              not available
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>   dump/main.c              | 11 +++++++++++
>   include/erofs/internal.h |  1 +
>   lib/super.c              |  5 +++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/dump/main.c b/dump/main.c
> index ae1ffa0..2cb412d 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -94,12 +94,14 @@ static struct erofsdump_feature feature_lists[] = {
>   	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
>   	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
>   	{ false, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
> +	{ false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
>   	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
>   	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
>   	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
>   	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
>   	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
>   	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
> +	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
>   };
>   
>   static int erofsdump_readdir(struct erofs_dir_context *ctx);
> @@ -609,6 +611,15 @@ static void erofsdump_show_superblock(void)
>   	if (erofs_sb_has_fragments() && sbi.packed_nid > 0)
>   		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
>   			sbi.packed_nid | 0ULL);
> +	if (erofs_sb_has_compr_cfgs()) {
> +		fprintf(stdout, "Filesystem compr_algs:                        ");
> +		zerofs_print_supported_compressors(stdout, sbi.available_compr_algs);
> +	} else {
> +		fprintf(stdout, "Filesystem lz4_max_dist:                      %u\n",

lz4_max_distance is better, let's keep the on-disk full name.
