Return-Path: <linux-erofs+bounces-1682-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F364CF3FC5
	for <lists+linux-erofs@lfdr.de>; Mon, 05 Jan 2026 14:57:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlG7l4f77z2xqk;
	Tue, 06 Jan 2026 00:57:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767621427;
	cv=none; b=dtOuQcMjKH9T7lO9TsNsbabgUuiwayMg3t1p8lmdKXXm4oMWtf1c94GJgbHGNIHuBrJn0sCcnXggoV4Q1pG3O4nq7ttuzfZMIfuMtXBrkqZ/Do4Oq1uhtgs+5yat2K21TyaxUBeGi3Sl6LmgCt8Qjyl33E8gWknopvU5JdCb1qSR0n5tNLvD2zTvNrXPDIXpc4asNbs8R36lGMxCmFBuUQ8FghFKFBm2btfcbIcttMJo9DvtTdeI9XhvhlEKkk/nXNb0jBoJlXyH8uOmTASqhbWNF2MfRf3S9nnJ8/epYoqmXmnsAQTBCy3Trl+SuLXTVJ8oNS/OzjK0ufZegStbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767621427; c=relaxed/relaxed;
	bh=oUKfjr+HZsGqa9M/2SRDiMxuXYEcc2N94w03h4x5jlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=err+pyKGiZ/7dGxHeoB6pvtvmoxzXc3+TaBVGqLcEtgtGSz76RrDMf0KmA7TrVij97B097ArhTU65ZHOMpKgYIZdN4gGUikHixJthmgIddT/iLDogtjQkAXomkHZpoudZt/7ofcBPiGlIgj3LfqRglSsjbMdaL8ZYJBmjdcA23908chcKV+D7cqjrDhu6sM3Vg7wkF+zO8VUBle2q/TrNMqyqw1ObSneXKGdkr7mpADd7/TRN9uJqiUq7OvQrSRAkRFXQVr9qfTr51R7AKFzZJSD+RMxBFiq3TBt4hq6wPVEbOc1zZpdzWaiLerHXflPP3lIpKCh1dD3gjd3MmFYnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NSv2eP/K; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NSv2eP/K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlG7j4s4jz2xGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 06 Jan 2026 00:57:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CA7D60010;
	Mon,  5 Jan 2026 13:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB79C116D0;
	Mon,  5 Jan 2026 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767621391;
	bh=exf/ch0MIW7+QupHXcxhIWfeHbtq+6PKpQdBxOEUCvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSv2eP/K6FmZx7gH9HYHTTslJS5KltgSZCPtDXLo/ScMY7RNyD5w7v7b3KBSdPWWW
	 e+btA5pYqNmFlJkBUOQOlTb3Fixa0xcHfgewYzajUZNVLInnDdCCBptlDdXFj2MkC/
	 06s4qhSRmh4XXdyFV4scC7M22WsASXQ18Ct91IFk=
Date: Mon, 5 Jan 2026 14:56:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	Junbeom Yeom <junbeom.yeom@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: [PATCH 6.18.y v2] erofs: fix unexpected EIO under memory pressure
Message-ID: <2026010521-snout-handheld-98f3@gregkh>
References: <20251229185432.1616355-2-sashal@kernel.org>
 <20251230023053.3682970-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230023053.3682970-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Dec 30, 2025 at 10:30:53AM +0800, Gao Xiang wrote:
> From: Junbeom Yeom <junbeom.yeom@samsung.com>
> 
> erofs readahead could fail with ENOMEM under the memory pressure because
> it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
> for a regular read. And if readahead fails (with non-uptodate folios),
> the original request will then fall back to synchronous read, and
> `.read_folio()` should return appropriate errnos.
> 
> However, in scenarios where readahead and read operations compete,
> read operation could return an unintended EIO because of an incorrect
> error propagation.
> 
> To resolve this, this patch modifies the behavior so that, when the
> PCL is for read(which means pcl.besteffort is true), it attempts actual
> decompression instead of propagating the privios error except initial EIO.
> 
> - Page size: 4K
> - The original size of FileA: 16K
> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
> [page0, page1] [page2, page3]
> [PCL0]---------[PCL1]
> 
> - functions declaration:
>   . pread(fd, buf, count, offset)
>   . readahead(fd, offset, count)
> - Thread A tries to read the last 4K
> - Thread B tries to do readahead 8K from 4K
> - RA, besteffort == false
> - R, besteffort == true
> 
>         <process A>                   <process B>
> 
> pread(FileA, buf, 4K, 12K)
>   do readahead(page3) // failed with ENOMEM
>   wait_lock(page3)
>     if (!uptodate(page3))
>       goto do_read
>                                readahead(FileA, 4K, 8K)
>                                // Here create PCL-chain like below:
>                                // [null, page1] [page2, null]
>                                //   [PCL0:RA]-----[PCL1:RA]
> ...
>   do read(page3)        // found [PCL1:RA] and add page3 into it,
>                         // and then, change PCL1 from RA to R
> ...
>                                // Now, PCL-chain is as below:
>                                // [null, page1] [page2, page3]
>                                //   [PCL0:RA]-----[PCL1:R]
> 
>                                  // try to decompress PCL-chain...
>                                  z_erofs_decompress_queue
>                                    err = 0;
> 
>                                    // failed with ENOMEM, so page 1
>                                    // only for RA will not be uptodated.
>                                    // it's okay.
>                                    err = decompress([PCL0:RA], err)
> 
>                                    // However, ENOMEM propagated to next
>                                    // PCL, even though PCL is not only
>                                    // for RA but also for R. As a result,
>                                    // it just failed with ENOMEM without
>                                    // trying any decompression, so page2
>                                    // and page3 will not be uptodated.
>                 ** BUG HERE ** --> err = decompress([PCL1:R], err)
> 
>                                    return err as ENOMEM
> ...
>     wait_lock(page3)
>       if (!uptodate(page3))
>         return EIO      <-- Return an unexpected EIO!
> ...
> 
> Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Greg and Sasha,
> 
> Let's just merge this directly.
> No need to backport commit 831faabed812 ("erofs: improve decompression error reporting")
> for now.

Now taken, thanks!

greg k-h

