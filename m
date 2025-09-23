Return-Path: <linux-erofs+bounces-1064-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C7B93FBE
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:21:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW3cl4HStz3cYP;
	Tue, 23 Sep 2025 12:21:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758594071;
	cv=none; b=I/PwtNWd8IVmzLlua7J6XCUkJ59P3g28hbkKv6Fq0fqaQiE3CgTBvIFiVkOsd0TrNBmM/DDM7ozcv+4U2e5o9oECUB8qHsnUQabRT4JjagDUZ47uBWueTVgwwTysfrT5iX7UaGMyU3uAPwSSUQD97WZ52qSFDFUqSWEJgZRVQ3JpJGjnny5bokOS5dMlbcg26dfaKqX6mBG10mBiZvRdRM7bPGKLp5ytDFYO1NiAVx4RGQps/fh0mBKqKUr9VcybQcrdO91Zfv0UyAytoVMB8rtrGOOh3JH1ZpxiNsNnvPF7s3HAkujUDG6YaBBi5+bs+PsJslhmgrx4R5x/bnxGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758594071; c=relaxed/relaxed;
	bh=wpseOVdNRukzXLP4zkQiHQBoy9AAz0IJrT30IJtuzIA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D34kmlJ+L76kJ/bcs6VcN1JP+mInAl8aK1c8skXVIhl2+hzkEgV8CxaPvbntfcoLkNA03hPk2Gnbg+iJZqG7REHD1cRqMLZ+eUmdYrI1a5juqa4EQbUAQiYfr4k90i0cC0YDa5DW6xCZ+TzWRQlzGWehR1Fpy4+UQ1DwjcUb33VhHZ/3yiElzwIACVc5MY38VQJ/fcRr34ZTAXeM50KKqJeLYL4ockQNTPpruaBXPamjoJogFmLbVwmOL19PtmwYa8QJL+A7a7J5RlSCPWm39ufb5FPb91UNj0gm/VMtCPOYGZEzYpEr7lNUG3V164XPFdKYAI3mwW/wozJH2lX1yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tPLe37hy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tPLe37hy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW3ck5PqNz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:21:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A00C42BA0;
	Tue, 23 Sep 2025 02:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249D5C4CEF0;
	Tue, 23 Sep 2025 02:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758594068;
	bh=0hXC7tPYAh+1iRQxPqrJA311n1IPVWOkt0Jji5o5zgY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tPLe37hyszN/6vsShhItZIqV9Rha/mmdWznfuahzt0G7DnP90pFxgk7t+Nys4I9uD
	 EzIAGy+cu+mbWAlhT0+BGf1hkIgQbIpGtePC8YWgcZxxnlK4MfzN14bqyAOUpiQmAF
	 HvhJSMPD6FSc5W5FbbBtjHTdaIFOwC1cF8Ecf5Gv5dRYIPNFxs0aysmPYnt78F7lwo
	 9d74wARbt2bQCXKOB46dqccJQstQkxQ9qo0tPWzCxCe6dhhCjLfRYeOrwI3uZr0oMT
	 szBn8c6NNSJH1XkRRs2Bz1GlWunFMROhFesHFEzX6nKjRWO2wxNbLoyG0yvAe+bBHr
	 1ikGQPZSG0bpA==
Message-ID: <338fd84f-80fd-4ec7-b87e-64e76015b8f4@kernel.org>
Date: Tue, 23 Sep 2025 10:21:05 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
Subject: Re: [PATCH] erofs: avoid reading more for fragment maps
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
 <20250916084851.1759111-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250916084851.1759111-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 9/16/25 16:48, Gao Xiang wrote:
> Since all real encoded extents (directly handled by the decompression
> subsystem) have a sane, limited maximum decoded length
> (Z_EROFS_PCLUSTER_MAX_DSIZE), and the read‑more policy is only applied
> if needed.
> 
> However, it makes no sense to read more for non‑encoded maps, such as
> fragment extents, since such extents can be huge (up to i_size) and
> there is no benefit to reading more at this layer.
> 
> For normal images, it does not really matter, but for crafted images
> generated by syzbot, excessively large fragment extents can cause
> read‑more to run for an overly long time.
> 
> Reported-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a3.GAE@google.com
> Fixes: b44686c8391b ("erofs: fix large fragment handling")
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

