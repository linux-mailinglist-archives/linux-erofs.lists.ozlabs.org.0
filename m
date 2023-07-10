Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A574CB20
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 06:16:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hri1KLDJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzrL90dhtz3bNp
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 14:16:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hri1KLDJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzrL30XZlz2ygG
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 14:16:42 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A497860B38;
	Mon, 10 Jul 2023 04:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046DDC433C9;
	Mon, 10 Jul 2023 04:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688962600;
	bh=7x2z1cVqOH97MomVFRhY8bwQX1KyTdak49YFSUhCNfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hri1KLDJdtUg8RimgGrqETeZC+r/SyNirEr9gb++bdyQ/KH6eVAFTLB/Av98LjJ1X
	 tqJRRPzpR/r55Kn5wkN6NdETK1ckVPHdzvG/lq7X57e1rUjLHDKqsY4JDtpL4eybbH
	 fswfVStqtLPUJy7wtlmVFfz2F1acVpgo7tiYQDCTUDHYMS0k+lX/FQrIXKp0sgT68V
	 JkqPFjAKZBtSijSl7xWNauQ7BEQ7CGuwyn9jJyPLn/vZK+m7SzTXRap5T9R14AIXIc
	 tu8C+Yd0U5dlBAT7exos/5N8c8jyRrsVl6tNjwdi6OKEbN7NpbOTCldpVFCoa/4nE0
	 MEGEXPZCk3ZpA==
Date: Sun, 9 Jul 2023 21:16:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/4] erofs-utils: add a built-in DEFLATE compressor
Message-ID: <20230710041638.GA21080@sol.localdomain>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
 <20230709182511.96954-3-hsiangkao@linux.alibaba.com>
 <20230710023300.GA185469@sol.localdomain>
 <52875e72-4871-7615-3f20-f02cd9548898@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52875e72-4871-7615-3f20-f02cd9548898@linux.alibaba.com>
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

On Mon, Jul 10, 2023 at 11:01:16AM +0800, Gao Xiang wrote:
> Hi Eric,
> 
> On 2023/7/10 10:33, Eric Biggers wrote:
> > Hi Gao,
> > 
> > On Mon, Jul 10, 2023 at 02:25:09AM +0800, Gao Xiang wrote:
> > > 
> > > Since there is _no fixed-sized output DEFLATE compression appoach_
> > > available in public (fitblk is somewhat ineffective) and the original
> > > zlib is quite slowly developping, let's work out one for our use cases.
> > > Fortunately, it's only less than 1.5kLOC with lazy matching to match
> > > the basic zlib ability.  Besides, near-optimal block splitting (based
> > > on price function) doesn't support for now since it's not rush for us.
> > > 
> > > In the future, there may be more built-in optimizers landed to fulfill
> > > our needs even further.  In addition, I'd be quite happy to see more
> > > popular encoders to support fixed-sized output compression too.
> > > 
> > > [1] https://developer.apple.com/documentation/compression/compression_algorithm
> > > [2] https://datatracker.ietf.org/doc/html/rfc1951
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >   lib/Makefile.am    |    2 +
> > >   lib/kite_deflate.c | 1267 ++++++++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 1269 insertions(+)
> > >   create mode 100644 lib/kite_deflate.c
> > 
> > Have you considered simply running any standard compressor multiple times to
> > find the maximum input size that compresses to less than or equal to the desired
> > output size?  It may sound too slow, but it can be made to do the search in a
> 
> Thanks for your interest and reply!
> 
> Actually I've tried several ways before (just like fitblk.c or binary search),
> but the compression ratios is sliently impacted

That's strange, since the method I suggested should improve the compression
ratio.

> and compression speed is really
> impacted (maybe we need to develop segment-splitted multi-threadded compression
> as well, and it's developping by a college student now but I'm not sure the
> progress.)

I'm surprised that multi-threaded compression isn't something you have already!

> 
> I think we could use this way first for the new Zstd support (if they don't have
> bandwidth to add a offical fixed-sized output approach), but considering deflate
> algorithm is quite easy for me to understand so at least I could have a simple
> built-in one to avoid external dependency (mainly considering zlib since it's
> quite outdated).  Since EROFS is actually offline compression so the compressed
> data correctness can always be checked in advance before image release.

Writing an optimized compressor, especially one that implements high compression
levels, is very hard.  Are you sure it's something you want to implement and
maintain in erofs-utils?

> Also I have more ideas to optimize the last symbol from matchfinders (even lazy
> matching) for fixed-sized output approaches to get even better compression
> ratios (especially for smaller filesystem cluster like 4kb.)

Yes, there are some tricks that compressors that natively support
fixed-size-output mode could use in order to avoid redundant work.

> > smart way (binary search + heuristics).  Also, it would easily work with every
> > compressor, and it would always produce the optimal input size.
> > 
> > I wrote a proof-of-concept patch that implements this idea in the benchmark
> > program in libdeflate.  It finds the optimal input size in about 8 attempts on
> > average for a target output size of 4096, or about 13 for a target output size
> > of 65536.  Note, if an optimal solution is not needed, it could be sped up
> > slightly by stopping when the output size is at, or just under (if desired), the
> > target output size.  Also keep in mind that any compression level can be used.
> > 
> > The full code I tested is currently at
> > https://github.com/ebiggers/libdeflate/tree/fixed-output-size, but below is the
> > actual algorithm:
> 
> If libdeflate officically supports this mode, I'm very happy to integrate
> libdeflate in this way as an alternative encoder (if you could merge this), and
> if the compression speed is improved, I could switch it to the default encoder
> then. In the other words, I really hope there could be an official deflate
> encoder to support this mode as well.  Also I think the in-kernel zlib
> decompression is somewhat slow just due to some non-technical reasons, I might
> need to improve this eveutually but it's no rush for us compared to support
> DEFLATE format first as well.
> 
> > 
> > /*
> >   * Compresses the largest prefix of 'in', with maximum size 'in_nbytes', whose
> >   * compressed output is at most 'target_output_size' bytes.  The compressed size
> >   * is returned as the return value, and the uncompressed size is returned in
> >   * *actual_in_nbytes_ret.  The output buffer 'out' has size 'out_nbytes_avail',
> >   * which should be at least 'target_output_size + 9'.  'tmpbuf' must be a buffer
> >   * the same size as 'out'.
> >   */
> > static size_t
> > do_compress_withfixedoutputsize(struct compressor *c,
> > 				const u8 *in, size_t in_nbytes,
> > 				u8 *out, size_t out_nbytes_avail,
> > 				size_t target_output_size,
> > 				size_t last_uncompressed_size,
> > 				u8 *tmpbuf,
> > 				size_t *actual_in_nbytes_ret)
> > {
> > 	size_t l = 0; /* largest input that fits so far */
> > 	size_t l_csize = 0;
> > 	size_t r = in_nbytes + 1; /* smallest input that doesn't fit so far */
> > 	size_t m;
> > 
> > 	if (last_uncompressed_size)
> > 		m = last_uncompressed_size * 15 / 16;
> > 	else
> > 		m = target_output_size * 4;
> > 	for (;;) {
> > 		size_t csize;
> > 
> > 		m = MAX(m, l + 1);
> > 		m = MIN(m, r - 1);
> > 
> > 		csize = do_compress(c, in, m, tmpbuf, out_nbytes_avail);
> > 		if (csize > 0 && csize <= target_output_size) {
> > 			/* Fits */
> > 			memcpy(out, tmpbuf, csize);
> > 			l = m;
> > 			l_csize = csize;
> > 			if (r <= l + 1)
> > 				break;
> > 			/*
> > 			 * Estimate needed input prefix size based on current
> > 			 * compression ratio.
> > 			 */
> > 			m = (target_output_size * m) / csize;
> > 		} else {
> > 			/* Doesn't fit */
> > 			r = m;
> > 			if (r <= l + 1)
> > 				break;
> > 			m = (l + r) / 2;
> > 		}
> > 	}
> > 	*actual_in_nbytes_ret = l;
> > 	return l_csize;
> > }
> > 
> > What do you think?
> 
> Thank you for the time and your efforts, I much appreciate if it could be
> supported so I could add a alternative encoder for this.
> 

Native fixed-size-output size support in libdeflate is something I'll think
about.  However, the point I'm making is that it's unclear how valuable native
fixed-size-output size support in compressors is, given that the search
algorithm I described above actually seems to work fairly well, and it can
produce the optimal solution.

Here's a quick proof of concept patch for mkfs.erofs:

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 553b387..f58a684 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -45,3 +45,4 @@ liberofs_la_SOURCES += compressor_liblzma.c
 endif
 
 liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
+liberofs_la_LDFLAGS = -ldeflate
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index ad76b7c..d7a5e90 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -6,6 +6,7 @@
 #include "erofs/internal.h"
 #include "erofs/print.h"
 #include "erofs/config.h"
+#include "libdeflate.h"
 #include "compressor.h"
 
 void *kite_deflate_init(int level, unsigned int dict_size);
@@ -13,16 +14,64 @@ void kite_deflate_end(void *s);
 int kite_deflate_destsize(void *s, const u8 *in, u8 *out,
 			  unsigned int *srcsize, unsigned int target_dstsize);
 
+#define USE_LIBDEFLATE
+
 static int deflate_compress_destsize(const struct erofs_compress *c,
 				     const void *src, unsigned int *srcsize,
 				     void *dst, unsigned int dstsize)
 {
+#ifdef USE_LIBDEFLATE
+	static size_t last_uncompressed_size = 0;
+	size_t l = 0; /* largest input that fits so far */
+	size_t l_csize = 0;
+	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
+	size_t m;
+	u8 tmpbuf[dstsize + 9];
+
+	if (last_uncompressed_size)
+		m = last_uncompressed_size * 15 / 16;
+	else
+		m = dstsize * 4;
+	for (;;) {
+		size_t csize;
+
+		m = max(m, l + 1);
+		m = min(m, r - 1);
+
+		csize = libdeflate_deflate_compress(c->private_data, src, m, tmpbuf, dstsize + 9);
+		/*printf("Tried %zu => %zu\n", m, csize);*/
+		if (csize > 0 && csize <= dstsize) {
+			/* Fits */
+			memcpy(dst, tmpbuf, csize);
+			l = m;
+			l_csize = csize;
+			if (r <= l + 1 || csize + (22 - 2*(int)c->compression_level) >= dstsize)
+				break;
+			/*
+			 * Estimate needed input prefix size based on current
+			 * compression ratio.
+			 */
+			m = (dstsize * m) / csize;
+		} else {
+			/* Doesn't fit */
+			r = m;
+			if (r <= l + 1)
+				break;
+			m = (l + r) / 2;
+		}
+	}
+	/*printf("Choosing %zu => %zu\n", l, l_csize);*/
+	*srcsize = l;
+	last_uncompressed_size = l;
+	return l_csize;
+#else
 	int rc = kite_deflate_destsize(c->private_data, src, dst,
 				       srcsize, dstsize);
 
 	if (rc <= 0)
 		return -EFAULT;
 	return rc;
+#endif
 }
 
 static int compressor_deflate_exit(struct erofs_compress *c)
@@ -30,7 +79,11 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 	if (!c->private_data)
 		return -EINVAL;
 
+#ifdef USE_LIBDEFLATE
+	libdeflate_free_compressor(c->private_data);
+#else
 	kite_deflate_end(c->private_data);
+#endif
 	return 0;
 }
 
@@ -47,8 +100,13 @@ static int compressor_deflate_init(struct erofs_compress *c)
 static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 					     int compression_level)
 {
-	void *s;
+	if (compression_level < 0)
+		compression_level = erofs_compressor_deflate.default_level;
 
+#ifdef USE_LIBDEFLATE
+	libdeflate_free_compressor(c->private_data);
+	c->private_data = libdeflate_alloc_compressor(compression_level);
+#else
 	if (c->private_data) {
 		kite_deflate_end(c->private_data);
 		c->private_data = NULL;
@@ -57,11 +115,13 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 	if (compression_level < 0)
 		compression_level = erofs_compressor_deflate.default_level;
 
-	s = kite_deflate_init(compression_level, cfg.c_dict_size);
+	void *s = kite_deflate_init(compression_level, cfg.c_dict_size);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
 	c->private_data = s;
+#endif
+
 	c->compression_level = compression_level;
 	return 0;
 }
@@ -69,7 +129,11 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 const struct erofs_compressor erofs_compressor_deflate = {
 	.name = "deflate",
 	.default_level = 1,
+#ifdef USE_LIBDEFLATE
+	.best_level = 12,
+#else
 	.best_level = 9,
+#endif
 	.init = compressor_deflate_init,
 	.exit = compressor_deflate_exit,
 	.setlevel = erofs_compressor_deflate_setlevel,

Here are some quick benchmarks I did of mkfs.erofs showing the size of the
resulting filesystem and the time it took for mkfs.erofs to run:

-zdeflate,1
    kite_deflate: 10772480 bytes in 0.474s
    libdeflate: 10366976 bytes in 0.468s
-zdeflate,3
    kite_deflate: 10203136 bytes in 0.511s
    libdeflate: 10092544 bytes in 0.702s
-zdeflate,5
    kite_deflate: 10080256 bytes in 0.596s
    libdeflate: 9973760 bytes in 0.896s
-zdeflate,6
    kite_deflate: 9977856 bytes in 0.650s
    libdeflate: 9936896 bytes in 0.981s
-zdeflate,7
    kite_deflate: 9969664 bytes in 0.690s
    libdeflate: 9920512 bytes in 1.187s
-zdeflate,9
    kite_deflate: 9945088 bytes in 0.986s
    libdeflate: 9871360 bytes in 2.041s
-zdeflate,12
    kite_deflate: N/A
    libdeflate: 9740288 bytes in 28.080s

So it seems my "naive" search algorithm, when combined with libdeflate, actually
does about as well as kite_deflate...  Plus it automatically brings in support
for higher compression levels.

- Eric
