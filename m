Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B136E57D8FC
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 05:28:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lpvzf3rgNz3c7M
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 13:28:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpvzY6mRLz302W
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 13:28:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK3NE68_1658460507;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VK3NE68_1658460507)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 11:28:29 +0800
Date: Fri, 22 Jul 2022 11:28:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH RESEND] erofs-utils: fix a memory leak of multiple devices
Message-ID: <YtoZWyzXw97cXY+j@B-P7TQMD6M-0146.local>
References: <20220722031008.21819-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722031008.21819-1-huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Fri, Jul 22, 2022 at 11:10:08AM +0800, Yue Hu wrote:
> The memory allocated for multiple devices should be freed when to exit.
> Let's add a helper to fix it since there is more than one to use it.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  dump/main.c              | 7 ++++---
>  fsck/main.c              | 7 ++++---
>  fuse/main.c              | 5 +++--
>  include/erofs/internal.h | 1 +
>  lib/super.c              | 6 ++++++
>  5 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 40e850a..c9b3a8f 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -615,7 +615,7 @@ int main(int argc, char **argv)
>  	err = erofs_read_superblock();
>  	if (err) {
>  		erofs_err("failed to read superblock");
> -		goto exit_dev_close;
> +		goto exit_put_super;
>  	}
>  
>  	if (!dumpcfg.totalshow) {
> @@ -630,13 +630,14 @@ int main(int argc, char **argv)
>  
>  	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
>  		usage();
> -		goto exit_dev_close;
> +		goto exit_put_super;
>  	}
>  
>  	if (dumpcfg.show_inode)
>  		erofsdump_show_fileinfo(dumpcfg.show_extent);
>  
> -exit_dev_close:
> +exit_put_super:
> +	erofs_put_super();
>  	dev_close();
>  exit:
>  	blob_closeall();
> diff --git a/fsck/main.c b/fsck/main.c
> index 5a2f659..a8f0e24 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -813,12 +813,12 @@ int main(int argc, char **argv)
>  	err = erofs_read_superblock();
>  	if (err) {
>  		erofs_err("failed to read superblock");
> -		goto exit_dev_close;
> +		goto exit_put_super;

Why do we call erofs_put_super() again here? I think we don't need to
call erofs_put_super for all failed paths.

Thanks,
Gao Xiang
