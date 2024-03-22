Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9E886C8C
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 14:04:38 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O4CEGulB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1Mwz6bqFz3vnm
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 00:04:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O4CEGulB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1Mwr1NqXz3vkm
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Mar 2024 00:04:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711112661; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aPu+hp0F8gTrnWS/U28X+hurv6YrN+P72dhu0BUHDuk=;
	b=O4CEGulBTGFWD1NOr3wUBBR/IzfccSTM5NEZMatxpIU7zBsRlkahLuDCoTj7nPsxwkW9rJxriNiFuFucOoYJvup2CbAiaIlCAokyQkTFDMfy0K7sKHMKcNLulzsxhZYiCxSjm/8D0IvHcP0lezu1ctMHIUeIIOyaCZ8ErfGqLt0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W32Cour_1711112604;
Received: from 192.168.26.88(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W32Cour_1711112604)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 21:04:16 +0800
Message-ID: <8e363bec-c0e6-437c-9872-e50251ed41ce@linux.alibaba.com>
Date: Fri, 22 Mar 2024 21:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: rename per CPU buffer to global buffer pool and
 make it configurable
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240322114802.1096545-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240322114802.1096545-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

On 2024/3/22 19:48, Chunhai Guo wrote:
> It will cost more time if compressed buffers are allocated on demand for
> low-latency algorithms (like lz4) so EROFS uses per-CPU buffers to keep
> compressed data if in-place decompression is unfulfilled.  While it is kind
> of wasteful of memory for a device with hundreds of CPUs, and only a small
> number of CPUs concurrently decompress most of the time.
> 
> This patch renames it as 'global buffer pool' and makes it configurable.
> This allows two or more CPUs to share a common buffer to reduce memory
> occupation.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> Suggested-by: Gao Xiang <xiang@kernel.org>
> ---

...

> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> index e146d09151af..7b552bb8c36e 100644
> --- a/fs/erofs/utils.c
> +++ b/fs/erofs/utils.c
> @@ -284,4 +284,152 @@ void erofs_exit_shrinker(void)
>   {
>   	shrinker_free(erofs_shrinker_info);
>   }
> +
> +struct z_erofs_gbuf {
> +	spinlock_t lock;
> +	void *ptr;
> +	struct page **pages;
> +	unsigned int nrpages;
> +};
> +
> +struct z_erofs_gbuf *z_erofs_gbufpool;
> +unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages;

I'd rather to:

static struct z_erofs_gbuf *z_erofs_gbufpool;
static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages;

You could send out a quick v3 or I could manually modify this
later.

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
