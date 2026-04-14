Return-Path: <linux-erofs+bounces-3299-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MtrAsZk3mmcDgAAu9opvQ
	(envelope-from <linux-erofs+bounces-3299-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 18:01:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4003FC413
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 18:01:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw8C35GPhz2yVL;
	Wed, 15 Apr 2026 02:01:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776182463;
	cv=none; b=GSgghxzkWHwXy8YF9J+hlpqCNuyK6MeCEv75cN+jtgC1/3xV1MD8hzvCJ3dbGx2+SlBsG6P9/2zG8K65mTMvcnRE6s8nlcVssK9N4ZDoD98/OrKO1bf96zysWw0kjhy2v2MbNs7xVRjO5AhAGs83r7sl1RxSXuoh8kAsaPxcta+2jfK4s01L2FraYn3CLLca/d4JHtXXQzo5IbFrbH9wRjRBhqm2aN48GdwxzQhHlSO+keA678JtC3cfAhJl/TleWtl0nQZIWY2+qsWavVeNkGLME5LLJsJw3a0P8p/kKGpu9Jgj2zUqxeqE1r36PGxObOTligzXieY2ubYYvDtXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776182463; c=relaxed/relaxed;
	bh=lISCl8I5Buw+OwTlgs9srKojhMfaMOl9ogFWa04xFyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLDEsUvU3RwSsK25myjcrBgUl+6iUbp8/4vqQ7Vx7kOimopR9wRRtPO7ayCgJFvKZ2RPrZabQ86rjHSldlxz57GPnEjBOZftdISYWgJrccjM/lvw3jpTPtu3Gwec3RlmBweEbS0TOo0X5lZs0WSQ7ouOz3GSGN+8uOjopF2iQrPi3VAM6d7Fm41WsTgDxdljL70CEcZsaIhiIADLKXglOn+vl0YYeOEsH3w9LJzL7/KyLxg0q3sVXymjnSPCWmGozH6Ejo0HpjpePnqBjJyFVGIi2BpAmbuE8JhfMLCn4jkk5eAGGt8ofaiLMAvNMCOCmIYg3+nxCCTf0uI2HeBLcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nJRSh/Lj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nJRSh/Lj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw8Bz5P3jz2ySS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 02:00:57 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776182453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lISCl8I5Buw+OwTlgs9srKojhMfaMOl9ogFWa04xFyE=;
	b=nJRSh/LjMOQs/76L19m/B1iqPYv2KFy4qCOxOx7njGRi5dGEkoCo6SklmqxNUkO/0paII0DxPERmFwjNU4isd+JaahZMnNIFpOHhItZKlxwFWAt1v0WHkH61dithOkEdhagiwpvNCwGC/TMVGvaSXtTv0WA5xo6eTbnUq89RovE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X11pYal_1776182448;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X11pYal_1776182448 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 00:00:49 +0800
Message-ID: <d373198b-d32a-49f4-9044-63c7b474f2ea@linux.alibaba.com>
Date: Wed, 15 Apr 2026 00:00:48 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Miao Xie <miaoxie@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:danisjiang@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:miaoxie@huawei.com,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3299-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org,linux.alibaba.com,google.com,huawei.com,vivo.com,linuxfoundation.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: BD4003FC413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Junrui,

On 2026/4/14 23:20, Junrui Luo wrote:
> erofs_readdir() validates de[0].nameoff before calling
> erofs_fill_dentries(), but subsequent dirents are used without
> validation. The loop computes `maxsize - nameoff` as an unsigned int
> to bound strnlen().

The issue is true, but I don't think the description is valid.

I think what we missed is to check the last dirent nameoff vs
maxsize.

BTW, please don't "To" too many people (especially Miao Xie
and Greg), basically I think you only need to post to people
according to `./checkpoint.pl` but leave indivudual person
into "Cc" instead.

> 
> If a crafted EROFS image has a dirent with nameoff >= maxsize, the
> subtraction underflows, causing strnlen() to read past the block
> buffer.
> 
> Fix by validating each entry's nameoff at the top of the loop: it
> must be >= nameoff0 and <= maxsize.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>   fs/erofs/dir.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index e5132575b9d3..2efa16fa162f 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -19,6 +19,13 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   		const char *de_name = (char *)dentry_blk + nameoff;
>   		unsigned int de_namelen;
>   
> +		if (nameoff < nameoff0 || nameoff > maxsize) {
> +			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
> +				  EROFS_I(dir)->nid);
> +			DBG_BUGON(1);
> +			return -EFSCORRUPTED;
> +		}

I think the only thing we need is the following diff:

[The reason why nameoff < nameoff0 is unneeded, since
  `de_namelen > EROFS_NAME_LEN` ensures the nameoff delta
  won't be negative (so nameoff will increase.)

  and `nameoff + de_namelen > maxsize` implies
  `nameoff > maxsize` so `nameoff > maxsize` is unneeded too.]

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..e0666d6da9af 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -20,19 +20,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		unsigned int de_namelen;

  		/* the last dirent in the block? */
-		if (de + 1 >= end)
+		if (de + 1 >= end) {
+			if (maxsize <= nameoff)
+				goto err_bogus;
  			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		} else {
  			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		}

  		/* a corrupted entry is found */
  		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		    de_namelen > EROFS_NAME_LEN)
+			goto err_bogus;

  		if (!dir_emit(ctx, de_name, de_namelen,
  			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
@@ -42,6 +41,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		ctx->pos += sizeof(struct erofs_dirent);
  	}
  	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
  }

  static int erofs_readdir(struct file *f, struct dir_context *ctx)


Thanks,
Gao Xiang

> +
>   		/* the last dirent in the block? */
>   		if (de + 1 >= end)
>   			de_namelen = strnlen(de_name, maxsize - nameoff);
> 
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260414-fixes-ae20cd389f52
> 
> Best regards,


