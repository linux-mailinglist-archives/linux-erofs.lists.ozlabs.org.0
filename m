Return-Path: <linux-erofs+bounces-1988-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA241D3A10C
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 09:12:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvjqv2LbNz30Lv;
	Mon, 19 Jan 2026 19:12:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768810363;
	cv=none; b=Sa77H6gqF/3cAlFaUsakRzaEgoNu3JWRs3sNKPqjj+tGxT85PxHyqWjS6lxcwmEyhv0uA0mtpVLKVPSLGraKfGfLaUmbIM9sbro8BTpUuY6fFE2g06OnrBPo6qbtNkLis4/usxCW6zRSYkPJQqiYISzW2JmK1Qv5VPBJe7qcWU3JqystiWCwCR2gQcTUsbd+CZhm92ay9u6W56ZwsnB0ShT+MxTRiWpltQ+FGeUfVxoiL8dzN9adAT8DQsTQBQs08LFgFTxif71MA600pew3Sls1owGISP0joDjOriaj2gqPYrod4JOt39AozD8bwv/6IqnMdd01IWQWsRl3B/bKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768810363; c=relaxed/relaxed;
	bh=eXOFYQUuzhFj9OHqhogwdIk9d4r3LbBPp2+CjnT0hY4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V3W2Bot8kEU6A2V81RhZU2/xVhPYkn0Qd2bsq+aOdcllt8AH+lWGVd3bej3PpZRNbBB+fcufEXEzAqGNrw1qSOczObg/YoIws6+RI36Ei9Jw6qwWJoMcOdaCJfBxA6h97KD8O74rkv4EKiSyzJe4ut3BfWqW9qiE6Si/yx9bXyW0DKy8IXcCkJN7vYLNpnInNu+lHeyWirw0g5vP+xEh3CKTE6cXzGn2YHmTBn59gdGhRp+W/Ex0SKWu94UKsih5glKpdszhJ7Wikaiu2gNrP90vyNeYk8/MMS4VGsJDnlRZdsnViA+KWTofEgxZJAXX/Dt3cWK6AmRKfdkJM+kmHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IScmusUu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IScmusUu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvjqp4Y0Wz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 19:12:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768810352; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=eXOFYQUuzhFj9OHqhogwdIk9d4r3LbBPp2+CjnT0hY4=;
	b=IScmusUuMEYSf0tiilsmztX+N5kt70ydXL0cvUGI4Vmeg36WWg20T7hmmJwHfpyervPTV7M2yHoTal4gmSCoXrQ9u1FP8ZHLDyR2VAwJR9aSVxXaYKfYvu29RP2JosYZsXSmMoBmiVTrfP2D5cYHlsoe6h4uuwvGTWEWbVnvNGM=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxK3bUB_1768810350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 16:12:30 +0800
Message-ID: <be558d13-6b41-48b7-9f5c-5da0f1ca1fce@linux.alibaba.com>
Date: Mon, 19 Jan 2026 16:12:28 +0800
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
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
In-Reply-To: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/19 15:53, Gao Xiang wrote:
> 
> 
> On 2026/1/19 15:29, Christoph Hellwig wrote:
>> On Sat, Jan 17, 2026 at 12:21:16AM +0800, Gao Xiang wrote:
>>> Hi Christoph,
>>>
>>> On 2026/1/16 23:46, Christoph Hellwig wrote:
>>>> I don't really understand the fingerprint idea.  Files with the
>>>> same content will point to the same physical disk blocks, so that
>>>> should be a much better indicator than a finger print?  Also how does
>>>
>>> Page cache sharing should apply to different EROFS
>>> filesystem images on the same machine too, so the
>>> physical disk block number idea cannot be applied
>>> to this.
>>
>> Oh.  That's kinda unexpected and adds another twist to the whole scheme.
>> So in that case the on-disk data actually is duplicated in each image
>> and then de-duplicated in memory only?  Ewwww...
> 
> On-disk deduplication is decoupled from this feature:

Of course, first of all:

  - Data within a single EROFS image is deduplicated of
    course (for example, erofs supports extent-based
    chunks);

> 
> - EROFS can share the same blocks in blobs (multiple
> devices) among different images, so that on-disk data

   This way is like docker layers, common data/layers
can be kept in seperate blobs;

> can be shared by refering the same blobs;

Both deduplication ways above will be applied to the
golden images which will be transfered on the wire.

> 
> - On-disk data won't be deduplicated in image if reflink
> is enabled for backing fses, userspace mounters can
> trigger background GCs to deduplicate the identical
> blocks.

And this way is applied at runtime if underlayfs
supports reflink.

> 
> I just tried to say EROFS doesn't limit what's
> the real meaning of `fingerprint` (they can be serialized
> integer numbers for example defined by a specific image
> publisher, or a specific secure hash.  Currently,
> "mkfs.erofs" will generate sha256 for each files), but
> left them to the image builders:
> 
> 
> 1) if `fingerprint` is distributed as on-disk part of
> signed images, as I said, it could be shared within a
> trusted domain_id (usually the same image builder) --
> that is the top priority thing using dmverity;
> 
> Or
> 
> 2) If `fingerprint` is not distributed in the image
> or images are untrusted (e.g. unknown signatures),
> image fetchers can scan each inode in the golden
> images to generate an extra minimal EROFS
> metadata-only image with local calculated
> `fingerprint` too, which is much similar to the
> current ostree way (parse remote files and calculate
> digests).
> 
> Thanks,
> Gao Xiang


