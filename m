Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C64309A6898
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 14:34:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXFB33h3jz2ygy
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 23:34:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729514074;
	cv=none; b=GwIQqUu2kF4hfaLWObkNzjKOA5OcnknkA59Unknc0SMNc1vEi9yWp1vdLk79CPhcsYX31Ls+xwvh497LwKPoumfyA5KR0vO0BD5oZwXHvDBQhsvNyZBBuUQQdzCtUyU1Q/dQJhSCyPQXPnFUmSMfvxcnU3JmDc/tWU3rfKI2m38l8ETGmA+EoMM3/+9Tu3EL0naoZEkwqbDe6vpDDDg7QhITnk3JM4TsT/f4LEWEHBqJ1Cg74NKXe2pEI6YgUTMNfu+oaCd2Z264TjrYrNqG7GiltZTDH5yIf93Abuvc22YN1iPcivs9BqfKeY+YzPSuaoaxh2U4roUNOeeptDjJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729514074; c=relaxed/relaxed;
	bh=NHWtLqYnu4wS3OxvS4L5uLq3I4fKPJPFOowoi3G6bQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mol9VHcUc/O5DQya/NpFlBPrSQW4dkczR6R/uiH8FDD2kew7Zqe4wXkdjmWTaU6sB/sSZ4Jvnn6d4iJgHjA44wqbsMgSP7o+kwlXGU9zXK4PRU54Y8QkHnd7MZZrrIjdw1WTwa40wtOcLpDo8fZunT7yMC8gsFZljoKe80jRuy085xUWdD4KEqguIJRzCkqHv3E2SfJe7xkPaqOEwfYMJXP2/EIwATSx2G0q4cWtBPz/mrGD2scBNdrXMlq1fOOkN5EkYUtkfck6doxm12vaJT37Sde/fcJV2ED+MqDph2QBQfrfTEDEbOjah4XQwsTc/aC/0HnpNGNc+VerlrV0fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LsrYMP4j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LsrYMP4j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXF9w50DKz2xWT
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2024 23:34:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729514061; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NHWtLqYnu4wS3OxvS4L5uLq3I4fKPJPFOowoi3G6bQo=;
	b=LsrYMP4j/mKBxQZ4zGen4B6YrLqMciT4lmECMO2haIzRcybapwuYRAF+n2pY1RyfPCDEBDeD9zQwBPdsjgLcBp7Z9x8XS4iLbARJsVO9Jkz4W157oMwswfJ8PwHu8gAmF4Q8XyGLV1X6/q0/XVchHEhliXQOMgc/aHWWtJrEztQ=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHcY2W5_1729514058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 20:34:19 +0800
Message-ID: <f64a9dbb-caed-4764-b104-e418ba87ad29@linux.alibaba.com>
Date: Mon, 21 Oct 2024 20:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
To: Christian Brauner <brauner@kernel.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
 <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
 <20241021-geldverlust-rostig-adbb4182d669@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241021-geldverlust-rostig-adbb4182d669@brauner>
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



On 2024/10/21 20:27, Christian Brauner wrote:
> On Mon, Oct 21, 2024 at 03:54:12PM +0800, Gao Xiang wrote:
>> Hi Christian,
>>
>> On 2024/10/10 17:48, Christian Brauner wrote:
>>> On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
>>>> As Allison reported [1], currently get_tree_bdev() will store
>>>> "Can't lookup blockdev" error message.  Although it makes sense for
>>>> pure bdev-based fses, this message may mislead users who try to use
>>>> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
>>>> then.
>>>>
>>>> Add get_tree_bdev_flags() to specify extensible flags [2] and
>>>> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
>>>> since it's misleading to EROFS file-backed mounts now.
>>>>
>>>> [...]
>>>
>>> Applied to the vfs.misc branch of the vfs/vfs.git tree.
>>> Patches in the vfs.misc branch should appear in linux-next soon.
>>>
>>> Please report any outstanding bugs that were missed during review in a
>>> new review to the original patch series allowing us to drop it.
>>>
>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>> patch has now been applied. If possible patch trailers will be updated.
>>>
>>> Note that commit hashes shown below are subject to change due to rebase,
>>> trailer updates or similar. If in doubt, please check the listed branch.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>> branch: vfs.misc
>>>
>>> [1/2] fs/super.c: introduce get_tree_bdev_flags()
>>>         https://git.kernel.org/vfs/vfs/c/f54acb32dff2
>>> [2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
>>>         https://git.kernel.org/vfs/vfs/c/83e6e973d9c9
>>
>> Anyway, I'm not sure what's your thoughts about this, so I try to
>> write an email again.
>>
>> As Allison suggested in the email [1], "..so probably it should get
>> fixed before the final release.".  Although I'm pretty fine to leave
>> it in "vfs.misc" for the next merge window (6.13) instead, it could
>> cause an unnecessary backport to the stable kernel.
> 
> Oh, the file changes have been merged during the v6.12 merge window?
> Sorry, that wasn't clear.
> 
> Well, this is a bit annoying but yes, we can get that fixed upstream
> then. I'll move it to vfs.fixes...

Many thanks for the reply!

Yeah, the feature is already usable [1] and it will be used for
several use cases, yet the unexpected message might be confusing.
Anyway, both options are fine to me, but "vfs.fixes" may be better
to avoid unnecesary backporting.

[1] https://lwn.net/Articles/990750

Thanks,
Gao Xiang

