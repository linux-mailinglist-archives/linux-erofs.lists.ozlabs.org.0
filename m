Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4688CE0A0
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 07:36:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ajWYRrRi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vltqq0WJxz87Pv
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 15:28:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ajWYRrRi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vltqg4twWz87PY
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 15:28:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716528503; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uxec61oqvvNkG1U4LtX74AUsGqdA7xzD/P6me9hmdS0=;
	b=ajWYRrRiwDGN0qPpOWxM/J4GYji274rxGbuf26lZngX/1q4oUa5oIjbn1nyFj973PXjEdq2UnIOV7wvLPed00Wh1+J+FpKXVeDWPxG6rEKPxIrDWv03WimNllxWPMx5FSM6cJv76BMKGNM2xCPwFt3PTd0PvVRTsu8hFBRItioE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W74tZsN_1716528501;
Received: from 30.97.48.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W74tZsN_1716528501)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 13:28:22 +0800
Message-ID: <9c08c099-6fb2-4032-b8f6-1d6008e1375a@linux.alibaba.com>
Date: Fri, 24 May 2024 13:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: lib: improve freeing hashmap in
 erofs_blob_exit()
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240523210131.3126753-1-dhavale@google.com>
 <20240523210131.3126753-3-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240523210131.3126753-3-dhavale@google.com>
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
Cc: kernel-team@android.com, junbeom.yeom@samsung.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/5/24 05:01, Sandeep Dhavale wrote:
> Depending on size of the filesystem being built there can be huge number
> of elements in the hashmap. Currently we call hashmap_iter_first() in
> while loop to iterate and free the elements. However technically
> correct, this is inefficient in 2 aspects.
> 
> - As we are iterating the elements for removal, we do not need overhead of
> rehashing.
> - Second part which contributes hugely to the performance is using
> hashmap_iter_first() as it starts scanning from index 0 throwing away
> the previous successful scan. For sparsely populated hashmap this becomes
> O(n^2) in worst case.
> 
> Lets fix this by disabling hashmap shrink which avoids rehashing
> and use hashmap_iter_next() which is now guaranteed to iterate over
> all the elements while removing while avoiding the performance pitfalls
> of using hashmap_iter_first().
> 
> Test with random data shows performance improvement as:
> 
> fs_size  Before   After
> 1G 	 23s 	  7s
> 2G 	 81s      15s
> 4G	 272s     31s
> 8G 	 1252s	  61s

Sigh.. BTW, in the long term, I guess we might need to
find a better hashmap implementation (with MIT or BSD
license) instead of this one.

> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>> ---
>   lib/blobchunk.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 645bcc1..8082aa4 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -548,11 +548,17 @@ void erofs_blob_exit(void)
>   	if (blobfile)
>   		fclose(blobfile);
>   
> -	while ((e = hashmap_iter_first(&blob_hashmap, &iter))) {
> +	/* Disable hashmap shrink, effectively disabling rehash.
> +	 * This way we can iterate over entire hashmap efficiently
> +	 * and safely by using hashmap_iter_next() */

I will fix up the comment style manually, otherwise it
looks good to me...

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
