Return-Path: <linux-erofs+bounces-55-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B638EA5F3CB
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Mar 2025 13:07:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZD5pK4V2xz300g;
	Thu, 13 Mar 2025 23:07:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741867625;
	cv=none; b=eFj1Zv5O8gTpVqqr6Ci2vbM2lml4ZxKhyfy5vmuqYIwV44PiHcXMcWHgAgVWFCGlUtdmZoP+cocs3BzJ9XOjCPWW96lY0Qqwpa0HPPIGZbEr3rWfnW81RJO2PlEXL+QDMpjlFaqv1L+C3YLG1Qvii+yU3tkw7N7QFv6j0JlCXxtUKSlzgL6T6iVBYgqnnwzY4teqyWF2tFgtsSXNTa9NIIGWSKdDpN09v0e3jq1PfEve9CizeoPBih2qhhoOf0M36wGnK/xFD5HowhF8eKKvVfIvcjcej0QpR8wY+GSD1m98VZFadU0rxuNWZXvKJbcRnZT/yfmoi61nDIo3lG2tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741867625; c=relaxed/relaxed;
	bh=fGTu/tD3C5VfddmiImovRgHGnXtXO1RsQjx8429fGUQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LR/cHlK9HfzduDFIo1gMs5z9lRbDVXXp9mWeNSMuVeR33HP3k/vhYoVKqrSDabL8n7ghg7jzzQCgGWTxJoNqawX936HA6Y3oZd5pxJRlvfw/LckT3Ra3psoEb66z7vlRotD7p4729HKgISM0Unu0jxZ1kT2dSabd+L68wMbcAoTvsyyIpl5Btp7FPZvdpvx6MVHdpk+xIDj8gyyFU4YegvWuZyWtT3ufnFAAT63GbL8Dhx9Bp9lMgBnEkOmsaEC8XYRATi/O7pEl9gmRhAVm+W4/ZuC1lmaGbmn2wA3VD5p1tLBcWkc6YlYnrBANPtu0kAqc9I66xzRLGuOsqFRsEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jXBfePOu; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jXBfePOu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZD5pJ2ZP9z2xmZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Mar 2025 23:07:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC6785C5D6D;
	Thu, 13 Mar 2025 12:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B5AC4CEDD;
	Thu, 13 Mar 2025 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867621;
	bh=tPMv1e9p1LoBOgsBlCNb2KlLtLmYJbXlDQr2OnVcN4E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jXBfePOuOB7rhnTba5KejxcO7mreOmQZqV5TXLHLxCSfITjJvWSfzLvYJFLvHUQx6
	 u3D6H0sCrO2N10VzJixabZMog9fjADMf2jtK+IY6KH8es4rF0T0Ymt0IP5fV3cBM2E
	 BgRSYM67F3S1SoxMhsnuyC23O5y/++7xTVWlgEqeT8JWFvDw6vshQM5FvkNCLAvhuz
	 mJ4uuqnTIvfTMi2Y1SjLiQlGInm5yP7jE9GTcyUYLXA7DxIgh6ee20kY8vkPoXli2q
	 XlGAG05SfSKYF/cU/3mEbZBIcXE6F6lKoosaaReOtDbG/O5Z0BbmhLYKTJEZnEl/Pu
	 IM37RzMhuCe6A==
Message-ID: <695b5311-d0bb-422c-9a96-52cfcc72afb4@kernel.org>
Date: Thu, 13 Mar 2025 20:06:58 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] erofs: 48-bit layout support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 2025/3/10 17:54, Gao Xiang wrote:
> Hi folks,
> 
> The current 32-bit block addressing limits EROFS to a 16TiB maximum
> volume size with 4KiB blocks.  However, several new use cases now
> require larger capacity support:
>   - Massive datasets for model training to boost random sampling
>     performance for each epoch;
>   - Object storage clients using EROFS direct passthrough.
> 
> This extends core on-disk structures to support 48-bit block addressing,
> such as inodes, device slots, and inode chunks.
> 
> In addition, it introduces an mtime field to 32-byte compact inodes for
> basic timestamp support, as well as expands the superblock root NID to
> an 8-byte rootnid_8b for out-of-place update incremental builds.
> 
> In order to support larger images beyond 32-bit block addressing and
> efficient indexing of large compression units for compressed data, and
> to better support popular compression algorithms (mainly Zstd) that
> still lack native fixed-sized output compression support, introduce
> byte-oriented encoded extents, so that these compressors are allowed
> to retain their current methods.
> 
> Therefore, it speeds up Zstd image building a lot by using:
> Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
> Dataset: enwik9
> Build time Size Type Command Line
> 3m52.339s 266653696 FO -C524288 -zzstd,22
> 3m48.549s 266174464 FO -E48bit -C524288 -zzstd,22
> 0m12.821s 272134144 FI -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22
> 
> It has been stress-tested on my local setup for a while without any
> strange happens.

Cool, good work! For this serial,

Acked-by: Chao Yu <chao@kernel.org>

Hoping to grab continuous free slots to check the details, then we can
change it to rvb status before merge window. :)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (10):
>    erofs: get rid of erofs_map_blocks_flatmode()
>    erofs: simplify erofs_{read,fill}_inode()
>    erofs: add 48-bit block addressing on-disk support
>    erofs: implement 48-bit block addressing for unencoded inodes
>    erofs: support dot-omitted directories
>    erofs: initialize decompression early
>    erofs: add encoded extent on-disk definition
>    erofs: implement encoded extent metadata
>    erofs: support unaligned encoded data
>    erofs: enable 48-bit layout support
> 
>   fs/erofs/Kconfig             |  14 +--
>   fs/erofs/data.c              | 133 +++++++++++-------------
>   fs/erofs/decompressor.c      |   2 +-
>   fs/erofs/dir.c               |   7 +-
>   fs/erofs/erofs_fs.h          | 191 ++++++++++++++++-------------------
>   fs/erofs/inode.c             | 126 +++++++++++------------
>   fs/erofs/internal.h          |  30 +++---
>   fs/erofs/super.c             |  49 ++++-----
>   fs/erofs/sysfs.c             |   2 +
>   fs/erofs/zdata.c             |  96 +++++++++---------
>   fs/erofs/zmap.c              | 166 +++++++++++++++++++++++++-----
>   include/trace/events/erofs.h |   2 +-
>   12 files changed, 455 insertions(+), 363 deletions(-)
> 


