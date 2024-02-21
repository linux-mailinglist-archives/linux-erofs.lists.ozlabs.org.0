Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F22985CDDA
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 03:18:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Wx3nZERX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tfg1Y69d5z3c2K
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 13:18:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Wx3nZERX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tfg1S18kfz3bZN
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Feb 2024 13:18:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708481906; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u91vHPmTfNCmbDbQ1w3BDcSiany6MNqpaa6ax/w7hOY=;
	b=Wx3nZERXts5psZeZQLDfIt0M6zWORufK9CQMENWoKXdY3NHjFm1p2aTGxeq0N8PVytIRDnWd5j0lMcDt5trnl7doSY+UrO6Q4khvNnd5gGWelawrRqCkfPF3FnaQErQghYRtztZLCM/ROcOnLjZMMFOW3uKdvItD4S6bx5XBQg8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0yLCp9_1708481903;
Received: from 30.97.48.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0yLCp9_1708481903)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 10:18:24 +0800
Message-ID: <6c2d5345-98bc-49b1-adc7-bcc349a0a6bb@linux.alibaba.com>
Date: Wed, 21 Feb 2024 10:18:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix refcount on the metabuf used for inode
 lookup
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240220191114.3272126-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240220191114.3272126-1-dhavale@google.com>
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
Cc: quic_wenjieli@quicinc.com, linux-erofs@lists.ozlabs.org, kernel-team@android.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/2/21 03:11, Sandeep Dhavale wrote:
> In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
> we do not assign the target metabuf. This causes the caller
> erofs_namei()'s erofs_put_metabuf() at the end to be not effective
> leaving the refcount on the page.
> As the page from metabuf (buf->page) is never put, such page cannot be
> migrated or reclaimed. Fix it now by putting the metabuf from
> previous loop and assigning the current metabuf to target before
> returning so caller erofs_namei() can do the final put as it was
> intended.
> 
> Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Many thanks for the catch!

> ---
>   fs/erofs/namei.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index d4f631d39f0f..bfe1c926436b 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -132,7 +132,10 @@ static void *erofs_find_target_block(struct erofs_buf *target,
>   
>   			if (!diff) {
>   				*_ndirents = 0;
> -				goto out;
> +				if (!IS_ERR(candidate))
> +					erofs_put_metabuf(target);
> +				*target = buf;
> +				return de;
>   			} else if (diff > 0) {
>   				head = mid + 1;
>   				startprfx = matched;

The fix is correct, yet I tend to try to reorganize this snippet for
simplicity, how about the following diff (untested)?

If it looks good to you, could you resend a formal patch? Thanks!

Thanks,
Gao Xiang

  fs/erofs/namei.c | 29 ++++++++++++++---------------
  1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..9fb2d627578e 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -129,25 +129,24 @@ static void *erofs_find_target_block(struct erofs_buf *target,

  			/* string comparison without already matched prefix */
  			diff = erofs_dirnamecmp(name, &dname, &matched);
-
-			if (!diff) {
-				*_ndirents = 0;
-				goto out;
-			} else if (diff > 0) {
-				head = mid + 1;
-				startprfx = matched;
-
-				if (!IS_ERR(candidate))
-					erofs_put_metabuf(target);
-				*target = buf;
-				candidate = de;
-				*_ndirents = ndirents;
-			} else {
+			if (diff < 0) {
  				erofs_put_metabuf(&buf);
-
  				back = mid - 1;
  				endprfx = matched;
+				continue;
  			}
+
+			if (!IS_ERR(candidate))
+				erofs_put_metabuf(target);
+			*target = buf;
+			if (!diff) {
+				*_ndirents = 0;
+				return de;
+			}
+			head = mid + 1;
+			startprfx = matched;
+			candidate = de;
+			*_ndirents = ndirents;
  			continue;
  		}
  out:		/* free if the candidate is valid */
--
2.39.3
