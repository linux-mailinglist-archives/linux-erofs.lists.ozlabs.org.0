Return-Path: <linux-erofs+bounces-1986-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C11D3A0AA
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 08:53:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvjPr0bxzz2xSZ;
	Mon, 19 Jan 2026 18:53:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768809216;
	cv=none; b=Yjbrz1PR+Plyx9ADuH6n2DmaU5+tgnG76KTXrUuhIER+7oJgBZZ3m7FSdvi3eNmWezYvA9tywcOV2jfaVGOrmq0DblLAhO4g6Ge1utnazDy5unHUlF8yYq/PTNnwYaMnTPJS07kwbVmi54lSumKPb2No54cW66Fv5wqFi96fHH/XCHqM5fz9lrXa55O15Fuyg3DjXwxGv5yTRNkxWqa18a4E55ZA9PYchHUjYdyNI5a9nss5KmMCh1G3TV7671BYbOEj035Z0QJ4fiEWbU+YTv5DdbeIzXp24sNaPt8jMiCwDis5SU5iTmYuInedVC4JZQKqIwmsELv+wGXe4z613g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768809216; c=relaxed/relaxed;
	bh=IbSnMD/TThQCoomf8m9kea1ykOemfT3BZ0iVD9EEtDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yc7XustIQPp0HevWElCPcRNZpY64CjaKV+wP+hambOmDSvB3DbqeFgIzFjo1rxW5wvsZ0002m/xql00I+Nr3qnjzYLKiQVios8q9BPUxWDvDncW8wWEGvFlu746nWaq2NTkUHnAshRufEDml5c15QghtRNDtGxdK54h9Bo3MbDjL7FZObCzzetnLRKpU0foeZZ+BocChZDmiK+ujHzMdb23f1f8PY/QZsMMpLBHTLVwTX0fYPnqMtpQO3I+G6BsVVWABWq7SQXdeaFmpaFZ1DOkZUfvR7T1Rjtne0YECxMLiuUiVoLS5unQ7tJODjpM54EvonJWvIg+H8aOQaFNarw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bGk+rTua; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bGk+rTua;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvjPm6wxfz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 18:53:31 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768809203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IbSnMD/TThQCoomf8m9kea1ykOemfT3BZ0iVD9EEtDE=;
	b=bGk+rTua3tKdtPpewN0enCinH6L3vHehvjoaVsVoIP9V9X0BU6sC4QBbr3GcE0YKAKN4+HTNvVfKKnzzT5ahpUow6bcXLbrgJS/ZNMHj9bY4AXao30Pahs3P9BoQJok0WcghPo0hk/VQeMCXmEx5SeOP1HaNnw76efVcGHbMT7M=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxJtR-9_1768809202 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 15:53:22 +0800
Message-ID: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
Date: Mon, 19 Jan 2026 15:53:21 +0800
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
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260119072932.GB2562@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/19 15:29, Christoph Hellwig wrote:
> On Sat, Jan 17, 2026 at 12:21:16AM +0800, Gao Xiang wrote:
>> Hi Christoph,
>>
>> On 2026/1/16 23:46, Christoph Hellwig wrote:
>>> I don't really understand the fingerprint idea.  Files with the
>>> same content will point to the same physical disk blocks, so that
>>> should be a much better indicator than a finger print?  Also how does
>>
>> Page cache sharing should apply to different EROFS
>> filesystem images on the same machine too, so the
>> physical disk block number idea cannot be applied
>> to this.
> 
> Oh.  That's kinda unexpected and adds another twist to the whole scheme.
> So in that case the on-disk data actually is duplicated in each image
> and then de-duplicated in memory only?  Ewwww...

On-disk deduplication is decoupled from this feature:

- EROFS can share the same blocks in blobs (multiple
devices) among different images, so that on-disk data
can be shared by refering the same blobs;

- On-disk data won't be deduplicated in image if reflink
is enabled for backing fses, userspace mounters can
trigger background GCs to deduplicate the identical
blocks.

I just tried to say EROFS doesn't limit what's
the real meaning of `fingerprint` (they can be serialized
integer numbers for example defined by a specific image
publisher, or a specific secure hash.  Currently,
"mkfs.erofs" will generate sha256 for each files), but
left them to the image builders:


1) if `fingerprint` is distributed as on-disk part of
signed images, as I said, it could be shared within a
trusted domain_id (usually the same image builder) --
that is the top priority thing using dmverity;

Or

2) If `fingerprint` is not distributed in the image
or images are untrusted (e.g. unknown signatures),
image fetchers can scan each inode in the golden
images to generate an extra minimal EROFS
metadata-only image with local calculated
`fingerprint` too, which is much similar to the
current ostree way (parse remote files and calculate
digests).

Thanks,
Gao Xiang

