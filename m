Return-Path: <linux-erofs+bounces-1407-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70EC67FC4
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Nov 2025 08:35:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9by52dgKz308g;
	Tue, 18 Nov 2025 18:35:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763451357;
	cv=none; b=YiI2oIrbTwBRUc3vPX3Os6xt1Yh2x2cx8nf4POQ0cqp7ObjKVX/9wdAgcZzOrK9FCA4blDl0qKVhP14rzHI4omrYLnsiPiFuVpwUDgaeOAR1Bm7tQgnlZXfBaoFCDzBmsULfv1Sjip7wiOux70zqb+ZPewVLvSUCjWwo0CJM+l9boObXYrZMZMUfXy4D7KFYALlwvGdHRC/RPeGs+9xy01fLmW+zx8xPM1KjNESTN7FCKORtqrv0JY8qCysttTiJjQ/x0jqI5qYExWOVgssYvfpHUL5g2uwaUm7xcobx+iH97Nf2lOHuAmHiwjJ9rSB0Zvaovwae9uc3zslV2MpyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763451357; c=relaxed/relaxed;
	bh=UnsKcX6SJf5cwGhxDgVLSUzRD0ZhhZ/01A1WzVuNbgQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S8CL73Mb31rpeCUZJtTZ3R8ZIQWyLtYgTrVUP+Ux+QUo7u+aSePMEVE+GXd6D7hjaJ/Qp/tYyii9XSCIYkb2zTh0iauI5LiDXlAyWqpxFKhnEiDTKfUjM1bjdneCVXiVXUeGhiINU2j5PTfgogM1UlxDEFn5PQmHe5TXR30EIrDTFoqyDzrgdjwNA5U+vjD2NczpZWVM92Jkwo65AaiJuczqMl6CEjU6D33ZiMhwVJ6pbrYOi0oppvbXlQL5czTJ6CTdoPaZn6t/ek/G31/f5/YoRZI5ZvVQyNKpTDG19QZhPD5DtIga84iQwk0ieJuvc9IdvSmhqOHe+uOF2LjpIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gjPkxwl1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gjPkxwl1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9by30HlRz2yv6
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 18:35:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763451348; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=UnsKcX6SJf5cwGhxDgVLSUzRD0ZhhZ/01A1WzVuNbgQ=;
	b=gjPkxwl1ii9deSc9ouVuu1/ogAEgl4S0ObFB2719vpPuFOnk/GIKc7crrSXB7GIflMBJ0u9Ef5W/419258ea36uORAcDfiCu4r2uPgCFlN/RaG88Pq4Huql1gg5wAkwxP8a353l3wqWsWOzsVp2KewQe9lbjS1upw3qdgzLbcKw=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wsiew2h_1763451346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Nov 2025 15:35:46 +0800
Message-ID: <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
Date: Tue, 18 Nov 2025 15:35:45 +0800
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
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: brauner@kernel.org, djwong@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
 <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
In-Reply-To: <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

(... try to add Christoph..)

On 2025/11/18 01:08, Gao Xiang wrote:
> Hi Darrick, Christian,
> 
> On 2025/11/17 21:25, Hongbo Li wrote:
>> It's useful to get filesystem-specific information using the
>> existing private field in the @iomap_iter passed to iomap_{begin,end}
>> for advanced usage for iomap buffered reads, which is much like the
>> current iomap DIO.
>>
>> For example, EROFS needs it to:
>>
>>   - implement an efficient page cache sharing feature, since iomap
>>     needs to apply to anon inode page cache but we'd like to get the
>>     backing inode/fs instead, so filesystem-specific private data is
>>     needed to keep such information;
>>
>>   - pass in both struct page * and void * for inline data to avoid
>>     kmap_to_page() usage (which is bogus).
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Could you help review this iomap change, since erofs uses iomap
> and erofs page cache sharing needs this change, as I told
> Joanne months ago.
> 
> Even without the page cache sharing feature, introducing
> iomap_iter_ctx for .iomap_{begin,end}, like the current DIO
> does, is still useful for erofs, as patch 2 mentioned.

I know it could be somewhat too late to introduce the entire
feature for 6.19, but could we consider the first two patches
(patch 1 and 2) if possible? because:

  - patch 1 just adds a way to specify iter->private for buffered
    read since there was no way to pass on-stack fs-specific
    contexts from .iomap_begin() to .iomap_end() for iomap
    buffered read.

    Actually patch 1 doesn't introduce any new logic or behavior
    to iomap itself, just add a way to specify iter->private, I
    think it does no harm to the iomap stability.

  - patch 2 tries to avoid kmap_to_page() usage since previously
    there is no way to pass both `void *` and `struct page *`
    from .iomap_begin() to .iomap_end() because inline data
    handling needs both.

    Actually people would like to get rid of kmap_to_page(), for
    example:
    https://lore.kernel.org/r/Y5u+oOLkJs6jehik@iweiny-desk3

    So I wonder if patch 1 and 2 can be considered as an
    individual improvement for 6.19.

  - Currently the page cache sharing series is coupled with iomap,
    but the main change is still in erofs itself.  If the first
    two patches can be applied in advance, that would make the
    remaining part through erofs tree without treewide conflict
    like this.

Just my two cents.

Thanks,
Gao Xiang

