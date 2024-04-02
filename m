Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33306894AF7
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 07:52:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dHQ80AZs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7xpw01s3z3d4D
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 16:52:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dHQ80AZs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7xpl2J4Kz30Pp
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 16:51:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712037112; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mGcG/cW2n5pGWPoDJ1G+6hrUFwL/zQzHBNJ/FNOBvLA=;
	b=dHQ80AZsrMcScKhVzrwbJd7ck/wHsp9qApqjUcZkNlBfQJ9I2XqKUAsGOntee3IVkwSPICWfL6hmtBe25Yz+MtnQdY5GgypMaj1QvjiukOxuFox+kJsmFlO3C8vc4MqD8pfN29QUjlPrkmOfZis9TIAxM6wN+B9TQh8O8YbLZ2g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W3nGPa9_1712037109;
Received: from 30.221.146.151(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W3nGPa9_1712037109)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 13:51:50 +0800
Message-ID: <214a8e00-377c-421e-bdbf-2711bbb49c80@linux.alibaba.com>
Date: Tue, 2 Apr 2024 13:51:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: set opaque flag for directories in tarerofs
 mode
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240402025858.1729161-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240402025858.1729161-1-hsiangkao@linux.alibaba.com>
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



On 4/2/24 10:58 AM, Gao Xiang wrote:
> Opaque dir flag is needed if the tar tree is used immediately for
> the upcoming append mode.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/tar.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/tar.c b/lib/tar.c
> index 7c271f6..b45657d 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -909,6 +909,11 @@ restart:
>  	} else if (opq) {
>  		DBG_BUGON(d->type == EROFS_FT_UNKNOWN);
>  		DBG_BUGON(!d->inode);
> +		/*
> +		 * needed if the tar tree is used soon, thus we have no chance
> +		 * to generate it from xattrs.  No impact to mergefs.
> +		 */
> +		d->inode->opaque = true;
>  		ret = erofs_set_opaque_xattr(d->inode);
>  		goto out;
>  	} else if (th->typeflag == '1') {	/* hard link cases */

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
