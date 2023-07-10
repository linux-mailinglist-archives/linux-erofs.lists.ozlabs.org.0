Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6574C9E5
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 04:33:13 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FFZTcsof;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qzp2b64Jqz3bkM
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 12:33:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FFZTcsof;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qzp2V3NZXz30Kf
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 12:33:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B70CA60C4B;
	Mon, 10 Jul 2023 02:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C08C433C8;
	Mon, 10 Jul 2023 02:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688956382;
	bh=annqbaXGFikTnORa0aApR2TW+jDM8Y2fEio7p6kR400=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFZTcsofkfYhaFuqcVeC9hbXiXpstMGRcj7/WiLB/ZDSa7q3pUQVHnUvaXkqXoT73
	 taW2gpR6Dmj+l0sTZLvfZDCATRHu5lEfAXaq2Sc0j5uQgdmWlr2FG9V9U7AtflTyKW
	 /ynrSkejKKaf788dI5bP2OPr9Kk2uZHztabHK7hwJPZrFU7nX0XKGYVZZum9bQuF5P
	 ZokATGtByrrYGugxwd3r6vEV2AbzGYK9bAZghIA4+lHAZgQJQFZkBf2ZvipeUQPK1i
	 UngZFupyYO5H+GUI6XGndc2IB+IccYQwxlL3f/VsljC5y/QUx+c3Yt8JWyb/4Brpue
	 yYoQuhXCUF7Vg==
Date: Sun, 9 Jul 2023 19:33:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/4] erofs-utils: add a built-in DEFLATE compressor
Message-ID: <20230710023300.GA185469@sol.localdomain>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
 <20230709182511.96954-3-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709182511.96954-3-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

On Mon, Jul 10, 2023 at 02:25:09AM +0800, Gao Xiang wrote:
> 
> Since there is _no fixed-sized output DEFLATE compression appoach_
> available in public (fitblk is somewhat ineffective) and the original
> zlib is quite slowly developping, let's work out one for our use cases.
> Fortunately, it's only less than 1.5kLOC with lazy matching to match
> the basic zlib ability.  Besides, near-optimal block splitting (based
> on price function) doesn't support for now since it's not rush for us.
> 
> In the future, there may be more built-in optimizers landed to fulfill
> our needs even further.  In addition, I'd be quite happy to see more
> popular encoders to support fixed-sized output compression too.
> 
> [1] https://developer.apple.com/documentation/compression/compression_algorithm
> [2] https://datatracker.ietf.org/doc/html/rfc1951
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/Makefile.am    |    2 +
>  lib/kite_deflate.c | 1267 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1269 insertions(+)
>  create mode 100644 lib/kite_deflate.c

Have you considered simply running any standard compressor multiple times to
find the maximum input size that compresses to less than or equal to the desired
output size?  It may sound too slow, but it can be made to do the search in a
smart way (binary search + heuristics).  Also, it would easily work with every
compressor, and it would always produce the optimal input size.

I wrote a proof-of-concept patch that implements this idea in the benchmark
program in libdeflate.  It finds the optimal input size in about 8 attempts on
average for a target output size of 4096, or about 13 for a target output size
of 65536.  Note, if an optimal solution is not needed, it could be sped up
slightly by stopping when the output size is at, or just under (if desired), the
target output size.  Also keep in mind that any compression level can be used.

The full code I tested is currently at
https://github.com/ebiggers/libdeflate/tree/fixed-output-size, but below is the
actual algorithm:

/*
 * Compresses the largest prefix of 'in', with maximum size 'in_nbytes', whose
 * compressed output is at most 'target_output_size' bytes.  The compressed size
 * is returned as the return value, and the uncompressed size is returned in
 * *actual_in_nbytes_ret.  The output buffer 'out' has size 'out_nbytes_avail',
 * which should be at least 'target_output_size + 9'.  'tmpbuf' must be a buffer
 * the same size as 'out'.
 */
static size_t
do_compress_withfixedoutputsize(struct compressor *c,
				const u8 *in, size_t in_nbytes,
				u8 *out, size_t out_nbytes_avail,
				size_t target_output_size,
				size_t last_uncompressed_size,
				u8 *tmpbuf,
				size_t *actual_in_nbytes_ret)
{
	size_t l = 0; /* largest input that fits so far */
	size_t l_csize = 0;
	size_t r = in_nbytes + 1; /* smallest input that doesn't fit so far */
	size_t m;

	if (last_uncompressed_size)
		m = last_uncompressed_size * 15 / 16;
	else
		m = target_output_size * 4;
	for (;;) {
		size_t csize;

		m = MAX(m, l + 1);
		m = MIN(m, r - 1);

		csize = do_compress(c, in, m, tmpbuf, out_nbytes_avail);
		if (csize > 0 && csize <= target_output_size) {
			/* Fits */
			memcpy(out, tmpbuf, csize);
			l = m;
			l_csize = csize;
			if (r <= l + 1)
				break;
			/*
			 * Estimate needed input prefix size based on current
			 * compression ratio.
			 */
			m = (target_output_size * m) / csize;
		} else {
			/* Doesn't fit */
			r = m;
			if (r <= l + 1)
				break;
			m = (l + r) / 2;
		}
	}
	*actual_in_nbytes_ret = l;
	return l_csize;
}

What do you think?

- Eric
