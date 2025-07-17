Return-Path: <linux-erofs+bounces-653-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F99B0834B
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 05:18:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjJ6F6Pg0z2yDk;
	Thu, 17 Jul 2025 13:18:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752722309;
	cv=none; b=OmLxOcv/7s8IQNrx5PdK8C7InKwU6Ho6moHT5RLZKq8+ZgoRX7ZejEQy5Po2qXnPKLA3EqIs68EjNNDmn8BYL78Ma0WQO1AY7h8ex76llAsSREjvcNUOSGlaEquf8dy5AHBo6J0sIflEA7TPhZ8hizepK7LcZk7mXRHsnzBUiCY+AMT0wjjyX6373XgeSW/MakAZtIph8kd7rSY6IyIKt+1yF6Mcjrp3pZVPMmnQqy8nA9waOOwHzfhkCcKn2u+JWN458DJSuzjJUmmbMBOAH0n1vkV1GhNqZB64FBOL7D6zDZSeuPGQWNL86zTN3D7zlRS1//+QpYywx69YYo+8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752722309; c=relaxed/relaxed;
	bh=4gUaF7R4/EBDJfRjJRTdp0icwbrWb7f2nyKt3jMgey4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciJcTq0gfQo0Cq8Y7ZKJZykzf11Uj5M2abE8nSgmglU7gkKimc9acqFm/LbArePBApM9F9HgtLbGKsRkHYZ+rgOFjFqDuI3ZyqDIBcUmgZgTwO+VbY0MhbPRavL/HKXtWa1tq3ukOILKdsNOV2cf5ngd0VFi7nsNa7N15thlEue466W5MBwcrDmSMlOXl3K9VOpXltTFmb/WzOXn9RjP5W8PESJ11amYP8ClgSItSzBNcKdvosW0XpPGLF1XDl6Uu87AWavw+bkaVNWIKxrlsAL+tMA2q9mETeXYZW5F8ByWFEnr25No6yfop0ibx5OTysAUwfu0iooYA65to82U5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X92YK68j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X92YK68j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjJ6C5h6qz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 13:18:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752722302; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4gUaF7R4/EBDJfRjJRTdp0icwbrWb7f2nyKt3jMgey4=;
	b=X92YK68jtvdYunHTr7lIxmXTsR/Wm8YdAzx6PuAmbBPOkG1SWS4NxizO6dYhKWNLI4ih4NQjX0TE9j+/HtD9TYvJ694FmwAOq8jv8FSHl4SbK54zInn0pIZHAyBmvySAgaR1E9yPTUl00mPG06b/77lukpCLuadCiSVJnvUEY4M=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6YBs9_1752722299 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 11:18:20 +0800
Message-ID: <51c92913-6176-4516-8b14-bd12e2a85697@linux.alibaba.com>
Date: Thu, 17 Jul 2025 11:18:18 +0800
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
To: Eric Biggers <ebiggers@kernel.org>,
 Phillip Lougher <phillip@squashfs.org.uk>
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
 linux-cifs@vger.kernel.org
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>
 <20250717024903.GA1288@sol>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717024903.GA1288@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/17 10:49, Eric Biggers wrote:
> On Wed, Jul 16, 2025 at 11:37:28PM +0100, Phillip Lougher wrote:

...

> buffer.  I suspect that vmap() (or vm_map_ram() which is what f2fs uses)
> is actually more efficient than these streaming APIs, since it avoids
> the internal copy.  But it would need to be measured.

Of course vm_map_ram() (that is what erofs relies on first for
decompression in tree since 2018, then the f2fs one) will be
efficient for decompression and avoid polluting unnecessary
caching (considering typical PIPT or VIPT.)

Especially for large compressed extents such as 1MiB, another
memcpy() will cause much extra overhead over lz4.

But as for gzip, xz and zstd, they just implement internal lz77
dictionaries then memcpy for streaming APIs.  Since those
algorithms are relatively slow (for example Zstd still relies
on Huffman and FSE), I don't think it causes much difference
to avoid memcpy() in the whole I/O path (because Huffman tree
and FSE table are already slow), but lz4 matters.

Thanks,
Gao Xiang

