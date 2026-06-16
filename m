Return-Path: <linux-erofs+bounces-3655-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DBXcKnN7MWrxkQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3655-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 18:36:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C652E6923EB
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 18:36:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="oSkzNAr/";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3655-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3655-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gft0J4PDfz3c4Y;
	Wed, 17 Jun 2026 02:36:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781627760;
	cv=none; b=YIvWNpJszfthWlcTAPxEcO+3shrWPhSkipmByxY1gyoqBXubM7psB//5AAWYrKcgmj4RgoIEtuIOhKoWWar6P4iMT/Vx+owQOIPAzhuaxDb62FyAu2ckWUCEh1ljVTyUapfdoq5C+Ws0+/rlVwoHREf3SLcsfFTo/bTIq6v8qfounLaDud888F4GD+zyTrdkj0qXSDGtyEQuHigjvlKxndr5Atp/ZGcrbtdkWsk5e0TcQbfQvK8QuhMza//XTOsGvoSWDdkXSthrgHudsfDpTVnQz70E/d2yRcbyU5lS5o/cH/HuXX6pmGKdTrtSwDzQAYNPhllbsCe9BqNT4eUBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781627760; c=relaxed/relaxed;
	bh=B4jBFIdFiNtDsmQMyWWPd+1DnLb23kwsj3MeQY91MXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/5XqIalgCedrhGSjrLMj0dbibJJC8z3CjRMho3SppcHv6awmBcypAeAaJXU16F+5wHnqdZW0AVgTOzDa2B/2rWHDHtTLVSvL1KOqptwFpqyH9z3A3lsVOMqfQvipjngDLOqjmxDKC5NvlIU3yHyjF0LsN0j28vp88Zc0g0WAx2ZJLuNw9KVzbwOMEJy6LYHAeFXfu4IQGQTYsPN4DaEXvnIXAouO1C5L7mcwMZDJVBZvU3jcPxOWpQobzUyrl435OCGlNJjaBJs0tJvrUQ+m1LlDQIX0y1RSeBbInFZrOzpVDXvor9ejmC68ReeCelAx7/eTkoZWPv3rbpiDt5t1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oSkzNAr/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gft0G3cgcz3c3v
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 02:35:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781627752; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B4jBFIdFiNtDsmQMyWWPd+1DnLb23kwsj3MeQY91MXI=;
	b=oSkzNAr/27e92aKNerb+qZa44Z+sXt2zjnAe8/cVBq6IRDAtWKDeS3YSG5QeN9uTKVl1yhTAvRyvpxMavXVXKU220fKkSaWt4WMbC4LZ4x6mdnQuzfD6WVWvQWCD0WweXJAbGwUQGGaGqjzoMx8HKgmMTmjWN38FnJ5EQmMbEsI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X5.qxzD_1781627749;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5.qxzD_1781627749 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 00:35:50 +0800
Message-ID: <8f1c032b-b951-4d0d-93fa-229248993f2c@linux.alibaba.com>
Date: Wed, 17 Jun 2026 00:35:48 +0800
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
Subject: Re: [PATCH RFC 2/8] fs: add a global device to super block hash table
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-2-bb0fd82f3861@kernel.org>
 <20260616123443.GA21024@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260616123443.GA21024@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3655-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C652E6923EB



On 2026/6/16 20:34, Christoph Hellwig wrote:

> IMHO sharing devices between superblocks is a bad idea, but that ship
> has sailed, but please keep it contained inside of erofs.

I'm not sure why it's a bad idea, for example,
the immutable layer model is already applied to layered virtual
block formats (such as qcow2) and layered fs like overlayfs.

and I think device mappers may have some similar immutable
approaches as shared layers but works in a slight different
way.

The principle is that each instance uses shared blobs in a
read-only way, and that is almost a simple and safest way
to share data among filesystem instances.

Yet I don't want to argue with that since it's pretty common
for years and I've seen no practical risk using this model.

Thanks,
Gao Xiang

