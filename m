Return-Path: <linux-erofs+bounces-2070-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32478D3BDCE
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 04:08:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwC1s5YvNz3bfV;
	Tue, 20 Jan 2026 14:08:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768878481;
	cv=none; b=GontfUdVAk4Sv2pPp77lR90dOIDawnNfsvFjYLmXFB1WdJfkKFvSgd1X9KixDzCWLJ6v0h+fSLlJ6vfKDKyExB8qsb05oy8g9jm+O5rcTsy7AKowxT9/7iSKLCo3ye1eCHUD/JgnuSOcSA6tQBoW/ZWbTOLBL4sG8cAXlekyg6RiOur/z6tbu3RiMVH7kY6efZ8z4nSzZvJ2giPZPMI0h0A9c7oBMMZ4LIhxn9jadJ/RJaX+SHG7x0zOQSG1qY1xxZFGSnXR1FnHPrXxEOLtzt3Iflz7rifNNqJhJ0Uo2ytkiwRWjP0EkOeH2Ae5PLoGONKV2AR3UAk0xS05Y+1yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768878481; c=relaxed/relaxed;
	bh=Cix8RfjAm/j7o5j7yv9VEqavN9i3fefTuACkIfVQRNA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JuQE6kUQD6BG6rNSteHuw0HXlQR/Ihvzhw1S6XTNDIR9yXCFsvEmOjdsBGu5sFtemZUfOe5sh8Ne1rrFoc3tlgGI4pC0MMrrKMJ4YQNwG9NliXLkEp4IWMZ0yANatRMKLLZ+LJjG3iZvPZc7ni4WohB2KfLGtHlFSfNew6X+gZ6laeH2QBmTs9gYb8e3o2MRNsX8jTtRpBS7Un13EjHiFMqAILG5qLwHb8N/rJaek8HUrdwOYmexYolaWe9nTXHMA/J4aHotKZdziKWVsnEorjPZx0B4FgiLzvcYuhmT1Mxfej5X5UWR8S2dY371d2jYcbx7YE12wqzJoZkNa4QElw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tmf+wvEG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tmf+wvEG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwC1p6WN6z3bfG
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 14:07:56 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768878471; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Cix8RfjAm/j7o5j7yv9VEqavN9i3fefTuACkIfVQRNA=;
	b=tmf+wvEG69wB2ylctPp8LSMZeL1zNkhfA+reqBfNXhqRpJGz9d1KBs/Qa5R1fP3AIwfDrH/KOskUo734EcH4BOtr/5l9ko1LUJPPrSEaum9eylkykOhAwiMtfdx3q7zPpdpKjMYDt7q5bXOdqxvoHcsKPvpwKGaQmYgyGEgA40s=
Received: from 30.221.131.31(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxSfb8._1768878468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 11:07:49 +0800
Message-ID: <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
Date: Tue, 20 Jan 2026 11:07:48 +0800
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
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, oliver.yang@linux.alibaba.com
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
In-Reply-To: <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


Hi Christoph,

Sorry I didn't phrase things clearly earlier, but I'd still
like to explain the whole idea, as this feature is clearly
useful for containerization. I hope we can reach agreement
on the page cache sharing feature: Christian agreed on this
feature (and I hope still):

https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner

First, let's separate this feature from mounting in user
namespaces (i.e., unprivileged mounts), because this feature
is designed specifically for privileged mounts.

The EROFS page cache sharing feature stems from a current
limitation in the page cache: a file-based folio cannot be
shared across different inode mappings (or the different
page index within the same mapping; If this limitation
were resolved, we could implement a finer-grained page
cache sharing mechanism at the folio level). As you may
know, this patchset dates back to 2023, and as of 2026; I
still see no indication that the page cache infra will
change.

So that let's face the reality: this feature introduces
on-disk xattrs called "fingerprints." --- Since they're
just xattrs, the EROFS on-disk format remains unchanged.

A new compat feature bit in the superblock indicates
whether an EROFS image contains such xattrs.

=====
In short: no on-disk format changes are required for
page cache sharing -- only xattrs attached to inodes
in the EROFS image.

Even if finer-grained page cache sharing is implemented
many many years later, existing images will remain
compatible, as we can simply ignore those xattrs.
=====

At runtime, the feature is explicitly enabled via a new
mount option: `inode_share`, which is intended only for
privileged mounters. A `domain_id` must also be specified
to define a trusted domain. This means:

  - For regular EROFS mounts (without `inode_share`;
    default), no page cache sharing happens for those
    images;

  - For mounts with `inode_share`, page cache sharing is
    allowed only among mounts with the same `domain_id`.

The `domain_id` can be thought of as defining a federated
super-filesystem: data of the unique "fingerprints" (e.g.,
secure hashes or UUIDs) may come from any of the
participating filesystems, but page cache is the only one.



EROFS is an immutable, image-based golden filesystem: its
(meta)data is generated entirely in userspace. I consider
it as a special class of disk filesystem, so traditional
assumptions about generic read-write filesystems don't
always apply; and the image filesystem (especially for
containers) can also have unique features according to
image use cases against typical local filesystems.

As for unpriviledged mounts, that is another story (clearly
there are different features at least at runtime), first
I think no one argues whether mounting in the user space
is useful for containers: I do agree it should have a formal
written threat model in advance. While I'm not a security
expert per se, I'll draft one later separately.

My rough thoughts are:

  - Let's not focusing entirely on the random human bugs,
    because I think every practical subsystem should have bugs,
    the whole threat model focuses on the system design, and
    less code doesn't mean anything (buggy or even has system
    design flaw)

  - EROFS only accesses the (meta)data from the source blobs
    specified at mount time, even with multi-device support:

     mount -t erofs -odevice=[blob],device=[blob],... [source]

    An EROFS mount instance never accesses data beyond those
    blobs.  Moreover, EROFS holds reference counts on these
    blobs for the entire lifetime of the mounted filesystem
    (so even if a blob is deleted, blobs remain accessible as
    orphan/deleted inodes).

  - As a strictly immutable filesystem, EROFS never writes to
    underlying blobs/devices and thus avoids complicated space
    allocation, deallocation, reverse mapping or journaling
    writeback consistency issues from its design in writable
    filesystems like ext4, XFS, or BTRFS.  However, it doesn't
    mean EROFS cannot bear random (meta)data change from
    modifing blobs directly from external users.

  - External users can modify underlay blobs/devices only when
    they have permission to the blobs/devices, so there is no
    privilege escalation risk; so I think "Sneaking in
    unexpected data" isn't meaningful here -- you need proper
    permissions to alter the source blobs;

    So then the only question is whether EROFS's on-disk design
    can safely handle arbitrary (even fuzzed) external
    modifications. I believe it can: because EROFS don't
    have any redundant metadata especially for space allocation
    , reverse mapping and journalling like EXT4, XFS, BTRFS.

    Thus, it avoids the kinds of severe inconsistency bugs
    seen in generic readwrite filesystems; if you say corruption
    or inconsientcy, you should define the corruption.  Almost
    all severe inconsientcy issue cannot be seen as inconsientcy
    from EROFS on-disk design itself, also see:
    https://erofs.docs.kernel.org/en/latest/imagefs.html

  - Of course, unprivileged kernel EROFS mounts should start
    from a minimal core on-disk format, typically the following:
    https://erofs.docs.kernel.org/en/latest/core_ondisk.html

    I'll clarify this together with the full security model
    later if this feature really gets developped;

  - In the end, I don't think various wild non-technical
    assumptions makes any sense to form out the correct design
    of unprivileged mounts, if a real security threat exists, it
    should first have a potential attack path written in words
    (even in theory), but I can't identify any practical one
    based on the design in my mind.

All in all, I'm open to hear and discuss any potential
threat or valid argument and find the final answers, but I do
think we should keep discussion in the technical way rather
than purely in policy as in the previous related threads.

Thanks,
Gao Xiang

