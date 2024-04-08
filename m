Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F11C89CE8B
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 00:48:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q6mjhy3B;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VD45N4Whdz3cNt
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 08:48:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q6mjhy3B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VD45G301fz3bbW
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 08:48:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712616524; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nz3YIIIQmU8yWVDXM1ZV8xt6EYuCL7CXXu2zWkKWpgo=;
	b=Q6mjhy3BTvirgUtPCvvCBYYdJcU7hR53jNNRSZiNzRQxteSmLd5YQLbi9pHGLmZk4JFO83TlPsvr5wOQ4SRZgkbgEmqG9se4Z0TR8xiW7HoIN1Mg9iSXbakwIA6Hqav2nO8hzQWuk/W/0mZQyYRToCGdOTyWnF5R6Aiu5tVBVh4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4CNr.I_1712616521;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4CNr.I_1712616521)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 06:48:42 +0800
Message-ID: <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
Date: Tue, 9 Apr 2024 06:48:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>
References: <20240408215231.3376659-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240408215231.3376659-1-dhavale@google.com>
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
Cc: kernel-team@android.com, syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/4/9 05:52, Sandeep Dhavale wrote:
> erofs will decompress in the preemptible context (kworker or per cpu
> thread). As smp_processor_id() cannot be used in preemptible contexts,
> use raw_smp_processor_id() instead to index into global buffer pool.
> 
> Reported-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com
> Fixes: 7a7513292cc6 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks for catching this, since the original patch is
for next upstream cycle, may I fold this fix in the
original patch?

I will add your credit into the original patch.

Thanks,
Gao Xiang

> ---
>   fs/erofs/zutil.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index b9b99158bb4e..036024bce9f7 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -30,7 +30,7 @@ static struct shrinker *erofs_shrinker_info;
>   
>   static unsigned int z_erofs_gbuf_id(void)
>   {
> -	return smp_processor_id() % z_erofs_gbuf_count;
> +	return raw_smp_processor_id() % z_erofs_gbuf_count;
>   }
>   
>   void *z_erofs_get_gbuf(unsigned int requiredpages)
