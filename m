Return-Path: <linux-erofs+bounces-1860-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3439D1E095
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 11:28:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drj5925yTz2xFn;
	Wed, 14 Jan 2026 21:28:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768386525;
	cv=none; b=FLS3ScUbxEJtmzvm5KXFBcD4iGNGTkZjdy64A8lmG+F/sknQM3DzX8zyzpS15smBwAawG3Aor1AaHHDuHrDkXiHzo8h4SAqzKuXsntxvgMfpdSJsYvf+S6gTDCJ4n7cetndQdd50pUUv2mvFZ2/mWqgCgg6KV0yFGvXRFMxWKIIp5G+CyEl1OdyVzumJyC/1OcR14ZeVsfRkQcopomcW51YGrSjDtIuXNDjBg1GJbTZbIyrCIJLRQa3I1PBiqrajbK8jJ5XF5Od9GiROJDrl7LeMNxFJPf9c2MuAbCAr+ohPUwFKcjO1Z/VS9v/r+YayMMWSFKFcikdg9lxGtBg//A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768386525; c=relaxed/relaxed;
	bh=X3FIs7A5RvlrrKt9IluVyHYBz5NPE45rqc71MrXC4A0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DCls93WSopbHZ3nDkNu1BeqgNhOMIUM9LTh39T5hrdnqq+/OvGp5fb9XCeGhXAKSs0rb5pH8zcT56JjTKr6qOsd0a3gWcfACDSD4SEdqXVIhtW5iFst+4MFWzFW/tKyLssvJlNigGlqcz0/PufO0Y7kOjvmbCP27ekUe7EH1SqcLToZ8KR33ytVFtj6Yct1CXFAg+DGpONeamdFTQ5rryyd51ld8KCIkE2yo2EM+JXfzpudNKsTShvgAaA21bqSlKNotfyO0NfHhs0ePhAyiqllQ8PD6xOUYCyMrJNgo4Q1regQH12pY1x+BxAxsRPFpyH2QBXbTylkK6LXSSN01Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D7v1wxvu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D7v1wxvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drj5655P8z2x9M
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 21:28:40 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768386516; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=X3FIs7A5RvlrrKt9IluVyHYBz5NPE45rqc71MrXC4A0=;
	b=D7v1wxvuczsnUpX2x9Sl6mwWlm5tFEQtjvZmUO3HJyA9dBJAo3BLR7iURSNDvsuWdWdJ9OOi2NeFyuTAZF27H2vP7+O8Dcvq0v2OJ8kgRnMBSgUr+bFANJ57bkj5p0KEyeu067O9L7ATJeB8d6Dn62Ji3p+uwLqDgEOlRoB8SYs=
Received: from 30.221.131.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx26mdT_1768386514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 18:28:35 +0800
Message-ID: <0f33bd17-7a03-4c06-a492-e514935faed6@linux.alibaba.com>
Date: Wed, 14 Jan 2026 18:28:34 +0800
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
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>
Cc: chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260112-begreifbar-hasten-da396ac2759b@brauner>
 <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
In-Reply-To: <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christian,

On 2026/1/12 22:40, Gao Xiang wrote:
> Hi Christian,
> 
> On 2026/1/12 17:14, Christian Brauner wrote:
>> On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
>>> Enabling page cahe sharing in container scenarios has become increasingly
>>> crucial, as it can significantly reduce memory usage. In previous efforts,
>>> Hongzhen has done substantial work to push this feature into the EROFS
>>> mainline. Due to other commitments, he hasn't been able to continue his
>>> work recently, and I'm very pleased to build upon his work and continue
>>> to refine this implementation.
>>
>> I can't vouch for implementation details but I like the idea so +1 from me.
> 
> Thanks, I think it should be fine.
> Let me finalize the review this week.

I wonder if it's possible that you could merge v14
PATCH 1 and 2 now to the vfs-iomap branch (both
patches are reviewed or acked):
https://lore.kernel.org/linux-fsdevel/20260109102856.598531-2-lihongbo22@huawei.com
https://lore.kernel.org/linux-fsdevel/20260109102856.598531-3-lihongbo22@huawei.com

since these two patches are almost independent to the
main feature and can be merged independently as I said
in the previous cycle.

Merging those patches into a vfs branch also avoids
other iomap conflicts.

For the other patches (since PATCH 3), how about going
through erofs tree (I will merge your iomap branch),
since it seems at least it will cause several conflicts
with my other ongoing work, does it sound good to you?

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang


