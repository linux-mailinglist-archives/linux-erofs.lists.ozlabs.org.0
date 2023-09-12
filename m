Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846C79C392
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 05:02:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rl7g46xTkz3c4g
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 13:02:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rl7fy2K8xz30P3
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 13:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vrv.wuJ_1694487743;
Received: from 30.97.48.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vrv.wuJ_1694487743)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 11:02:25 +0800
Message-ID: <f58ad3ea-8cc9-1484-9e7c-e73a63c2b8fd@linux.alibaba.com>
Date: Tue, 12 Sep 2023 11:02:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs-utils: mkfs: error return if meets an unknown
 extended option
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20230909123650.2184838-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230909123650.2184838-1-zhaoyifan@sjtu.edu.cn>
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



On 2023/9/9 20:36, Yifan Zhao wrote:
> Currently mkfs would ignore any unknown extended option, which keeps
> silent if a mistyped option is given. Return failure in this case allows
> users to catch their errors more easily.

Applied with some modification:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=e6dd153f48dbb64369b5d4480b734bb61782b8b1

BTW, this patch missed a "Signed-off-by" tag (I added one since we often
talked via WeChat these days), you'd better to add this when submitting
a patch to open-source communities.


> ---
>   mkfs/main.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 607c883..4caf267 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -186,55 +186,55 @@ static int parse_extended_opts(const char *opts)
>   			cfg.c_legacy_compress = true;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
>   			cfg.c_ignore_mtime = true;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			erofs_sb_clear_sb_chksum(&sbi);
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_noinline_data = true;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_ztailpacking = true;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
>   			cfg.c_all_fragments = true;
>   			goto handle_fragment;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
>   			char *endptr;
>   			u64 i;
>   
> @@ -251,17 +251,22 @@ handle_fragment:
>   			}
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_dedupe = true;
>   		}
>   
> -		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
> +		else if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
>   			if (vallen)
>   				return -EINVAL;
>   			cfg.c_xattr_name_filter = !clear;
>   		}
> +
> +		else {
> +			erofs_err("unknown extended option %s", token);
> +			return -EINVAL;
> +		}
>   	}
>   	return 0;
>   }
