Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50001744FD
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:58:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvM05Tw0zDrCS
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:58:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=MFp1Q196; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvLv4SDlzDr3k
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:58:47 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4ABF9246AF;
 Sat, 29 Feb 2020 04:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582952324;
 bh=PbYe2sTXfJha/DRxbIuYOIqDKHr8Abe63putptB/wEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MFp1Q196S7jnpLpi+rVZAmxsux1nh7En1AqaIqZJi/S3eZbdrofMlr5S6+1O5sK2P
 z+rn7xmn4hp4LLqqir5IlQLxNgMmfPw5GsR0NFxraeH9ZlPiE8ZduUugtB9xRcIbpn
 aDwRgKMinMWnZlxJzcKagocgIF3mnEBi4Ce83shc=
Date: Fri, 28 Feb 2020 20:58:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [WIP] [PATCH v0.0-20200229 00/11] ez: LZMA fixed-sized output
 compression
Message-ID: <20200229045842.GA930@sol.localdomain>
References: <20200229045017.12424-1-hsiangkao.ref@aol.com>
 <20200229045017.12424-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229045017.12424-1-hsiangkao@aol.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Feb 29, 2020 at 12:50:06PM +0800, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> This is a WIP PREVIEW patchset, just for archiving to open
> source community only.
> 
> For now, it implements LZMA SDK-like GetOptimumFast approach
> and GetOptimum is still on schedule.
> 
> It's still buggy, lack of formal APIs and actively under
> development for a while...
> 
> Usage:
> $ ./run.sh
> $ ./a.out output.bin.lzma infile
> 
> It will compress the beginning as much as possible into
> 4k RAW LZMA block.

Why not just use liblzma?

Also, if you care enough about compression ratio to use LZMA instead of
Zstandard, why use only a 4 KB blocksize?

- Eric
