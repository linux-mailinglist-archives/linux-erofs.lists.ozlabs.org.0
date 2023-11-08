Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAD7E60D7
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 00:06:26 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Kb4LDRBs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQggh0Hpqz3bdm
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 10:06:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Kb4LDRBs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQggV2MzSz2ykc
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Nov 2023 10:06:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F12C3CE1261;
	Wed,  8 Nov 2023 23:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE81C433C8;
	Wed,  8 Nov 2023 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699484767;
	bh=t8pBQSNPVR9LioM+HcvTKgJwQbCrujWjNwfm0VTaR5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kb4LDRBsnf32K7Vz06ikeb1CPOiJ1H15eXMnH9kxTJtY+bF3pXhcR2BSF6zYwQ9fK
	 mgsr+P98qJyhfHSMhotMocwnZnya8dqNepcltfzM8d5SSPm+BeIy3OSTsEhS64I852
	 xWfR27VQoZFdkB/pFGkyj8cEyQwskDqZcuVcGtAc=
Date: Wed, 8 Nov 2023 15:06:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
Message-Id: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
In-Reply-To: <20231107212643.3490372-2-willy@infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
	<20231107212643.3490372-2-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue,  7 Nov 2023 21:26:40 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Instead of unmapping the folio after copying the data to it, then mapping
> it again to zero the tail, provide folio_zero_tail() to zero the tail
> of an already-mapped folio.
> 
> ...
>
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -483,6 +483,44 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
>  	flush_dcache_folio(folio);
>  }
>  
> +/**
> + * folio_zero_tail - Zero the tail of a folio.
> + * @folio: The folio to zero.
> + * @kaddr: The address the folio is currently mapped to.
> + * @offset: The byte offset in the folio to start zeroing at.

That's the argument ordering I would expect.

> + * If you have already used kmap_local_folio() to map a folio, written
> + * some data to it and now need to zero the end of the folio (and flush
> + * the dcache), you can use this function.  If you do not have the
> + * folio kmapped (eg the folio has been partially populated by DMA),
> + * use folio_zero_range() or folio_zero_segment() instead.
> + *
> + * Return: An address which can be passed to kunmap_local().
> + */
> +static inline __must_check void *folio_zero_tail(struct folio *folio,
> +		size_t offset, void *kaddr)

While that is not.  addr,len is far more common that len,addr?

> +{
> +	size_t len = folio_size(folio) - offset;

Calling it `remaining' would be more clear.

> +
> +	if (folio_test_highmem(folio)) {
> +		size_t max = PAGE_SIZE - offset_in_page(offset);
> +
> +		while (len > max) {

Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
the final page.

> +			memset(kaddr, 0, max);
> +			kunmap_local(kaddr);
> +			len -= max;
> +			offset += max;
> +			max = PAGE_SIZE;
> +			kaddr = kmap_local_folio(folio, offset);
> +		}
> +	}
> +
> +	memset(kaddr, 0, len);
> +	flush_dcache_folio(folio);
> +
> +	return kaddr;
> +}
> +

