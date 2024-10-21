Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00F9A5DB6
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 09:54:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XX6yz288vz2yVZ
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 18:54:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729497273;
	cv=none; b=HaY3eVNT0ZKOPJl1XuIx4F3PlfhNHz2DZuElIi8g0tyjQ51AUa3kXuz39jXRsIxKBOsHfs8K2QrC8Cti9HYmhmomn1EntuTMG+hGclMG+X/pbSRzc5AlIMgitoCyAMfccMWXH8BwPeq+uVWMVfow3nRcGA7pq8aHG/+UvxmbTLvKHWhkI5Z3+/blmn/oGnN0T7ks1XZ8HYeKQwra7tiY0bR9CchNfiWGoQG15rZq+lS6OiY0ehAIjEHvEp/1iqu45LiZhZzPGKZbjLsagdthT4XB4YrGnpAbmw6+NQA9rcv8av+13EPzx+ofZYbS/w/hDfawJfrGP7Vsj3vr9SPztg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729497273; c=relaxed/relaxed;
	bh=JJokq+lp+EynznNIydiE+AjMIqmPGCXE2TWW4BFGqdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2GZAgUZksYq7oN2S082MI+s2BTTL9mdKkLUmZUzLpklJ4FNeu0oPxQ/gxdIEuoxneRCyuSGwA53vvsemrEsNbgyTTOgYu1kKaahfeC4q52HAitqUakwEvYHRzVfT38R9SlsXSgF5fW0nb7UmVJRCDY8uGck70MvbRfhB/Dw6aop4gu06Bvm3uONYiwxnyxAQj0CMBwWwsylovEgKG3YCCeH4HbDT90R6QOJe2tOLE6FISxR+l1VO69s0EzYs4mgMRqbqUCTY3xT8/JhnS5N1DbKaFS2SksnYnTOmvd1t56EgObSHfKJo1GLJBil9Emj1xNzQ9IGz2+G7dw4eL4Y2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fl2wPJiz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fl2wPJiz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XX6yn5t8Hz2xYg
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2024 18:54:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729497256; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JJokq+lp+EynznNIydiE+AjMIqmPGCXE2TWW4BFGqdU=;
	b=fl2wPJizK0IV+vuP0Oq+Ck5oBQmcWwNBEsZqM3CBboaJU91iBmHP6WRJPxUncP54oMe8tiadQmv30ynEkAOZdjfTo4Hgzd2DmNOy4FbgK1TAwFjWwp6ObcgvLkHpBby65bTfwPIG2QqQblV2OGunovb3C4PQs+VzoCS6xivqmN8=
Received: from 30.221.130.170(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHYCPSr_1729497253 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 15:54:14 +0800
Message-ID: <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
Date: Mon, 21 Oct 2024 15:54:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
To: Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

On 2024/10/10 17:48, Christian Brauner wrote:
> On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
>> As Allison reported [1], currently get_tree_bdev() will store
>> "Can't lookup blockdev" error message.  Although it makes sense for
>> pure bdev-based fses, this message may mislead users who try to use
>> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
>> then.
>>
>> Add get_tree_bdev_flags() to specify extensible flags [2] and
>> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
>> since it's misleading to EROFS file-backed mounts now.
>>
>> [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/2] fs/super.c: introduce get_tree_bdev_flags()
>        https://git.kernel.org/vfs/vfs/c/f54acb32dff2
> [2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
>        https://git.kernel.org/vfs/vfs/c/83e6e973d9c9

Anyway, I'm not sure what's your thoughts about this, so I try to
write an email again.

As Allison suggested in the email [1], "..so probably it should get
fixed before the final release.".  Although I'm pretty fine to leave
it in "vfs.misc" for the next merge window (6.13) instead, it could
cause an unnecessary backport to the stable kernel.

Or if there is some other potential concern about these two patches?
Also I hope my previous reply about a redundant blank line removal
in the first patch might be useful too [2].

[1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
[2] https://lore.kernel.org/r/8ec1896f-93da-4eca-ab69-8ae9d1645181@linux.alibaba.com

Thanks,
Gao Xiang
