Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D496CEDD
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 08:05:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzpkY2gFjz2ysf
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 16:05:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725516339;
	cv=none; b=kfqnlsTivpdhgbWUPCYiP9yze3p/8cfwvw4pEYp0rQqTTuGsUV5h57aSbqkMxs358JwMBcuYB+epcxOZRHQlCH4++94X0yw0XiEFVtqsJQtNq2f4pONGAHq67bCOFjLDKIIZdwkwtn6Ia7T3LIpHPOGxcJ6i7/oTHjwSHFoqOIboGj4Y4E7vC1bWjt+Lt9GjBK65xmEXp0xENEhFvAVRjRuzK4YguqE8/18ZpORNk2xk9nQwd+zGBi4+YhzspDVyCZCtKJ8cSzT/j/zWzUCvTtwCAXhTuX+rVsFGMB5QPWncTumGhSMPpV/1sJO/BZg9jmacyxp0wMH11mHt1pqjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725516339; c=relaxed/relaxed;
	bh=eRLJzRL2rOkS1vHShK1v2byBfGd6swOHfIMsG4cLQks=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=GQYV9/9sEiDkdc/NdnAdy/wvn0KmvsHj+nAMj8l9pO5cHJziXS13+3i34IhDBpiDWTr7EBOVmFjAslGNAgiE4hasRjmga9l5vxNSTVyevelBdi+cEs9PCs+vKlit2NpbwWDzc78WB5shqHm9ILpxNQW/A4EMZidDCMeo3fYs/X6evbZNt2FqxHQ7L4ezQ8EDcgMCTPIsUxvXzZqbwSK7HvmqNuM+x8qd/MZX44GMP8Mwb3P9pVO+HfeXO09VwXLkjE3IwwgJ8SKgACDzN+U4+KwN92gMrD9D+61t1U/kcnVHQbEBYMo4WeXY6umOFjbQFIqjwAGDVwOWgi599FspLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gvwzpKvW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gvwzpKvW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzpkV2Xfkz2xr2
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 16:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725516330; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eRLJzRL2rOkS1vHShK1v2byBfGd6swOHfIMsG4cLQks=;
	b=gvwzpKvWeViziJx4xGlPXl4Z2BSJ6iyaJKDEDKQCDGgj90+FG1BkRdYvwe3dDtZ38flyS4mlpOEbm0SThQmwdSPd8bfHrUsxC7jGTDVg5zIjTjHFv/nPBGzckfNbn+qJS+qqQFclvz1hfVdKvP1z/sGm1+jhC3ixZonnCFyyVtg=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEKEoEF_1725516329)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 14:05:29 +0800
Message-ID: <4bf4fca0-0b97-42bc-9911-25290aa8113f@linux.alibaba.com>
Date: Thu, 5 Sep 2024 14:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix error handling in z_erofs_init_decompressor
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240905060027.2388893-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240905060027.2388893-1-dhavale@google.com>
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
Cc: kernel-team@android.com, liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/5 14:00, Sandeep Dhavale wrote:
> If we get a failure at the first decompressor init (i = 0),
> the clean up while loop could enter infinite loop due to wrong while
> check. Check the value of i now to see if we need any clean up at all.
> 
> Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
> Reported-by: liujinbao1 <liujinbao1@xiaomi.com>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
