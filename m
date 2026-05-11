Return-Path: <linux-erofs+bounces-3399-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJDGIPTqAWpHmQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3399-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 16:43:00 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F6F5106A5
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 16:42:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDjBR71Nbz2xlh;
	Tue, 12 May 2026 00:42:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778510575;
	cv=none; b=d3oe6p+5cVfaMbpzPpKhd5cQdjECdK1O0wrXecWabeHzb1q60BiBU9dVQKTsWE91E8RmEdMlEU2kRuagfl5o9YmM/WFN4VIThIvjcf58T5bQIMHybnEgSfQvFgysZlLgpZnF7WHc4aU6EEw8wxwwhEogHl8AoH+m6BsnTjnlLVWRdlyUt+yBrCSf0XhTVlPNSBc3xmJIEe/BsTrXtdKKLge+O/c0oUpdRQBgz4RADSWSdHTl8LGb2tNvCtkbuEN5Ksxn6CLbdfbWVclbE1E1Th8g5MVEYa64QPR3LexseCZ0sKDyUjb+Mq+kJk+xLA07iK8KCWwl4iNZHWl70DM6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778510575; c=relaxed/relaxed;
	bh=FMVWlhVg9AeJ1ZnmPiBpEL8Z//kUv99hwHffwNmxotg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CONCE+Moh+YImMpyGPo6MrebyJGFXrUpKgnDfDsransXD0abQNzjPEoA0YIlJyUJ7XwDl7SWG6RwrDBHypN7lmyCGVqZUtsN44fugNQ22dF2TjgisyHsSkBu1+/TzM4dyW3IXwhSknENRtGsqPLsHnLkPM2Dq/hdka6ivfm7YfDwQJEdhlnTkZDOvkduvPry8SlCjK6zlzc6uSOVg1KKlAHaMLzuR+vUaKm3P1DWfnfiqHv62x/OuVG1DY74YGa+PF0gE+mwBp+Gk7WmD6R6HQ5XUfSTjtEpdhB3UYpWgfsOEuEAST4LSQ6EgXsph7md/5lbuJ3ix2X3+jB/H/IW9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yjtWCK6i; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yjtWCK6i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDjBP1DnXz2x9N
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 00:42:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778510567; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FMVWlhVg9AeJ1ZnmPiBpEL8Z//kUv99hwHffwNmxotg=;
	b=yjtWCK6ixRM8pv9uRJYAJne2E98Qp7E6kaSn/cbWouMo76+1QwzFCywQg6omR74MHt8FOIgL6HRLCTvmIqZ9fHcYP189klaoN9hSKKMjcPzXrZ3zVn64492gHOxemFMiHrd00o09wvdnxySONl0VVXkT7UG0PjnWx5IdYcZs7MI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X2klsdY_1778510551;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2klsdY_1778510551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 22:42:44 +0800
Message-ID: <98133825-30a0-4519-a0b0-8054ed02490c@linux.alibaba.com>
Date: Mon, 11 May 2026 22:42:29 +0800
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
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>,
 Sandeep Dhavale <dhavale@google.com>, linux-fsdevel@vger.kernel.org,
 Tatsuyuki Ishi <ishitatsuyuki@google.com>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
 <af2c4X1YCB7NEb8p@infradead.org>
 <CABqzrSOaCMPD_QrSq_y_6bXLC3ecm3FZsE_ACrdNbTHG8baMCw@mail.gmail.com>
 <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>
 <20260511-ozonbelastung-verzweifeln-a03cd0309ad9@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260511-ozonbelastung-verzweifeln-a03cd0309ad9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: D2F6F5106A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3399-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:hch@infradead.org,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:linux-fsdevel@vger.kernel.org,m:ishitatsuyuki@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Hi Christian,

On 2026/5/11 21:51, Christian Brauner wrote:
> On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
>> Hi Christiph,
>>
>> On 2026/5/8 16:24, Tatsuyuki Ishi wrote:
>>> On Fri, May 8, 2026 at 5:20 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>>> On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
>>>>> Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
>>>>> credentials when accessing backing file"), rw_verify_area() needs
>>>>> the same too.
>>>>
>>>> Two things here:
>>
>> Let me use Tatsuyuki's reply to address your two comments.
>>
>>>>
>>>>    - rw_verify_area is a helper for use inside the VFS and file system
>>>>      read/write method implementation.  Erofs as a user of the VFS should
>>>>      not use it at all.
>>
>> Currently EROFS file-backed mount metadata is directly using underlay
>> fs page cache, which is mainly used for composefs, etc. to avoid
>> different EROFS instances have their own EROFS page cache for the
>> same underlay backing file and avoid unnecessary copies into them.
>> --- That is also what composefs once did in their codebase.
>>
>> Since EROFS just read the underlayfs page cache and does _not_
>> touch anything inside the underlay page cache itself, so I guess
>> it's fine?
>>
>> On the other hand, we talked a bit commit f2fed441c69b ("loop:
>> stop using vfs_iter_{read,write} for buffered I/O") in another
>> private thread related to fanotify, which lacks proper
>> rw_verify_area() as well, since it called into raw read/write
>> iter methods instead of using the previous vfs_iter_{read,write}.
>>
>>>>    - using the opener credentials when accessing the backing file seems
>>>>      wrong.  The entity accessing it is the file system, so it should
>>>>      have system or mounter credentials, not that of someone causing
>>>>      metadata / fs data access.  And this applies to all access by
>>>>      a file system backed by a backing file.
>>>>
>>>
>>> I think there's probably some confusion of terminology here. buf->file is
>>> opened with the mounter's credentials, so we are impersonating the mounter
>>> here. Perhaps the commit message could describe that more clearly. Same for
>>> the previous patches mentioned.
>>
>> Here "opener" means the mounter as Tatsuyuki mentioned, I just
>> follows Tatsuyuki's term, but it just means mounter credentials
>> indeed.
> 
> We're slowly reinventing overlayfs I see. ;) I think it's probably fine
> but it's also rather sketchy to mess around with permissions like that.
> Mainly because I don't think we have any actual page cache permission
> model. It's inherently shared beetween everyone and this kinda tries to
> bolt permissions on top to not make it so. Probably fine here but also a
> bit wonky.

Loop devices just purely use kernel cred instead, I think using
the mounter cred is more reasonable and safer than the kernel
cred.

Anyway, I think this cred part is less controversy.. The main
issue out of Christoph is still the metadata path: I tend to use
the underlay inode page cache for temporary RO access since it's
efficient and cache-friendly; and for immutable models we
shouldn't care too much about the invalidation, etc. since there
is no need to rely on the locking to keep the underlay data in
a strict way.


Thanks,
Gao Xiang


