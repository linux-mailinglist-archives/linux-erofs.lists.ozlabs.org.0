Return-Path: <linux-erofs+bounces-253-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3B3AA0028
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 05:07:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmlbZ0m3cz301N;
	Tue, 29 Apr 2025 13:07:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745896026;
	cv=none; b=AdFi4zSMqI4a5XZouvN3akN5GdCBH7jsVrVajXzNDcPjZl6ktO1DQcDMBs+RONVq6QKVw236WkF73eBORnzKEnrGSMSMEh0ifNud4+Qwrx9+RV76E+j/SMPx/n9gv0+ay4DrNW6A3WoEcrDfFKbqA9oTatEI/5ko6ofAsdRljQ3lMVPQwkMMK1g9X+e9Q4ZqaJjiwVnW6mrTMpqCC18Gid54XZ2yFrdTBZzJJKyEN0Uo2S1HuRvrrSlbKpVD4ByJzEeZbGRDGDoHk7YPBWT5ApYl9PG1d7wekDqWbxdXUKp7qn79FGeqr3matVgIZYFqnrwrAHodJuPnBOkjIe8CKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745896026; c=relaxed/relaxed;
	bh=t9l6HhvuEGwMpECMABK6OK3y29OjPG7ym0N9xxDBtQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQieWI2qZdAIye7NwhQCB5tIVABDhfrTOL6+5fZsXJekblku7mj/Q6clq30i2uocyZKr1+pp/Y5mYRQ2X06BdMqZ2Ck5/MpHS/sVFmnHu4o9QNyRNhbN4LEKZwREd25idjgI1xZ0VHW6eiE883bHL1NFfQU1pRJFwk+morKYPqHxrLX8UdX3AwJb+2R5MA2yiK6qflkB77yxHlR09F8O59IhwnqKCLjBSh7+0NqRau4EXs/eCuj4X9n+Wwf4qDCvDknsqIVoTsDrJIbXGrbCC5QW9xNJ2aRBYOx8Cn774yyqkEdpIqOfigdjLfdigtlDA8/C1YI1ORTFNrBr9fsBjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NPGkMOG/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NPGkMOG/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmlbY0cQVz2yfy
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 13:07:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F8D761139;
	Tue, 29 Apr 2025 03:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDFFC4CEE4;
	Tue, 29 Apr 2025 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745896021;
	bh=Q670eReyAtJoadARUJrI2RpbKjr3KWV2o+ElngikDiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPGkMOG/bb287fpr0RQ0Bf7QJgyDzWisVOWqcRgnvLQRaciyvwDt/JwqkkQNDq4hX
	 iTajprmqF/tiZlcv0e/D2FMUZNuFmhlMm7gOu0subQR1B03+6VKUGm16jvhLPq9pQo
	 Ii45Fw2NTfj0vQQ+CvUsq7TYIQXIoVJ92H+UbhhOpOFwA2fI9gDQmcIZa9evO2L9Bg
	 3eiaKq+Fw/L8ZDr3tIZMdPxF3XzL/L0yO13IVGGXTYqnfLqerYmwYU3nZxHDdRgrQr
	 l+TSPqq/42wZgvmfkoMnZkOeYMbf41are0G8eJmbEX8WloWYC2L4j4A3x3hS0j/5DC
	 Jb1QyLjrGeFEw==
Date: Tue, 29 Apr 2025 11:06:52 +0800
From: Gao Xiang <xiang@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/erofs/fileio: call erofs_onlinefolio_split() after
 bio_add_folio()
Message-ID: <aBBCTGo7I4OHyVAH@debian>
Mail-Followup-To: Max Kellermann <max.kellermann@ionos.com>,
	xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250428230933.3422273-1-max.kellermann@ionos.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428230933.3422273-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Apr 29, 2025 at 01:09:33AM +0200, Max Kellermann wrote:
> If bio_add_folio() fails (because it is full),
> erofs_fileio_scan_folio() needs to submit the I/O request via
> erofs_fileio_rq_submit() and allocate a new I/O request with an empty
> `struct bio`.  Then it retries the bio_add_folio() call.
> 
> However, at this point, erofs_onlinefolio_split() has already been
> called which increments `folio->private`; the retry will call
> erofs_onlinefolio_split() again, but there will never be a matching
> erofs_onlinefolio_end() call.  This leaves the folio locked forever
> and all waiters will be stuck in folio_wait_bit_common().
> 
> This bug has been added by commit ce63cb62d794 ("erofs: support
> unencoded inodes for fileio"), but was practically unreachable because
> there was room for 256 folios in the `struct bio` - until commit
> 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts") which
> reduced the array capacity to 16 folios.
> 
> It was now trivial to trigger the bug by manually invoking readahead
> from userspace, e.g.:
> 
>  posix_fadvise(fd, 0, st.st_size, POSIX_FADV_WILLNEED);
> 
> This should be fixed by invoking erofs_onlinefolio_split() only after
> bio_add_folio() has succeeded.  This is safe: asynchronous completions
> invoking erofs_onlinefolio_end() will not unlock the folio because
> erofs_fileio_scan_folio() is still holding a reference to be released
> by erofs_onlinefolio_end() at the end.
> 
> Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
> Fixes: 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Thanks for catching this! LGTM:
Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

