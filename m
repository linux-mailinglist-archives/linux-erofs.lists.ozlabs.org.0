Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F17685F5
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 16:17:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q+KeLsHO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDNjw5NqKz2yF0
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 00:17:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q+KeLsHO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDNjr0rkXz2y1k
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 00:17:20 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3D560C48;
	Sun, 30 Jul 2023 14:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3813C433C8;
	Sun, 30 Jul 2023 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690726637;
	bh=/SgtMSC4gFWZmhxWNtgshquG2Pqs3414Skm+heLmjis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+KeLsHOXV4yh/Gebrk5sQoIu4B3MB+9eRfzf7/9Cuvk8b4e23bi0eeT+9caELcfx
	 4Nz81yP9OMGyU0P8w4LvKZx6s6ZNfKrR/CaItNQ7n+HGIeWmP3otxeLJFuJHVxZuFj
	 h5UtRmXz/Co1bmvj1IO1CDSbNP7h757xKBWwJvYUArpbJSPuoQ87CdaEp/5aAZld+5
	 C520t9rNHJWmaAUBgrpsRpXTXX6XDFROCiffBGDk3qJx2cUV/juVSk6SytscekXOEq
	 /XoRzuzX7nM/5LqaoE65l8bdjTOHUzbwLATxS8NctwhPctQ0jJulYVDcmjO49xtes2
	 uHRbd2ALXJxKA==
Message-ID: <9735ac90-d5bd-2cfa-2ac2-d381faa18747@kernel.org>
Date: Sun, 30 Jul 2023 22:17:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] erofs: DEFLATE compression support
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230730141245.6691-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230730141245.6691-1-hsiangkao@linux.alibaba.com>
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

On 2023/7/30 22:12, Gao Xiang wrote:
> Add DEFLATE compression as the 3rd supported algorithm.
> 
> DEFLATE is a popular generic-purpose compression algorithm for quite
> long time (many advanced formats like gzip, zlib, zip, png are all
> based on that) as Apple documentation written "If you require
> interoperability with non-Apple devices, use COMPRESSION_ZLIB. [1]".
> 
> Due to its popularity, there are several hardware on-market DEFLATE
> accelerators, such as (s390) DFLTCC, (Intel) IAA/QAT, (HiSilicon) ZIP
> accelerator, etc.  In addition, there are also several high-performence
> IP cores and even open-source FPGA approches available for DEFLATE.
> Therefore, it's useful to support DEFLATE compression in order to find
> a way to utilize these accelerators for asynchronous I/Os and get
> benefits from these later.
> 
> Besides, it's a good choice to trade off between compression ratios
> and performance compared to LZ4 and LZMA.  The DEFLATE core format is
> simple as well as easy to understand, therefore the code size of its
> decompressor is small even for the bootloader use cases.  The runtime
> memory consumption is quite limited too (e.g. 32K + ~7K for each zlib
> stream).  As usual, EROFS ourperforms similar approaches too.
> 
> Alternatively, DEFLATE could still be used for some specific files
> since EROFS supports multiple compression algorithms in one image.
> 
> [1] https://developer.apple.com/documentation/compression/compression_algorithm
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
