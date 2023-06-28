Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D07416B5
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 18:47:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fBygq+Oh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrnYg2Lssz30Px
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jun 2023 02:47:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrnYV2WNBz30K1
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jun 2023 02:47:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3p/6gRPbT1vLbxvPSCsO+AS87133UTz2Te2olPWVMi0=; b=fBygq+OhZHpmm+FqYPB0SYYJxs
	dkbSjX05mOg23yGibUfOMg7pvQ3le6IenSufrhalSwYSBW71vyRKtYLwC8vlc8cWL79BMLCHOsjj8
	5xkOKENSvOAR3j6C/cc11U3c8oDVlC84kqFkuSlN/rcCeX5kTlogHb9o1DA0gjBmyWPOIp6yOdsud
	AR8ksLyJ+cIp0crVLcb1X5U3Kg8B2PfSe8ftdn/x4qr8hWVdMdboCnweNPv9nnlJolQBZXHi8yhE5
	kgkgLc3gigu0XQxdPJOmT9Hl8kqZ42JwqSbmHd1AXDoXEpg9KetuWWyf7yjezUdlhkFnxsfhesijf
	SiFgptQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qEYJO-00407Q-O0; Wed, 28 Jun 2023 16:46:34 +0000
Date: Wed, 28 Jun 2023 17:46:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <ZJxj6odz49iB5Mmm@casper.infradead.org>
References: <20230628093500.68779-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, brauner@kernel.org, linux-raid@vger.kernel.org, djwong@kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, song@kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
> Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> to simplify code, which replace (queue_logical_block_size(q) - 1)
> and (bdev_logical_block_size(bdev) - 1).

The thing is that I know what queue_logical_block_size - 1 does.
That's the low bits.  _Which_ bits are queue_logical_block_mask?
The high bits or the low bits?  And before you say "It's obviously",
we have both ways round in the kernel today.

I am not in favour of this change.  I might be in favour of bool
queue_logical_block_aligned(q, x), but even then it doesn't seem worth
the bits.
