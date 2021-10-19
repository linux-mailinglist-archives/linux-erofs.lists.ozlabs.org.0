Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF74336A2
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 15:04:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYYq60HPXz302C
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Oct 2021 00:04:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bCpjhUh1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bCpjhUh1; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYYq36wgNz2xrl
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Oct 2021 00:04:15 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFD0C61372;
 Tue, 19 Oct 2021 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634648653;
 bh=y4bwIP99bgP7Ml+JufuaLWJMSFCpFb2IgDQsVZrKASk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bCpjhUh1VcXA9BupCXm2ZZIsAfA8v60rDCJCENAgyUd5lCl3+Xh1Qq5gGs02IAK4f
 HxvuxGpmjCgp6U260CCqlBEdvmMQu0PYJ71NGSLMwjx4ozStUNNQ9aTLCiFohPX8fc
 yLMbN8r33Bb2WrtgQgmkXvZJ1c7Aav2zZr+6JS/OdLRDgf8p+xnX0bFMOYuZrFXt+3
 G25b1BglnnHmAu/ZOGUXw2sWnUd0vpIJ7gYzyNpN/aUnLaZtRD9oU5FuVjGCAFhX6x
 Tre/X9bbk+IWoVgQo+i5milRvsGdiEYeyAqoW5Kg9cqhW6dEgvjFVMCQk5SqRX8AAO
 wPMvlSz9YaD1A==
Message-ID: <e920e58d-d003-32cb-2910-64eea15beb58@kernel.org>
Date: Tue, 19 Oct 2021 21:04:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 7/7] erofs: lzma compression support
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
 <20211010213145.17462-8-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211010213145.17462-8-xiang@kernel.org>
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
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Lasse Collin <lasse.collin@tukaani.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/11 5:31, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Add MicroLZMA support in order to maximize compression ratios for
> specific scenarios. For example, it's useful for low-end embedded
> boards and as a secondary algorithm in a file for specific access
> patterns.
> 
> MicroLZMA is a new container format for raw LZMA1, which was created
> by Lasse Collin aiming to minimize old LZMA headers and get rid of
> unnecessary EOPM (end of payload marker) as well as to enable
> fixed-sized output compression, especially for 4KiB pclusters.
> 
> Similar to LZ4, inplace I/O approach is used to minimize runtime
> memory footprint when dealing with I/O. Overlapped decompression is
> handled with 1) bounced buffer for data under processing or 2) extra
> short-lived pages from the on-stack pagepool which will be shared in
> the same read request (128KiB for example).
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
