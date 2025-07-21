Return-Path: <linux-erofs+bounces-691-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF8CB0C3AF
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 13:52:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blzKq5PsNz2xRq;
	Mon, 21 Jul 2025 21:52:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753098767;
	cv=none; b=GYHquve1dykbTMafMeC+khaoC4RN74qld4mAHCAfA+DhXM3Eek8LV02yBPvXA4aAmgq66mlJG0IxF/ilDEZhrgNh95PrsaHTVfknky2trUEjhqv+uPOMvIK3lpUxONFAzUHIaTGZlCDXZv8XUJld0O/e5eikBU1Nwh+96Uk3KfjSckdpzWjyq/nQYNaMNBFUnT/BBncDf4NWlERGljhjKkjBTpBwGa0dbqX5x/8CPJ8z8yM3PELW9xGXG/iHZgxcJaUJpK0rbjo17DB0Z95Dgs1mv7FUEKTlt92WhXHH4uEyOT8HM1M+AUvJ6lgey5/Ms/jkGTqySwIEIJTEoAPefw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753098767; c=relaxed/relaxed;
	bh=xn+hlC0ADjp0KbawmAyVX05nJJetj+qoWgSmW+bOOXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tifolj4Er4jwtpjbmRdLmTMF3KOsHqsh/YhYuhC2SjaYKMJJgUSgWXWt83EDf349mIj7PVJZ1P1B5EWumyhHlAGwWZO2wYomr50zxjAUiUGnP04buxEQCcnkajKwatty2qb866KiB3oEl/ixWLjD9XUYZI2qjUQ1gxXz4q4Cx0zNeQsTpsDFn4RZjjB5pkkqFDf2dQgY5mtjVe9Mv8tnVnuMuJ8B7Iz+EwfC9V6DKv4o+A0phv27ObuYjLUL0+4chDzP2bcpg8tuH8t7TsNlAEf53vhBep15lxYtRABWObokY08Fp0+TAApm0kL4Eotn9OFhmV99p1sXfxgyZ3YyxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k+/flLBc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k+/flLBc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blzKp3CTqz2xHY
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 21:52:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753098761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xn+hlC0ADjp0KbawmAyVX05nJJetj+qoWgSmW+bOOXA=;
	b=k+/flLBcXGweWN2U8v3rPG2fTPCeEDCyHl42j1l0VB4rWRWGHnib7wocuOkqYa1xOj2MH5NAtiiYD2xsDdG9XQ9NS4/3tFS+3CaEoFGiWoa1A6B2/yYO66kDgTIV4TkjzniMpY31fwFgbOR5BzOiRooEyfZqzTvcnn9qFAZBsM8=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjOEOJD_1753098756 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 19:52:39 +0800
Message-ID: <5b01d35c-b73b-4c04-906d-6abc0c9e37ce@linux.alibaba.com>
Date: Mon, 21 Jul 2025 19:52:35 +0800
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
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Jan Kara <jack@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Hailong Liu <hailong.liu@oppo.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
 <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
 <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/21 19:36, Qu Wenruo wrote:
> 
> 
> 在 2025/7/21 19:55, Jan Kara 写道:
>> On Mon 21-07-25 11:14:02, Gao Xiang wrote:
>>> Hi Barry,
>>>
>>> On 2025/7/21 09:02, Barry Song wrote:
>>>> On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> [...]
>>>> Given the difficulty of allocating large folios, it's always a good
>>>> idea to have order-0 as a fallback. While I agree with your point,
>>>> I have a slightly different perspective — enabling large folios for
>>>> those devices might be beneficial, but the maximum order should
>>>> remain small. I'm referring to "small" large folios.
>>>
>>> Yeah, agreed. Having a way to limit the maximum order for those small
>>> devices (rather than disabling it completely) would be helpful.  At
>>> least "small" large folios could still provide benefits when memory
>>> pressure is light.
>>
>> Well, in the page cache you can tune not only the minimum but also the
>> maximum order of a folio being allocated for each inode. Btrfs and ext4
>> already use this functionality. So in principle the functionality is there,
>> it is "just" a question of proper user interfaces or automatic logic to
>> tune this limit.
>>
>>                                 Honza
> 
> And enabling large folios doesn't mean all fs operations will grab an unnecessarily large folio.
> 
> For buffered write, all those filesystem will only try to get folios as large as necessary, not overly large.
> 
> This means if the user space program is always doing buffered IO in a power-of-two unit (and aligned offset of course), the folio size will match the buffer size perfectly (if we have enough memory).
> 
> So for properly aligned buffered writes, large folios won't really cause  unnecessarily large folios, meanwhile brings all the benefits.

That really depends on the user behavior & I/O pattern and
could cause unexpected spike.

Anyway, IMHO, how to limit the maximum order may be useful
for small devices if large folios is enabled.  When direct
reclaim is the common case, it might be too late.

Thanks,
Gao Xiang

> 
> 
> Although I'm not familiar enough with filemap to comment on folio read and readahead...
> 
> Thanks,
> Qu


