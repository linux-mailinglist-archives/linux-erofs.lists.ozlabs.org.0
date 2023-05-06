Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6927E6F8E4E
	for <lists+linux-erofs@lfdr.de>; Sat,  6 May 2023 05:23:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QCtDq1fnZz3f8H
	for <lists+linux-erofs@lfdr.de>; Sat,  6 May 2023 13:23:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QCtDh2bLqz3bfk
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 May 2023 13:23:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vhrkkbi_1683343406;
Received: from 30.221.148.23(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vhrkkbi_1683343406)
          by smtp.aliyun-inc.com;
          Sat, 06 May 2023 11:23:27 +0800
Message-ID: <12995da7-71e5-14c5-82ad-acf1c549d82a@linux.alibaba.com>
Date: Sat, 6 May 2023 11:23:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: fix `-Ededupe` crash without fragments
 enabled
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230506025117.99972-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230506025117.99972-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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



On 5/6/23 10:51 AM, Gao Xiang wrote:
> Otherwise, an unexpected segfault will happen since
>   EROFS_FEATURE_INCOMPAT_FRAGMENTS and
>   EROFS_FEATURE_INCOMPAT_DEDUPE    share the same bit.
> 
> Fixes: 18fbf7d12e4f ("erofs-utils: build xattrs upon extra long name prefixes")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/xattr.c | 1 +
>  mkfs/main.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 5e9e413..9c87227 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -646,6 +646,7 @@ int erofs_xattr_write_name_prefixes(FILE *f)
>  		if (fseek(f, offset, SEEK_SET))
>  			return -errno;
>  	}
> +	cfg.c_fragments = true;
>  	erofs_sb_set_fragments();
>  	erofs_sb_set_xattr_prefixes();
>  	return 0;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 467ea86..ddedfde 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -903,7 +903,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	packed_nid = 0;
> -	if (erofs_sb_has_fragments()) {
> +	if (cfg.c_fragments && erofs_sb_has_fragments()) {
>  		erofs_update_progressinfo("Handling packed_file ...");
>  		packed_inode = erofs_mkfs_build_packedfile();
>  		if (IS_ERR(packed_inode)) {

We have cfg.c_extra_ea_name_prefixes now.  How about

	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
            erofs_sb_has_fragments())

-- 
Thanks,
Jingbo
