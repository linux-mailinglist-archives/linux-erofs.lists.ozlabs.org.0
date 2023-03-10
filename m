Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57D6B36BD
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 07:41:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXxK42dD8z3cd9
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 17:41:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LVN06iii;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LVN06iii;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXxK02SJfz3cB9
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 17:41:08 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5FC60918;
	Fri, 10 Mar 2023 06:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A726FC4339B;
	Fri, 10 Mar 2023 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678430463;
	bh=plBP9xtYXP2I+FupQ173CX+ZuDUo4RXoMY/5XknZJQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVN06iiidwL5e+tS5lMUOzHoPflOolCexueJbeifBRqTxOVAc1ikk+e5WEEAVddse
	 NWlgogJWIHUkh4t873sb53GbQPAvUTOrZaqCH3mHyhdnQXGd+SIzqpK/z1+Z7McwzY
	 uQ9y5eOp3aEOyaYM2rEVE56M1NT/xbofRJab7XHJNqTvnaiSjLgcOKzdiZAVCcxWNr
	 zTqEKotS4Tm68F0k88zAxe5Xy9mmd+OR7rQYbHOrwOTwIPcItGAVY8YlM0XC4ypdNU
	 nYvzdHvcSlPawucx8YqH6otrWQaz2DlDV0H7stE8XOhMaNc/9L3BCLdK/73wSOvpxy
	 OfPPWTFYBm+CA==
Date: Thu, 9 Mar 2023 22:41:01 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <ZArQ/WaBrw0LR56v@sol.localdomain>
References: <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310062738.69663-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310062738.69663-1-frank.li@vivo.com>
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
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, hsiangkao@linux.alibaba.com, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 10, 2023 at 02:27:38PM +0800, Yangtao Li wrote:
> > Please don't do this.  This makes the code compile down to a division, which is
> > far less efficient.  I've verified this by checking the assembly generated.
> 
> How much is the performance impact? So should the following be modified as shift operations as well?
> 
> fs/erofs/namei.c:92:    int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
> fs/erofs/zmap.c:252:    const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> fs/erofs/decompressor.c:14:#define LZ4_MAX_DISTANCE_PAGES       (DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
> fs/erofs/decompressor.c:56:                                     DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
> fs/erofs/decompressor.c:70:     unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
> fs/erofs/data.c:84:     nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> 

No, compilers can handle division by a power-of-2 constant just fine.  It's just
division by a non-constant that is inefficient.

- Eric
