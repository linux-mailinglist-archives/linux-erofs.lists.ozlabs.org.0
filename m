Return-Path: <linux-erofs+bounces-689-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FFB0C34D
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 13:40:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blz3Y5hvsz2xRq;
	Mon, 21 Jul 2025 21:40:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753098025;
	cv=none; b=jIlEFV8baKqqy0kmaDO82g/Q552lIt/tRhoGZHWyoIQosuwsFH1zSBWWZvjHPWruAKjIMywpJ2eSC7Kl66RUFLM/MdR3gmIxhXF8cPBVJRjBGMQAN4pogh3/sqg1/nL49arE7jQFFQGyJJodtX0Bwm9L/9O5GH+Na6kj/U6NmwNRUPJHIrK8kWJBigcTfHJ+5gQxaXkQX3NxIxiQWRNjYHNzDbLGwN1odsD6SIy+7k9x8gD549W1TMYr+dF2h3i4ndQSnAzCucGeyjgsuz4QxtzexgJl42MiekQXe4DJkSMK7wyx9IJtFvVXLP3GJPMwNwMoCVRm3GurPVudUuM9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753098025; c=relaxed/relaxed;
	bh=8/0MxmZXQFEgx1v9g0Zx0cK6D0Dzk/CVwttHZ2ijYQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMhMKDG0VjHLnMGIxdWsDECujuCjnoVrgWFX2pmY6fGBSqhpD5Hhgc5BTR3GvDPOESN7o/SXv40mRN0qTg7KCvLmqx/Uix11hCEjYxuat19l3QkoJUN31BZ4QoUxbA449Ia8q8PR6lU7KNokSdfHJrE9denMn5HeLSw1rnqEKHUF8phcvxHrql1dcr9UGxb7+Bz3yjoFj2qbIl2pQynmLyANXZq7ILVoFyeBHP7BwIMDhcwU+jNnmPRxk8V/izE+bOTnDaRwkK5iZVrlmZHrRki4IcdT78Kpx3aOWGEc67ZGrDwrWgwkHerVTVO7+0qedigHviNL9FRqytKpMa0r4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=To+tN/af; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=To+tN/af;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blz3W5qjxz2xHY
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 21:40:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753098017; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8/0MxmZXQFEgx1v9g0Zx0cK6D0Dzk/CVwttHZ2ijYQw=;
	b=To+tN/afrpIjgEz4eaK5y1iopdYpau0MWOlLa9zuoKblmMht57WggD66TKmWhOTqfw+p35hzplwhxDkpOazJpQG6yigqILHc+cxsDgBISdCpozXzygAEcFxy4SnmzLJh8XWFLaEIF2Lq434wE3odzogB/CEUIevGEfwbrKwKK2s=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjOEKZd_1753098012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 19:40:15 +0800
Message-ID: <de793a0d-b65e-4b36-ad7f-3202515ba9c9@linux.alibaba.com>
Date: Mon, 21 Jul 2025 19:40:11 +0800
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
To: Jan Kara <jack@suse.cz>
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
 Hailong Liu <hailong.liu@oppo.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
 <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Jan,

On 2025/7/21 18:25, Jan Kara wrote:
> On Mon 21-07-25 11:14:02, Gao Xiang wrote:
>> Hi Barry,
>>
>> On 2025/7/21 09:02, Barry Song wrote:
>>> On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>
>> ...
>>
>>>>
>>>> ... high-order folios can cause side effects on embedded devices
>>>> like routers and IoT devices, which still have MiBs of memory (and I
>>>> believe this won't change due to their use cases) but they also use
>>>> Linux kernel for quite long time.  In short, I don't think enabling
>>>> large folios for those devices is very useful, let alone limiting
>>>> the minimum folio order for them (It would make the filesystem not
>>>> suitable any more for those users.  At least that is what I never
>>>> want to do).  And I believe this is different from the current LBS
>>>> support to match hardware characteristics or LBS atomic write
>>>> requirement.
>>>
>>> Given the difficulty of allocating large folios, it's always a good
>>> idea to have order-0 as a fallback. While I agree with your point,
>>> I have a slightly different perspective — enabling large folios for
>>> those devices might be beneficial, but the maximum order should
>>> remain small. I'm referring to "small" large folios.
>>
>> Yeah, agreed. Having a way to limit the maximum order for those small
>> devices (rather than disabling it completely) would be helpful.  At
>> least "small" large folios could still provide benefits when memory
>> pressure is light.
> 
> Well, in the page cache you can tune not only the minimum but also the
> maximum order of a folio being allocated for each inode. Btrfs and ext4
> already use this functionality. So in principle the functionality is there,
> it is "just" a question of proper user interfaces or automatic logic to
> tune this limit.

Yes, I took a quick glance of the current ext4 and btrfs cases
weeks ago which use this to fulfill the journal reservation
for example.

but considering that specific memory overhead use cases (to
limit maximum large folio order for small devices), it sounds
more like a generic page cache user interface for all
filesystems instead, and in the effective maximum order should
combine these two maximum numbers.

Thanks,
Gao Xiang

> 
> 								Honza


