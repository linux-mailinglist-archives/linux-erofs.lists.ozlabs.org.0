Return-Path: <linux-erofs+bounces-94-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 784ADA68C46
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 13:01:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHnP10RYYz2yyJ;
	Wed, 19 Mar 2025 23:01:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742385684;
	cv=none; b=XSj6y6p6NGP3v1IgBRI4Gpi8CkdjLrtEMfsmLlVy0ULZxJ5q+5SLRohGp8Pa5RqrdmpWUu0VFzlvKWD36k4vuwuyzzIQrtDoHQUq2XfIxTj+D71xn84R5yxuHGCN7FXFQEbj9zRZABsROj562GU5WdaI6wrjDWiJU46MY5C6unSx171BQUuM6wEbtSRUby4KCkJGHhsRK4Js1be2zuvzRSYemPTwyLuQRazSAz6fJ5eFXYgnWCHy3mRR+Oujws0GtXHuCDwGEv7G86ZvzgGL6HsKoG0iT6Y9/YxOgRLffMwbWMSbUMFXQ0yX8xvZi+T64IOBqVh9Y1gGv6YXcCsTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742385684; c=relaxed/relaxed;
	bh=3bTztN10K28UyNMqDDdeWXLtebgPE/wrCTgmoZhdlWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBPo3n+aZj3IUZZGqIB+P6u3yX/tEimX25caxfsDpmMB1bPjepuKARqJ4dMAtPZaQr/kmWSGB90KMyHCpokDK6EpKvI1VJPMOwDwBzjtAx3sQhWETg4yLLL3iZUUJyXH6ahuLv7dTJx/xqkKx4VFdBoYlQervnQoTkWoEX4vrEX7VFu5ZUai7aFu2ZpNjYEKDxd5e6KrnDInpUREfzhsYAh6tjYtCJilZloMihDWIEOUoGfCuIi07KYFk4rDuxyXQRF3OPAA64mkT3I63tcNIjqW672mSQkJaHL18doaK6++uBuQnD8hrooq2KRvfpeJKWieieYVw5iaCFq3yleAWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e4QegAot; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e4QegAot;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHnNz2D7yz2xCd
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 23:01:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742385678; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3bTztN10K28UyNMqDDdeWXLtebgPE/wrCTgmoZhdlWg=;
	b=e4QegAoturraHcCYhHqUP0VKyLzwUHg9JQipCX7lumLk83lh7TBRoiVsXhoEFsUok7NFuvjlqY0fTMJScZkDUEXaxAWDC9bEe8geBG8EVloar1CKLsHiRXV5D/pzManvF/FdQIWGln9RS5Af1at7Icke9HjwRsLE7M9Lwfwrhpg=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS3NGrf_1742385675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 20:01:16 +0800
Message-ID: <f595e8f6-04d1-4b0c-9d6d-9cdd31580287@linux.alibaba.com>
Date: Wed, 19 Mar 2025 20:01:15 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 Bo Liu <liubo03@inspur.com>, Christoph Hellwig <hch@lst.de>,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
 <Z9qqSHlItlWJCPJz@bfoster>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Z9qqSHlItlWJCPJz@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Brian,

On 2025/3/19 19:28, Brian Foster wrote:
> On Wed, Mar 19, 2025 at 04:51:25PM +0800, Gao Xiang wrote:
>> Previously, iomap_readpage_iter() returning 0 would break out of the
>> loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
>> relies on.
>>
>> However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
>> buffered read") changes this behavior without calling
>> iomap_iter_advance(), which causes EROFS to get stuck in
>> iomap_readpage_iter().
>>
>> It seems iomap_iter_advance() cannot be called in
>> iomap_read_inline_data() because of the iomap_write_begin() path, so
>> handle this in iomap_readpage_iter() instead.
>>
>> Reported-and-tested-by: Bo Liu <liubo03@inspur.com>
>> Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
>> Cc: Brian Foster <bfoster@redhat.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: "Darrick J. Wong" <djwong@kernel.org>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
> 
> Ugh. I'd hoped ext4 testing would have uncovered such an issue, but now
> that I think of it, IIRC ext4 isn't fully on iomap yet so wouldn't have
> provided this coverage. So apologies for the testing oversight on my
> part and thanks for the fix.
> 
> For future reference, do you guys have any documentation or whatever to
> run quick/smoke fstests against EROFS? (I assume this could be
> reproduced via fstests..?).

I don't think any existing testcase of fstests is
useful for readonly filesystems like EROFS since
EROFS only has read interface so all test cases
including regression tests will be integrated
into erofs-utils directly.

EROFS can be easily tested with its own testcases
in erofs-utils:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
cd erofs-utils
git checkout origin/experimental-tests	  # for now, I will integrate to main later.
./autogen.sh
./configure
make check

Without this patch, test cases will just hang.

> 

...

> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Thanks.

Thanks,
Gao Xiang

> 
>>   
>>   	/* zero post-eof blocks as the page may be mapped */
>>   	ifs = ifs_alloc(iter->inode, folio, iter->flags);
>> -- 
>> 2.43.5
>>


