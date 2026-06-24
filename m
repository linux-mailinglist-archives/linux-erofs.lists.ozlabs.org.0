Return-Path: <linux-erofs+bounces-3756-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+R/ALRePGp7nQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3756-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 00:48:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E74956C1CF5
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 00:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=CTFoWVgh;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3756-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3756-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glxt6098fz2xLm;
	Thu, 25 Jun 2026 08:48:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782341293;
	cv=none; b=TzHcf1PIs6YAepBKJIO+MVVRM4kwEX0CjR5jn1aDOk/jmWinhB2aZtWNtd8HrHrb4y9esypOPbv2VZKsPyqpYv0oSVxQpypf/UKkGQDEWfcPFVKGQaoAgueV1kbWJwhsLWE4T9P0+vynyTjbQ6sABK2bMWVR76eNObMHvTGqosDGEUg6v6XHSUiHm6hDgpkkys/W9dumk80X+Labh7KTUQXuPZSn6Xk90DvgCEsX1FcbWm72Bto0DMD2AsJmj8AiGg3fOuxfKXg9ONdCg0jihtRlx8321dTN8A9oG2nHeisFTsxGGoj3MjODdM6r4zan7OtEPqq8NZ+Ar7bS1f7GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782341293; c=relaxed/relaxed;
	bh=RGMvBCrNk+Lqy9bKhGcAKB7S0UyrlOegrIoDIDBDR1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfjqyAw0Y+KN3Uzu++1wYYglR6ecAOrOOR7Fi0jwJC5mibMC0U0yMTsCR4d4krpG38mNzjSxgNNGSvC4OigW4m7Y8qZnidGi/xaavOesO4jx0XmL462eL4Bg9j2ey7h3+0bBioFsGR/1+Pmw4WgFjwroZVMrZeZtr/dkX1u6s0bbQJ+4V4E+yoFze4Lub/f/0W6GGDQ82DLbby4qCWY9/kaNNcZliXGaWbYh+ZTagVsSVBX8vP+pEJ1j6FYESrQLHylwMTSHfniXjs8sNqYjAqqWWUAKixOKOKsNHY7ZBTVZ64rDhva9JnwS7rnhfzcBhYZKntOL1lFabI1528Du0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CTFoWVgh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glxt366NFz2xJT
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2026 08:48:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782341286; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RGMvBCrNk+Lqy9bKhGcAKB7S0UyrlOegrIoDIDBDR1w=;
	b=CTFoWVghFt58SrZlPJfru83HEcGAK3izWYiNh4q09028sEolSD639tQJeQK/H6Zzhz4++T7MDsFmd+oiuHadBQe3jCHrDU973KjxGUBasbEd3pqpa3eP+L7azFi6phrf+8xgaYA8oRZUzxDLxKtSIPqeJ6UBhwor43FmSCGiZzA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X5Z9VTW_1782341282;
Received: from 30.180.134.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5Z9VTW_1782341282 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Jun 2026 06:48:04 +0800
Message-ID: <add4b410-4440-4076-879e-2048f97687ee@linux.alibaba.com>
Date: Thu, 25 Jun 2026 06:48:02 +0800
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
Subject: Re: [PATCH RFC v2 17/18] fs: look up the superblock via the device
 table in user_get_super()
To: "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-17-7df6b864028e@kernel.org>
 <20260624175417.GU6078@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260624175417.GU6078@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3756-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:brauner@kernel.org,m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E74956C1CF5



On 2026/6/25 01:54, Darrick J. Wong wrote:
> On Tue, Jun 16, 2026 at 04:08:33PM +0200, Christian Brauner wrote:
>> user_get_super() still finds the superblock for a device number by
>> walking the global super_blocks list under sb_lock. Every superblock is
>> registered in the device table under its s_dev since sget_fc() inserts
>> it there, including superblocks on anonymous devices, so use the table
>> instead.
>>
>> The refcount-pinning cursor helpers super_dev_{get,first,next}() only
>> touch table state and do not depend on CONFIG_BLOCK, so drop the
>> CONFIG_BLOCK guard around them: their new caller serves anonymous
>> devices as well (ustat() on e.g. tmpfs) and is built without
>> CONFIG_BLOCK. The guard falls in this patch rather than separately
>> since without this caller the helpers would be unused without
>> CONFIG_BLOCK.
>>
>> The pinned entry holds a passive reference on the superblock so
>> super_lock() can be called directly; once the superblock is locked grab
>> a passive reference for the caller before dropping the pin.
>>
>> The device table contains more than the old walk could find: a
>> superblock is also registered for every additional device it claims
>> (the xfs log and realtime devices, btrfs member devices, the ext4
>> external journal, erofs blob devices). Don't filter those out:
>> specifying any device a filesystem uses now resolves to that
>> filesystem, so ustat() and quotactl() work on e.g. the xfs log device
>> or a btrfs member device (the latter used to fail outright as btrfs
>> superblocks carry an anonymous s_dev that never matches a member
>> device). When several superblocks share a device (erofs blob devices)
>> the first live superblock wins.
> 
> Does erofs have a means to find the other superblocks that share a
> device given a notification coming in on one of them?  
Nope, erofs currently doesn't have a way to find the other
superblocks (it  doesn't maintain the relationship). My previous
thought is that because it's a read-only filesystem, IMHO, there
is not a must to implement shutdown or notification mechanism in
erofs itself, just because it's strictly immutable (no local
write or dirty journals), and block layer can return io error
on dead bdevs directly even it's a shared block dev.  But I may
be wrong if there are reason that we should maintain the
relationship.

Currently it only uses sb->s_type as the holder for bdev sharing,
I think Christian meant that.

Thanks,
Gao Xiang

