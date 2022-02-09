Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212274AE65A
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 02:48:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtjSm5t5vz3Wtp
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 12:48:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtjSj5lllz2yNv
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 12:48:05 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V3yQUK-_1644371276; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3yQUK-_1644371276) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 09:47:57 +0800
Date: Wed, 9 Feb 2022 09:47:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] erofs-utils: Print configuration only at INFO debug level
Message-ID: <YgMdSx0bq6exdRE5@B-P7TQMD6M-0146.local>
References: <20220209005307.1288161-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209005307.1288161-1-pcc@google.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 08, 2022 at 04:53:06PM -0800, Peter Collingbourne wrote:
> The information printed by erofs_show_config is not useful for ordinary
> users of the program, and it certainly doesn't count as a warning,
> so let's only print it at the INFO debug level or greater.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Applied, thanks!

Thanks,
Gao Xiang

> ---
>  lib/config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/config.c b/lib/config.c
> index 363dcc5..08deb6f 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -34,7 +34,7 @@ void erofs_show_config(void)
>  {
>  	const struct erofs_configure *c = &cfg;
>  
> -	if (c->c_dbg_lvl < EROFS_WARN)
> +	if (c->c_dbg_lvl < EROFS_INFO)
>  		return;
>  	erofs_dump("\tc_version:           [%8s]\n", c->c_version);
>  	erofs_dump("\tc_dbg_lvl:           [%8d]\n", c->c_dbg_lvl);
> -- 
> 2.35.0.263.gb82422642f-goog
