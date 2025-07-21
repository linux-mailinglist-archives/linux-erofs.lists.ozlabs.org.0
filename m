Return-Path: <linux-erofs+bounces-684-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8AFB0BB42
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 05:14:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bllqX13dTz2yRD;
	Mon, 21 Jul 2025 13:14:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753067656;
	cv=none; b=fkTsi9jYPhzarbv15bfm852AfTvwfWGS4EytsmKm9omFDuhCJKfg3/qod7Id+ypUcB27EWwby4Rol8LeMbA00cnC5fCvBdtnOQ70m2XtlUi+k9HyZvomRUaiwoPGf6plG/6BoZY+7MgnaMVc+8UidDm8BaDBjaEI0EgVdOfzt021RK8A5cOrHyPpQOyWrpRRaffEUA52KmUcdSKRrec4lhO8dhUWmEMYsmCYiUvbUNWYUEVLiCv5+NcKDVCPrQ/Qf6U8J2ou42SZmNrDt/Z8fcRVM64H5zBu6KNE6ps3rSNL3B8A+eHZLwp+xPHs43INQ4CqMd/bcGF9M4gwg9b1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753067656; c=relaxed/relaxed;
	bh=lCr7ru8zjyenyzhIwOzkZiA0apFYT5PO1pQKlR1f6Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC2OC4y4QgPEqGgen37YzBs9Jqudy7/G7qz8hN2GvpCwMGlf6jH8sdxEELs43SwokUNzCBYIpHdDGDqmM5XcAMRWXXRhBVfOb/C3vkQ9kQJOMIjR6FglMLQUMNOcectmur9gfRDfIqswBlb5T3iieJikuLNU8Icdje1i7cnJxGvoT7xXUnadqEM14EEYyT14KOAmAqgwKOccZQFtb+qmto66ZXVwBo275cbcSiw8Na7evJ5D4S1D15TVgdMAt0O3lLpkOGxqtiXrKKFuJ1boZHHGCt200ZbgOrv77mN6KgVa58Ge00OOeGlrd1qJvrYhJs4ShpInyHZt955hV+Bp1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fziExLzu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fziExLzu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bllqT6PjKz2yFQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 13:14:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753067648; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lCr7ru8zjyenyzhIwOzkZiA0apFYT5PO1pQKlR1f6Gw=;
	b=fziExLzuV0rwx+GNWyk/aJVvLiw1lgfmtG0LVBGZ/fXM0/0zWxg0EtREi2ma38nXPryOAVmk72zNme1RDevzg4cZAmIbEFy4vq17BzYaoHwhzcXIYN+J2mYubwxO/v6uCpPangEKOAXY+UpHDPG/3hV4FABx7exXkQlz7jwfW3Y=
Received: from 30.221.132.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjIdN4u_1753067645 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 11:14:06 +0800
Message-ID: <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
Date: Mon, 21 Jul 2025 11:14:02 +0800
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
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Barry,

On 2025/7/21 09:02, Barry Song wrote:
> On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>

...

>>
>> ... high-order folios can cause side effects on embedded devices
>> like routers and IoT devices, which still have MiBs of memory (and I
>> believe this won't change due to their use cases) but they also use
>> Linux kernel for quite long time.  In short, I don't think enabling
>> large folios for those devices is very useful, let alone limiting
>> the minimum folio order for them (It would make the filesystem not
>> suitable any more for those users.  At least that is what I never
>> want to do).  And I believe this is different from the current LBS
>> support to match hardware characteristics or LBS atomic write
>> requirement.
> 
> Given the difficulty of allocating large folios, it's always a good
> idea to have order-0 as a fallback. While I agree with your point,
> I have a slightly different perspective — enabling large folios for
> those devices might be beneficial, but the maximum order should
> remain small. I'm referring to "small" large folios.

Yeah, agreed. Having a way to limit the maximum order for those small
devices (rather than disabling it completely) would be helpful.  At
least "small" large folios could still provide benefits when memory
pressure is light.

Thanks,
Gao Xiang

> 
> Still, even with those, allocation can be difficult — especially
> since so many other allocations (which aren't large folios) can cause
> fragmentation. So having order-0 as a fallback remains important.
> 
> It seems we're missing a mechanism to enable "small" large folios
> for files. For anon large folios, we do have sysfs knobs—though they
> don’t seem to be universally appreciated. :-)
> 
> Thanks
> Barry


