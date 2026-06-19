Return-Path: <linux-erofs+bounces-3677-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FpJZMiSONGrcbAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3677-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 02:32:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD46A33DA
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 02:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=AwCo05cI;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3677-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3677-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghJTB6YZwz2yrX;
	Fri, 19 Jun 2026 10:32:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781829150;
	cv=none; b=GN2YaJ0msNam1ReUX4CXzs3zFNcsx6xcdsMLPIMtuPmp8mMKLtqNYx13Nbz60RekZ/ZzXPBjGewuZDbnw4tEPGHwY1N+tJZHLn5++yDqI8FLCHi1bcP9qJL5pP1vC+pUYfTS3AsrEVOweS6PQyut5raiASh8pi/SN3aIIVTC0d08DPwq3nmJhYnQFi5lPIIX/iD9kTAKFCKinpbyVyyG1wd817BenCm+LJ6yX3EQJEdC6Hkxlon1Shj4rYofBxB4Ck11HO0l3umYJ7klyUX33k9+2Thy2JM8ZuWEl4/ybgNhLbNA1dZ7uFqPBLDk/zH/puOzrlLhtj505RWbqqxE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781829150; c=relaxed/relaxed;
	bh=W7eCEKpqf5JF6XjeNMziwkoCKNiPryZaEvvADeFGevQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO1SykuSmowCr0ASxprrVmPCU+SVJWqHjrQlZyYHryQaJbtpjZ1FIh/1OsvqdB1KVwu2SEnC6p31M7+S4mmZ5+S0M/9XI/EMNNiuVDV24blfEMj8RM8oUekoT6/NOpHUhURVlHHHIUyFsU4u44K6ZLekPknSQ1Cuw2dcmZFgzAMyGGjx7rnUFHLynoCydHDjZ2Xdt1XPF/fIXj32ctZT9g6xVNxbs6Evvu75laLP5TLmvDTC7GkhSnUtcyP1uLexIhyq8e0pkt5PL8Otp5rH8R8290JOixm0NhB6IhuQ/5TIQNCa07eao25WPiBdDoh/6N+INyOEZpnLivH7KXkIOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AwCo05cI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghJT829Lsz2ySW
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 10:32:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781829142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=W7eCEKpqf5JF6XjeNMziwkoCKNiPryZaEvvADeFGevQ=;
	b=AwCo05cIQBqdI3FyAmknsHvhMl0PEtO06DKRxW76xX4PHWm5N5LTOroXiQyPwLcMwXamPcdHffUcZvyNmZgoAizIgY8IItY6hjYkd+nrxUIu+rE5Fo6eJsazQQ2BvwuwK7vT/UpAlAIXjDUmJGrIw5rPhK0GwfAF3ZYrZkKm3Eo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5847GC_1781829140;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5847GC_1781829140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 08:32:21 +0800
Message-ID: <20a4402b-6084-4d78-8674-66020db538a6@linux.alibaba.com>
Date: Fri, 19 Jun 2026 08:32:19 +0800
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
Subject: Re: [PATCH RFC 0/2] RFC: erofs: memory-backed mount for
 non-page-aligned ranges
To: aruiz@redhat.com, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Brian Masney <bmasney@redhat.com>, Eric Curtin <ericcurtin17@gmail.com>
References: <20260618-erofs-memback-v1-0-5aa7006a241a@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260618-erofs-memback-v1-0-5aa7006a241a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3677-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aruiz@redhat.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-kernel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:javierm@redhat.com,m:bmasney@redhat.com,m:ericcurtin17@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECCD46A33DA

Hi Alberto,

On 2026/6/19 00:13, Alberto Ruiz via B4 Relay wrote:
> This series adds a memory-backed ("memback") mode to EROFS that
> allows mounting an EROFS image directly from a kernel memory region
> without going through the block layer.
> 
> I am sending this as an RFC to get EROFS maintainer feedback on
> this approach before building the full initramfs series on top of
> it.  The memback mode may also be useful for other use cases beyond

First, thanks for your interest and efforts. On my side I'm glad
if EROFS can be used for the initramfs use case (for many years!).

> initramfs where EROFS images need to be served directly from
> memory, though it may need further hardening for more general use
> cases.
> 
> Previous review feedback on the initramfs patches raised concerns
> about the block layer dependency — this series addresses that by

Could you have a pointer where "concerns about the block layer
dependency" comes from? I don't notice that on the mailing list.

> providing a direct memory-backed path.  It also adds support for

But I think EROFS subsystem can not decide itself if we could
land this functionality or not, in any case we should have a
discussion with VFS/MM folks first to know if the rough
direction is acceptable or not.  And we also need to know
what's the concerns before we draft a version.

There may have some barriers on my side to land this feature:

  - erofs_memback_set_pending() can be used to set an arbitary
    kernel virt address.  I don't think it's a good direction
    to be honest, for example, previously cramfs gets some
    arbitary address using mtd_point() and implement XIP feature
    but I think it's quite outdated.

    Yes, I've seen erofs_memback_set_pending() can only be used
    for specific cases since it has __init annotation, but it
    also limits _the other potential use cases_.

  - currently modern memory backends (memory devices like PMEM
    and CXL) all use Linux DAX infrastructure, which means we
    shouldn't bypass the DAX infrastructure to operate arbitary
    memory address directly.

That is my own opinion at least, but if MM/FS folks think EROFS
can work on arbitary kernel virt address instead, I'm fine, but
I think it's highly impossible.

So at least on this part, I wonder if we should enhance ramdax
(drivers/nvdimm/ramdax.c) to support initramfs use cases and
make EROFS to use ramdax + DAX infrastrure to mount initramfs
instead.

> non-page-aligned memory ranges, which is the common case for
> initramfs images packed at arbitrary cpio boundaries.  Supporting

That is another issue I would like to discuss:

If EROFS filesystem data is page aligned, we can just use the
initramfs memory directly and so that no page cache is needed.

And in that cases, no double cache anymore (see "ramfs and
ramdisk" section in https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt).

> non-page-aligned ranges is essential for true zero-copy access —

I guess that is not true: I've looked the code, basically the
code uses the page cache (double caching), and the unaligned
data will be copied into page cache (aligned data) first.

Since mmap use cases need page aligned buffers, and in practice
of the linux kernel, it will be page cache or DAX.  So in order
to do that, unaligned initramfs needs do double caching and an
extra copy at least to fulfill the requirement.

> requiring page alignment would force a copy into an aligned buffer
> before the data can be used, defeating the purpose.

same as above.

Anyway, I wonder if we could avoid non-page-aligned initramfs so
that ramdax can be enhanced to be used directly.

> 
> The full initramfs integration (init/ changes) that wires up the
> EROFS initrd detection and layered mount is available for reference
> here[0]. It implements support for interleaved cpio and EROFS
> layers, it supports cpio CPU microcode update prefix, and uses
> overlayfs+tmpfs for write support.

If that's why EROFS is unaligned, and we just add some padding
between cpio and erofs image (I think the padding is small than
4k)? or can cpio CPU microcode update prefix placed after the
erofs image?

> 
> This series was developed with the assistance of Claude Opus 4.6.
> All patches carry an Assisted-by tag. I am providing the kunit
> testing and I have tested this change against the initramfs series
> to boot an EROFS initramfs. I welcome feedback on the approach and
> implementation.

Yes, the generated code can work but IMHO it doesn't mean it's well
suitable for upstream...

It's just my own humble opinion, but I expect VFS/MM folks could
have similar thoughts.  However, I'm also interested if EROFS can
be used for initramfs, as long as we have a proper way to implement
that.

Thanks,
Gao Xiang

> 
> Patch 1 adds the core memback implementation.
> Patch 2 adds a KUnit test that mounts a compressed EROFS image at a
> non-page-aligned offset and verifies decompressed file contents.
> 
> [0] https://github.com/aruiz/linux/tree/wip/erofs-initramfs-memback
> 
> Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
> ---
> Alberto Ruiz (2):
>        erofs: add memory-backed mode for non-page-aligned mount
>        erofs: add KUnit test for memory-backed compressed mount
> 
>   fs/erofs/Kconfig        |  11 ++++
>   fs/erofs/Makefile       |   2 +
>   fs/erofs/data.c         |  33 +++++++++-
>   fs/erofs/internal.h     |  53 +++++++++++----
>   fs/erofs/memback.c      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/memback_test.c | 151 ++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c        |  38 +++++++++--
>   fs/erofs/zdata.c        |  16 +++--
>   8 files changed, 447 insertions(+), 26 deletions(-)
> ---
> base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
> change-id: 20260617-erofs-memback-0ae2448ba2cc
> 
> Best regards,
> --
> Alberto Ruiz <aruiz@redhat.com>
> 


