Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84B14161EA
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 17:19:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFf3N54ngz2ynd
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Sep 2021 01:19:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vb34QMoh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Vb34QMoh; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFf3K5N5Dz2xtM
 for <linux-erofs@lists.ozlabs.org>; Fri, 24 Sep 2021 01:19:41 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3162B60F12;
 Thu, 23 Sep 2021 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632410378;
 bh=bxMbjbmYYlx+gwAQqIXMFemqzoYdMwKRAZ+eUGI26/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vb34QMohIOyVon1B7SCV4j1uJ+VDUB7CR0IPaLvORzuFVP5Z64hqaug+KkQsYH79V
 kNEqRAQaSKTOxZZ7hHjEvrFlD+ciVlgzN4NUeWKSv38bjWgoZTRXZTxP84PMEMSIVU
 /wu0Q+Jd0qzwuHbzzemg5N8JocPZtOnhPPpn9hn/mt+y52w7tWX6YKu6kHtgB6HrBH
 sN9EdwLGy/DlO/M3LiipYqdCWRVUnW5WukRRySaKRk5Oi3pmWQHXOwUrofOwh9dtp0
 uHDSsYqUnArWhDprfSBS+JxNZfBNjH8z4MYrAURvdUGK9HRGtsBdYCWIJSKSnKSkXL
 G+HNOwLRMTg5Q==
Date: Thu, 23 Sep 2021 23:19:20 +0800
From: Gao Xiang <xiang@kernel.org>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: fix misbehavior of unsupported chunk format check
Message-ID: <20210923151919.GC1852@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Chao Yu <chao@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
 <926fb1a9-174e-26de-c9ed-70aa0a01d394@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <926fb1a9-174e-26de-c9ed-70aa0a01d394@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 23, 2021 at 11:09:25PM +0800, Chao Yu wrote:
> On 2021/9/22 17:51, Gao Xiang wrote:
> > Unsupported chunk format should be checked with
> > "if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"
> > 
> > Found when checking with 4k-byte blockmap (although currently mkfs
> 
> That means for 4k-byte blockmap, chunkformat should be zero, right?

Yeah, correct. It's a regression of 4kb chunk blockmap..

> 
> > uses inode chunk indexes format by default.)
> > 
> > Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> > Cc: Liu Bo <bo.liu@linux.alibaba.com>
> > Cc: Chao Yu <chao@kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
