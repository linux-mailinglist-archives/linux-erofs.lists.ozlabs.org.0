Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28D95128C
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 04:36:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P9ico86g;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkC740zpTz2yP8
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 12:36:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P9ico86g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkC6z5qzwz2xyG
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 12:36:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723602965; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FXx4I/HBcpdab9sCv4gJZmZjZUWpZmetYlEx9/A+8RQ=;
	b=P9ico86gXKZGjImIGXW7uWmU1Y82UOwKCJO6ufMg/wnj8b2aZK5fyhYKQkV9biC+C2G3+alOE1axl3rQBFkkImWfBrMRMHiVM7NZ1lB83HY3wPUQ6zi+vGRWb1NhLeuzvOC2QkEGsbrCAyhnJh8hj7D9XUzbJQ3CFNGTVCOdoUc=
Received: from 30.221.130.115(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCqhtGG_1723602961)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 10:36:02 +0800
Message-ID: <d6f177fe-0263-489b-968f-189a923e089b@linux.alibaba.com>
Date: Wed, 14 Aug 2024 10:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: allocate extra bvec pages from reserved buffer
 pool first by default
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240813102723.640311-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240813102723.640311-1-guochunhai@vivo.com>
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

On 2024/8/13 18:27, Chunhai Guo wrote:
> As the extra bvec pages are allocated and freed in a short time, it can

It'd be better to just simplify the subject
erofs: allocate bvpages from reserved buffer pool first

> reduce the page allocation time by first allocating pages from the
> reserved buffer pool [1].
> 
> [1] The reserved buffer pool and its benefits are detailed in

Although I can imagine it could have some benefits, but if it's
possible, could you give some real numbers for this commit (assume
that it's not hard) so that we could record them in the commit
message for other reference?

> commit 0f6273ab4637 ("erofs: add a reserved buffer pool for lz4
> decompression").
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

The patch itself looks good to me tho.

Thanks,
Gao Xiang

> ---
>   fs/erofs/zdata.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b979529be5ed..428ab617e0e4 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -232,7 +232,8 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
>   		struct page *nextpage = *candidate_bvpage;
>   
>   		if (!nextpage) {
> -			nextpage = erofs_allocpage(pagepool, GFP_KERNEL);
> +			nextpage = __erofs_allocpage(pagepool, GFP_KERNEL,
> +					true);
>   			if (!nextpage)
>   				return -ENOMEM;
>   			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
