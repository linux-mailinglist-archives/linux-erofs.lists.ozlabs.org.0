Return-Path: <linux-erofs+bounces-3387-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BtQAJmo/WmEhAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3387-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 11:10:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849F4F4171
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 11:10:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBjyX3bWtz2xdb;
	Fri, 08 May 2026 19:10:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778231444;
	cv=none; b=oRHbCekI2VcXFJK+B205VSxcO0tDYuMgHm1BzAdoykMocWVsIQA+rkZLadBeVyQl0aieIAJud7+OmbJ7+h15fnDzR0O8gOCuKkn+TOMMqXq0FkXVj2PNWfyAO8fmq3tKsAnlrsEMXxiaM9WhMavgFsW4OyN8/Nr0MT//Is3wbF0lo/tAAIK8CsR8GEE8nAT1WeSnfCAdfn+gGhxq3OFd+czUnWa+IcLBgizYxyd1LqTLfH9l1gzqt8WWj0fI+kA5WIW0gdo2IQW9oI8fjWkk5zU71iA0UcRGc7zAE3DL5PYjxFT+5Ke+YsRvRY4UCoWp0DOkqlQz7Wga6eR4siIwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778231444; c=relaxed/relaxed;
	bh=G7gqn9fF68YEGO2rjLNc6y68iZ4WaEVDGDVBH/83ckA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXb77IhOpA8Yp0VvePJSK7FJLcKtZQVclJ3bOCLbnPq1bz/RToEKPXYTvcVqBNUF3g2gP60qLtOulvO+qwiOWl2nweRsB4iJ9IuyvtaViWn+rOm23Nb1vw6deJWh+QD/cbS9yGs61UJ/TUpT8HgjAgbasKAvH+8otYEDV8l0YhP85eCOpp10NnK47RPhKie06EUxdPkDTHXkxtJ+MKG574jZN12meJcxuJs5T7YcyInaD4fSaq/t71GBFxd/TFo1R7Caf3yJvlGbTAzjMGZ/t1AmGqQPoHqtDg+7W38HzNoS6b3rn22pMagv4ZvWpkExPaHJLRo7g+/0faDMiIXXdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CFtBaDPh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CFtBaDPh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBjyV1z7nz2xQC
	for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 19:10:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778231436; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G7gqn9fF68YEGO2rjLNc6y68iZ4WaEVDGDVBH/83ckA=;
	b=CFtBaDPhgmNERWBPqVF/AJnJ5IZODNzSng5yrVy+A/ZAqvG1EvqC/don0rDrnYfqdtFbdCH6WvEi9HmFbUuCBcDtCMNeOrdOoR7mk27P+fi3bIIRmfrono+E4zKVZxQ2wRmvhG32DUssRbDksW4XFP/DLgMyDi6w7osSHwI/1mg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2WwjyI_1778231422;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2WwjyI_1778231422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 17:10:34 +0800
Message-ID: <50668994-b6cf-4288-9ee2-0264bad2b271@linux.alibaba.com>
Date: Fri, 8 May 2026 17:10:21 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <af2kDfHe0B3LnvVm@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 7849F4F4171
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-3387-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:ishitatsuyuki@google.com,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 2026/5/8 16:51, Christoph Hellwig wrote:
> On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
>> Currently EROFS file-backed mount metadata is directly using underlay
>> fs page cache, which is mainly used for composefs, etc. to avoid
>> different EROFS instances have their own EROFS page cache for the
>> same underlay backing file and avoid unnecessary copies into them.
>> --- That is also what composefs once did in their codebase.
>>
>> Since EROFS just read the underlayfs page cache and does _not_
>> touch anything inside the underlay page cache itself, so I guess
>> it's fine?
> 
> At the micro-level this does mean erofs needs to do the checks itself.
> OTOH it means this whole scheme is completely broken.  The page cache
> is owned by the file system, so erofs can't simply poke into it.

The page cache is indeed owned by the underlay file system
instead, but erofs doesn't poke into it: it just needs some
temporary metadata read usage without extra allocated buffers.

On the one side, I hope if there could be some interface for
such temporary usage rather than just one vfs_iter_read model.

> 
> Now for reads it mostly works on the most common disk-based file systems,
> but it does create lots of problem for slightly more complex ones like
> network/clustered or synthetic file systems.  It also really breaks

Just out of curiousity, could you point out one specific path
so I can look into that.

> layering, so we need to fix it.  Not sure what would be best, but I'd be
> tempted to have a cross-instance cache maintained by erofs and filled
> using in-kernel direct I/O.  IFF the page policies work great for you

Direct I/O may be improper for many cases, since users will use
buffer I/Os to download the images from remotes just now, and
direct I/O just makes it worse (invalidate the cache, and reread
from disk) and double caching if underlay file is also read.

> that even could be a synthetic inode/mapping.

I expect the similar comments, if we really need to work out such
cross-instance cache, I'm fine to implement for Linux 7.2.  It will
increase the complexity of the codebase and also it won't share the
cache with the underlay fs.

But could we just fix this issue first for previous linux versions?

> 
>> On the other hand, we talked a bit commit f2fed441c69b ("loop:
>> stop using vfs_iter_{read,write} for buffered I/O") in another
>> private thread related to fanotify, which lacks proper
>> rw_verify_area() as well, since it called into raw read/write
>> iter methods instead of using the previous vfs_iter_{read,write}.
> 
> Note that this does not add the bypass, just extends it to both I/O
> types.  But yes, this breaks fanotify.  We actually have quite a few
> raw ->read_iter/->write_iter calls, so this might need more structured
> treatment.

It also bypasses the security hooks I think.

Thanks,
Gao Xiang



