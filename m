Return-Path: <linux-erofs+bounces-3393-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GSGMHeB8AWqSbAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3393-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 08:53:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85623508B68
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 08:53:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDVmY02m1z2xl6;
	Mon, 11 May 2026 16:53:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778482396;
	cv=none; b=iugFV6nlIVo1/nW7Pq3fwREUIjcb0L6L9U34wcEAn30L+qXit+9ytOxvVmk8JFcwLuUFRVIlM9WOf8nImGATfFTNLs4+Js9C2suLW7CZG2JullBMeLjWtg6nVBs7ViHR5ZFr+VCkpV7SCb1NfGOKqOwQQj6oja0fiTu0sKQss/DOqmKnYUqrCeDMe00KOWkybZC6wOtwA/V6HRxNuqRi9gfh6+vPyfT9w3pAYnwLf6q32UtdjQAJxJQH5K3zAmcRs/sTlkbxKglvstVr1LKdZVJKN2cLX4V6UrpE62X3ayn/T/2w1mZjzLxmkFVKQoVKoRs3BIS2JqlqiK3iVsx6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778482396; c=relaxed/relaxed;
	bh=w8ztuvuiqII8JK6Sx0lF53pCfMpk/9qYJ0qOvBoYU1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GX5uypC3SFEJoyjO4ybz5+ZhKypcLl54I6TYCxYYlIdS/lhlkuqAtwknZJiiXUDSikyfuF2/MJ/c+DNy86LcMLafg7FJPwp8A6ZIRZ9LVjH/B77Hwq6UbGEZ5GfqD6amJmM5weVqGnB5D6HbKjwVGyLLsjzOBNa34ZnkqdbVE+4WT2/6GVw5SeyX8x37NHQSF30CrtOvM8UfbWxhZtKd1INtyj7Lv0PVo5Ophz1k2H2JH1yKiD/1BOZvdCQOuWjZPmevThRBCmvV8FsR4mja35Dz2ZB5baNwAz8VXROBa/AzgiSGej7+E2ywK1CHfotIukChjKOt+ozmPzRl5ECK9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=udb3X5zv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=udb3X5zv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDVmV6KKbz2xSF
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 May 2026 16:53:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778482388; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w8ztuvuiqII8JK6Sx0lF53pCfMpk/9qYJ0qOvBoYU1Y=;
	b=udb3X5zvwEIc2fv0mLq7g7QtixWMJ9sxs9+jKg3AZE+hhOIJIodlzV1s1ZgA8hZLyMSDFZKpFVwwUh5ZsRqzu+6TXyxMTkFSq8G3yp1BXzlc2uoeW7qktYcs5P5T/d6cIxU979Ugt8Uuy2ezcvWUfsKz7cUKCPQ1aBcB4FDh5AU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2fyt74_1778482374;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2fyt74_1778482374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 14:53:05 +0800
Message-ID: <507ddec5-3a13-4df6-a6b5-732cc6b62d22@linux.alibaba.com>
Date: Mon, 11 May 2026 14:52:51 +0800
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
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata
 accesses
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, oliver.yang@linux.alibaba.com,
 Carlos Llamas <cmllamas@google.com>, Sandeep Dhavale <dhavale@google.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Tatsuyuki Ishi <ishitatsuyuki@google.com>,
 Matthew Wilcox <willy@infradead.org>
References: <af2kDfHe0B3LnvVm@infradead.org>
 <50668994-b6cf-4288-9ee2-0264bad2b271@linux.alibaba.com>
 <agF0wJSFRAEcRP8M@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <agF0wJSFRAEcRP8M@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 85623508B68
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-3393-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:ishitatsuyuki@google.com,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action



On 2026/5/11 14:18, Christoph Hellwig wrote:
> On Fri, May 08, 2026 at 05:10:21PM +0800, Gao Xiang wrote:
>> On the one side, I hope if there could be some interface for
>> such temporary usage rather than just one vfs_iter_read model.
> 
> As in a in-kernel mmap?  While not entirely impossible, the locking
> model for that sounds horrible.

I don't think it needs a full in-kernel mmap, it just works on
some uptodate folios.

Which locking model? For page cache, it's expected that all folios
shouldn't clear uptodate randomly at any time.

At least for erofs use cases, we only care uptodate folios, no
matter if it's being invalidated/truncated or not (mapping == NULL).
Maybe it's not suitable for other stricter cases, but for immutable
fs models, that is enough and efficient.

> 
>>> Now for reads it mostly works on the most common disk-based file systems,
>>> but it does create lots of problem for slightly more complex ones like
>>> network/clustered or synthetic file systems.  It also really breaks
>>
>> Just out of curiousity, could you point out one specific path
>> so I can look into that.
> 
> file system might require their own locking, e.g. cluster locks for
> cluster file systems, and at least in the path direct page cache access
> also caused problems with NFS data invalidation semantics.  Last but not
> least ->read_folio has a file paramater that isn't really a file but a
> file system specific cookie.  So calling this with something not managed
> by the file system can cause problems as has caused crashes in the past,
> although the offender at that time (the old smbfs) is now gone.

file is indeed a cookie, but I did some research on the codebase,
and I've seen no odd cases other than a real "struct file *" anymore.

I agree such usage is kind of gray area, but I've seen no risk in
practice as long as the underlay fs supports proper ->read_folio
callback (and erofs restricts that.)

> 
>> But could we just fix this issue first for previous linux versions?
> 
> I just pointed out another issue.  You'll have to fix the credentials
> either way.

I really hope Matthew could give some opinion on this too, because
this way, the underlay cache can be directly used for temporary use,
and it should be a RO access and won't impact any fs-owned state.

Anyway, I could work out an alternative, but that makes the metadata
access less efficient.

Thanks,
Gao Xiang

