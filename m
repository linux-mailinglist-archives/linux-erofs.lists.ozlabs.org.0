Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B47639B16
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Nov 2022 14:35:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NKqNp6JWkz3c6k
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 00:35:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzbGU4xV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzbGU4xV;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NKqNj1VVMz2xBV
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Nov 2022 00:35:32 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 900ABB80AFE;
	Sun, 27 Nov 2022 13:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2F4C433D6;
	Sun, 27 Nov 2022 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669556125;
	bh=G4G6WX6djSr8V364KenjtdxlbWifLcMCgt7yqzLrGiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzbGU4xVeipL+oXAGmaJNxDh3A7bqCgcMCqh+dwgFT0KHf5hpINM6uOZtDenF9tQA
	 rLRGjSCr+biUsmgaTOJVcKWL6O4rW48P6ZXVzUs0DG9A1N/VfjD2d8hbna1k5dhYjn
	 0SIUqSP6mYct3xIpVs0hggzcpdfv6mSFDFIJ+T4+Hib3BcQ3ccXd1Imrrqgp4kRhU3
	 jiKBxPojrIBQwWJTF+M4nYElSr64/9vZa373dOY6BEJ933rDg7EAvXu3RZcjHQdVMD
	 hlyL+UpHkAWoa09pwjqLot1DSc2VgpUFV80GkhIZwzdDZaHE9bHIfvPqkNBBJ8qL6Q
	 jVoWgjWQuc37w==
Date: Sun, 27 Nov 2022 21:35:19 +0800
From: Gao Xiang <xiang@kernel.org>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: enable large folio in device-based mode
Message-ID: <Y4Nnl9YXSjDbN8xs@debian>
Mail-Followup-To: JeffleXu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com,
	linux-kernel@vger.kernel.org
References: <20221110074023.8059-1-jefflexu@linux.alibaba.com>
 <315099ec-b6c3-1aa0-c83e-86f6074bd674@linux.alibaba.com>
 <Y23taS26HMwhkdhN@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y23taS26HMwhkdhN@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 11, 2022 at 02:36:25PM +0800, Gao Xiang wrote:
> Hi,
> 
> On Thu, Nov 10, 2022 at 03:59:14PM +0800, JeffleXu wrote:
> > 
> > 
> > On 11/10/22 3:40 PM, Jingbo Xu wrote:
> > > Enable large folio in device-based mode. Then the radahead routine will
> > > pass down large folio containing multiple pages.
> > > 
> > > Enable this feature for non-compressed format for now, until the
> > > compression part supports large folio later.
> > > 
> > > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > > ---
> > > I have tested it under workload of Linux compiling. I know it's not a
> > > perfect workload testing this feature, because large folio is less
> > > likely hit in this case since source files are generally small. But I
> > > indeed observed large folios (e.g. 16 pages) by peeking
> > > readahead_count(rac) in erofs_readahead().
> > 
> > Sorry, readahead_count(rac) returns the whole number of pages inside the
> > rac, which can not prove large folio passed in.
> > 
> > I retired later and observed large folio (e.g. with order 2) by peeking
> > folio_order(ctx->cur_folio) inside iomap_readahead_iter()
> 
> I will test it as well after I send out all bug fixes for this cycle.

I've updated the subject and commit message as:
"
erofs: enable large folios for iomap mode
Enable large folios for iomap mode.  Then the readahead routine will
pass down large folios containing multiple pages.

Let's enable this for non-compressed format for now, until the
compression part supports large folios later.
"

Thanks,
Gao Xiang

