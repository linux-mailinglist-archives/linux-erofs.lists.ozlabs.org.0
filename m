Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E68B6A6B31
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 11:59:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PRWSn6VPcz3cJY
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 21:59:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BVJ4wMS2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BVJ4wMS2;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PRWSd2X0vz30Jy
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 21:58:55 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id p20so12332973plw.13
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Mar 2023 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677668333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uHN4WLC2mU6ITvy5aTpJo7RGVE3NWfrwcLgzUGDqlQ=;
        b=BVJ4wMS2qmaz0Cwf+2oq5re+Nm9wfNWrjbZjEUYWUjU3XHVxO2UXpCdksSF7UEltGE
         Du5paPMU+2CBoMIn+RAmfDuYGg7ppwRTwMkMShvprVSO3Et78phwJTGQ0qqQNc3636fd
         r1jZJkrY7ZPyp3pGIuY+loESj1e9RVNk1CMpbY2Hf6GwccyDKLKuAMG1KiCXO5EzwwVn
         mtshqZWf0TWmqgp9kZyxN8VABXFV1U6C8V9yWIAkKotCTwqR++67cdJg193sGkJFGs8r
         CzFyqej7TJ66fPuR/Z5qVSm4VKB8oCA6+J8MgaYLjmOiSzisca75wAJxdkb8l0tcXueR
         NJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677668333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uHN4WLC2mU6ITvy5aTpJo7RGVE3NWfrwcLgzUGDqlQ=;
        b=4IV9xA/wdMcgtXlkworzKnvOFjnDiJte533Ompt26x1nXGPOkm02xEiCOPiXQVwLxx
         H4OwJeQ1KQqVvR9RgLX0H0EwPf/A3HWD7liuRSbxj19KX6lBVvaiD/5IiVRh7CgTGu6b
         9biat2tyxJUPBtW2mv+PWS4oX+KPe+wpu+iXxh+51ePEBYE31WOce9B9tbHJrKQjRb5m
         LVxiJh4f+imL2guFugxFJb5gv/Dcw2wgSrlafylYsh6vVEHJYCj+z6zwnX9q57sV+Tpq
         DJQQmafM9GT+g/uooligU1mE0qUASbNM6iUMYYD7724RX2wReJx9ODPUP0bOJUJBhFcl
         BSiA==
X-Gm-Message-State: AO0yUKVPObCYJIdd3ToqK+/LHT6VPVeL+LPvQGnAeseLsQkRwTXWoXms
	wLfc5gGge8OSCh6/rVrEEq4=
X-Google-Smtp-Source: AK7set/I2yywgZ6j9j1dWnUIkOySbPMKb0t+A1rygzFG5ikMq8+42iCqwxf95CDK9erRoLYBWwAQXw==
X-Received: by 2002:a17:902:e74e:b0:19c:ed28:66ec with SMTP id p14-20020a170902e74e00b0019ced2866ecmr7087131plf.21.1677668332832;
        Wed, 01 Mar 2023 02:58:52 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902b11300b001963bc7bdb8sm8150782plr.274.2023.03.01.02.58.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Mar 2023 02:58:52 -0800 (PST)
Date: Wed, 1 Mar 2023 19:05:03 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/3] erofs-utils: get rid of useless nr_dup
Message-ID: <20230301190503.00006aab.zbestahu@gmail.com>
In-Reply-To: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
References: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed,  1 Mar 2023 02:54:57 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Also refine the longest detection.
> 
> Fixes: 990c7e383795 ("erofs-utils: mkfs: support fragment deduplication")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  lib/fragments.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/fragments.c b/lib/fragments.c
> index c67c1bb..1e41485 100644
> --- a/lib/fragments.c
> +++ b/lib/fragments.c
> @@ -26,7 +26,7 @@
>  
>  struct erofs_fragment_dedupe_item {
>  	struct list_head	list;
> -	unsigned int		length, nr_dup;
> +	unsigned int		length;
>  	erofs_off_t		pos;
>  	u8			data[];
>  };
> @@ -53,7 +53,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
>  	struct erofs_fragment_dedupe_item *cur, *di = NULL;
>  	struct list_head *head;
>  	u8 *data;
> -	unsigned int length, e2;
> +	unsigned int length, e2, deduped;
>  	int ret;
>  
>  	head = &dupli_frags[FRAGMENT_HASH(crc)];
> @@ -83,6 +83,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
>  
>  	DBG_BUGON(length <= EROFS_TOF_HASHLEN);
>  	e2 = length - EROFS_TOF_HASHLEN;
> +	deduped = 0;
>  
>  	list_for_each_entry(cur, head, list) {
>  		unsigned int e1, mn, i = 0;
> @@ -97,22 +98,22 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
>  		while (i < mn && cur->data[e1 - i - 1] == data[e2 - i - 1])
>  			++i;
>  
> -		if (i && (!di || i + EROFS_TOF_HASHLEN > di->nr_dup)) {
> -			cur->nr_dup = i + EROFS_TOF_HASHLEN;
> +		if (!di || i + EROFS_TOF_HASHLEN > deduped) {
> +			deduped = i + EROFS_TOF_HASHLEN;
>  			di = cur;
>  
>  			/* full match */
> -			if (i == mn)
> +			if (i == e2)
>  				break;
>  		}
>  	}
>  	if (!di)
>  		goto out;
>  
> -	DBG_BUGON(di->length < di->nr_dup);
> +	DBG_BUGON(di->length < deduped);
>  
> -	inode->fragment_size = di->nr_dup;
> -	inode->fragmentoff = di->pos + di->length - di->nr_dup;
> +	inode->fragment_size = deduped;
> +	inode->fragmentoff = di->pos + di->length - deduped;
>  
>  	erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
>  		  inode->fragmentoff | 0ULL);
> @@ -161,7 +162,6 @@ static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
>  	memcpy(di->data, data, len);
>  	di->length = len;
>  	di->pos = pos;
> -	di->nr_dup = 0;
>  
>  	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
>  	return 0;

