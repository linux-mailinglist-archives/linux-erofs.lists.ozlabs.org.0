Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA157CDB3
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jul 2022 16:32:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LpZlQ24w3z3c6F
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 00:32:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c9xqL2rZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c9xqL2rZ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpZlM66Nqz2xk0
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 00:31:59 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AA2BA61FC5;
	Thu, 21 Jul 2022 14:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A3DC341C0;
	Thu, 21 Jul 2022 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658413917;
	bh=ffb3CPAAW0wEQHaCuTSKW7+RxX6RH1UHdDeIg1iGWPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c9xqL2rZLAxCpXupfcOdgt4gbk4iOreUjvDIluVSp1tWt7wyeujNNXUV1cMBXMs71
	 JUz+FSxnTEIiTdHZF84pQp5X2GG72FhZUTVTMfhqNZ1KogaFiLzTe91ztwpwz/GOeX
	 S60AUY6T7FI3kLmRkJ92x7uJsj8IptKcSrcwDPUjw8EkyLpZFPCOGFoHNM+wmHLy1E
	 w2dr6L3HZNnDWcgbql+O0fhao/C4BShHkeX6Az9IxlVQLq0kFCn+KxrRoXEk40lwRy
	 UNWSEtDQ+3sC4tnKW+IQAu2646qCW/7dfxakWQhxqZxwbRxd1e+rTfhdZz/+7vpHV6
	 RO5GzVcRqzRcg==
Message-ID: <3801a538-f059-2b62-6dbb-cbe67478371b@kernel.org>
Date: Thu, 21 Jul 2022 22:31:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/16] erofs: prepare for folios, deduplication and
 kill PG_error
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/7/15 23:41, Gao Xiang wrote:
> Hi folks,
> 
> I've been doing this for almost 2 months, the main point of this is
> to support large folios and rolling hash deduplication for compressed
> data.
> 
> This patchset is as a start of this work targeting for the next 5.20,
> it introduces a flexable range representation for (de)compressed buffers
> instead of too relying on page(s) directly themselves, so large folios
> can laterly base on this work.  Also, this patchset gets rid of all
> PG_error flags in the decompression code. It's a cleanup as a result
> as well.
> 
> In addition, this patchset kicks off rolling hash deduplication for
> compressed data by introducing fully-referenced multi-reference
> pclusters first instead of reporting fs corruption if one pcluster
> is introduced by several differnt extents.  The full implementation
> is expected to be finished in the merge window after the next.  One
> of my colleagues is actively working on the userspace part of this
> feature.
> 
> However, it's still easy to verify fully-referenced multi-reference
> pcluster by constructing some image by hand (see attachment):
> 
> Dataset: 300M
> seq-read (data-deduplicated, read_ahead_kb 8192): 1095MiB/s
> seq-read (data-deduplicated, read_ahead_kb 4096): 771MiB/s
> seq-read (data-deduplicated, read_ahead_kb 512):  577MiB/s
> seq-read (vanilla, read_ahead_kb 8192):           364MiB/s
> 
> Finally, this patchset survives ro-fsstress on my side.

For this patchset,

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> Changes since v1:
>   - rename left pagevec words to bvpage (Yue Hu);
> 
> Gao Xiang (16):
>    erofs: get rid of unneeded `inode', `map' and `sb'
>    erofs: clean up z_erofs_collector_begin()
>    erofs: introduce `z_erofs_parse_out_bvecs()'
>    erofs: introduce bufvec to store decompressed buffers
>    erofs: drop the old pagevec approach
>    erofs: introduce `z_erofs_parse_in_bvecs'
>    erofs: switch compressed_pages[] to bufvec
>    erofs: rework online page handling
>    erofs: get rid of `enum z_erofs_page_type'
>    erofs: clean up `enum z_erofs_collectmode'
>    erofs: get rid of `z_pagemap_global'
>    erofs: introduce struct z_erofs_decompress_backend
>    erofs: try to leave (de)compressed_pages on stack if possible
>    erofs: introduce z_erofs_do_decompressed_bvec()
>    erofs: record the longest decompressed size in this round
>    erofs: introduce multi-reference pclusters (fully-referenced)
> 
>   fs/erofs/compress.h     |   2 +-
>   fs/erofs/decompressor.c |   2 +-
>   fs/erofs/zdata.c        | 785 +++++++++++++++++++++++-----------------
>   fs/erofs/zdata.h        | 119 +++---
>   fs/erofs/zpvec.h        | 159 --------
>   5 files changed, 496 insertions(+), 571 deletions(-)
>   delete mode 100644 fs/erofs/zpvec.h
> 
