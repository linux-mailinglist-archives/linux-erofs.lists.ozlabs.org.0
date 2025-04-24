Return-Path: <linux-erofs+bounces-219-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E69EA99CF1
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 02:27:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjcHm3FL7z30Ss;
	Thu, 24 Apr 2025 10:27:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745454452;
	cv=none; b=aUkzAnxrnYYkby03QGmLO1dBteA2S/jxN0d5yd/X71nUjLVTZVJColEloOow6ChXeNwZwhr8iZ9B8N68pEqvy5X9r5gi+0gUIERmC8nWux9AamtX+w+rbhXMUE31crvEPEAfxD5cNymcKEwx6ZJZlCA7sASij55kTl50/HGDboqtuOCs8LlTGp2LUDn3xH/11ivOysJAZk48P4QwdH2YEi+TM/yfhsgb1PR7AnoUI0CN12C2sFNS+TkkWBwEJ5Ui9RhCDhJD6JP5xroId5idQU7LaJ8AQ+MXqrg0Jjv6xYIH3aKJO5FBIQuNMOuIj3tiUmgWBe4ToL2S55VtHn4nHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745454452; c=relaxed/relaxed;
	bh=1XVgVxTPwDvsf5cZrwVE4YSJqtDOBFrf4HgGRuDxwyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EdS4/cfWUJOzSoww5Z48x9IEdrgRcJ4dqAaEprU+e9bQr20yxGslVBl9MrAvLUoP/rVeoGtaHMAk4s5mNRgUWVzHGGJ7NXFXNyKv/+DluSEM2aCU7rQcM7MlenQs7oTKq8HeT0wgSuK7y7Dkr4i9laYEdAuT3K2HnUjwChYGHMbZwJRsL9fcfUfKciWM1R0HLRNHrPi1znZyqunkHm+Q9zPJgdvrIFrvgcWRGHMiFjdASkx5kqiyaenYcen9awb+pSE3ovXPD0w7PEHJxAzPVMynER2EU1n36ralya5vYagQq7CzJ42LmoyjZcMDVZOI6h73L5dDRSezxAo0+o8t1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fw8nhehN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fw8nhehN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjcHk3sPVz30HB
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 10:27:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745454444; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1XVgVxTPwDvsf5cZrwVE4YSJqtDOBFrf4HgGRuDxwyA=;
	b=Fw8nhehN38ZuUf4foBi6rnb8E/KbBE4/w/Ci647TujjrbkJnbwSJv3L7gZJXBxkZA8GcNgfdKHRLCE9SejhGTkL+7TYRjR2tG0y27RPLjWvTYyYLpnuh1fP3sbeqEZzRVIlxIXN3fPo0u7JgoFSZyRthrlCqSvESBDCrsUJw3g0=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WXw3tRt_1745454441 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 08:27:22 +0800
Message-ID: <8beeddff-816d-40ad-ae8b-a7c40748a59c@linux.alibaba.com>
Date: Thu, 24 Apr 2025 08:27:21 +0800
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
Subject: Re: [question] Status of dictionary preload compression?
To: Simon Hosie <sh1efs@xn--tkuka-m3a3v.nz>,
 Linux Erofs <linux-erofs@lists.ozlabs.org>
References: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Simon,

On 2025/4/24 03:24, Simon Hosie wrote:
> I've struggled to determine if this is already a feature or in development or not (possibly because of overloading of the term "dictionary"), so I apologise in advance if the following brief is redundant:
> 
> Compressors like LZ4, zstd, and even gzip talk about "dictionary compression" meaning to pre-load the history window of the compressor and decompressor, before the file is processed, with pre-arranged patterns; so that back references can be made for text the first time it appears in the file, rather than having to build up that window from an empty set at the beginning of the file by encoding everything as literals.
> 
> This can lead to an improvement in compression ratio.
> 
> It's generally only useful for small files because in a larger file the back-reference widow is established early and remains full of reference material for the rest of the file; but this should also benefit block-based compression which faces a loss of history at every entry point.
> 
> So that's what I'm talking about; and my question, simply, is is this is a feature (or a planned feature) of erofs?  Something involving storing a set of uncompressed dictionary preload chunks within the filesystem which are then used as the starting dictionary when compressing and decompressing the small chunks of each file?
> 
> In my imagination such a filesystem might provide a palette of uncompressed, and page-aligned, dictionaries and each file (or each cluster?) would give an index to the entry which it will use.  Typically that choice might be implied by the file type, but sometimes files can have different dispositions as you seek through them, or a .txt file may contain English or Chinese or ASCII art, each demanding different dictionaries.  Making the right choice is an external optimisation problem.

Thanks for your interest.

I know the dictionary compression (and the benefit for small
compression units as you said 4KiB compression) and it's on
our TODO list for years.

Actually I made an erofs-utils dictionary compresion demo 4
years ago (but EROFS doesn't implement compression deduplication
at that time):
https://github.com/erofs/erofs-utils/tree/experimental-dictdemo

The discussion part of this topic is the dictionary granularity:
  1) per-filesystem ?  I think it's almost useless, but it
                       has least extra dictionary I/O.
  2) per-inode?
  3) per-(sub)inode?

Since EROFS also supports compressed data deduplication (which
means a pcluster can be used for different parts of an inode or
different inodes), it makes the design for dictionary generation
(since some uncompressed data can be deduplicated) and selection
harder.

If you have more ideas about the dictionary granularity and
the whole process, I'm very interested in hearing more.

Thanks,
Gao Xiang


