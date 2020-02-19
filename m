Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CD338164B7D
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 18:06:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48N3zd13R0zDqY1
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 04:06:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=YD6KASfC; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48N3zW5cX9zDqQQ
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 04:06:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6hWL64aU7/cD1s4UTpPss89s1pka8CcWGCJ5BHjUC9M=; b=YD6KASfCXNzBE2g7U8C3OPAIMa
 RN+ihaDs+TqA1PVmJY/G+571Br5Ulv0XQc9EhsoYwQWJIGDt5eVY3v+7OW0ZDPPydpAvd+XANKK7o
 Yieli5fHS4G8IkuA6ZGWdtYi3uF69BcBtjkIg1txQfTuEC38FUNQpMva7d6LZIwTpJqOi2eTnjQ26
 vNRvjsTCftaqhGEu3hEvctNIgYhTUrWaBzOu7hsE+5KmGRNAeS2s5R2DU2EMQh/fz/4XG6YC8Yfkl
 lb7zA1cZfGKpjcKVeyriFSjz0Jf9srJLBGVWu7kMAFznlMRG+bjJHweFWDFekIpMDNj5yFPnAlDOG
 rO8cGwug==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4So6-00016p-If; Wed, 19 Feb 2020 17:06:42 +0000
Date: Wed, 19 Feb 2020 09:06:42 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219170642.GS24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <20200219032900.GE10776@dread.disaster.area>
 <20200219060415.GO24185@bombadil.infradead.org>
 <20200219064005.GL10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219064005.GL10776@dread.disaster.area>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 19, 2020 at 05:40:05PM +1100, Dave Chinner wrote:
> Ok, that's what the ctx.cur_page_in_bio check is used to detect i.e.
> if we've got a page that the readahead cursor points at, and we
> haven't actually added it to a bio, then we can leave it to the
> read_pages() to unlock and clean up. If it's in a bio, then IO
> completion will unlock it and so we only have to drop the submission
> reference and move the readahead cursor forwards so read_pages()
> doesn't try to unlock this page. i.e:
> 
> 	/* clean up partial page submission failures */
> 	if (ctx.cur_page && ctx.cur_page_in_bio) {
> 		put_page(ctx.cur_page);
> 		readahead_next(rac);
> 	}
> 
> looks to me like it will handle the case of "ret == 0" in the actor
> function just fine.

Here's what I ended up with:

@@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
                void *data, struct iomap *iomap, struct iomap *srcmap)
 {
        struct iomap_readpage_ctx *ctx = data;
-       loff_t done, ret;
-
-       for (done = 0; done < length; done += ret) {
-               if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-                       if (!ctx->cur_page_in_bio)
-                               unlock_page(ctx->cur_page);
-                       put_page(ctx->cur_page);
-                       ctx->cur_page = NULL;
-               }
+       loff_t ret, done = 0;
+
+       while (done < length) {
                if (!ctx->cur_page) {
                        ctx->cur_page = iomap_next_page(inode, ctx->pages,
                                        pos, length, &done);
@@ -418,6 +412,20 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
                }
                ret = iomap_readpage_actor(inode, pos + done, length - done,
                                ctx, iomap, srcmap);
+               done += ret;
+
+               /* Keep working on a partial page */
+               if (ret && offset_in_page(pos + done))
+                       continue;
+
+               if (!ctx->cur_page_in_bio)
+                       unlock_page(ctx->cur_page);
+               put_page(ctx->cur_page);
+               ctx->cur_page = NULL;
+
+               /* Don't loop forever if we made no progress */
+               if (WARN_ON(!ret))
+                       break;
        }
 
        return done;
@@ -451,11 +459,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 done:
        if (ctx.bio)
                submit_bio(ctx.bio);
-       if (ctx.cur_page) {
-               if (!ctx.cur_page_in_bio)
-                       unlock_page(ctx.cur_page);
-               put_page(ctx.cur_page);
-       }
+       BUG_ON(ctx.cur_page);
 
        /*
         * Check that we didn't lose a page due to the arcance calling

so we'll WARN if we get a ret == 0 (matching ->readpage), and we'll
BUG if we ever see a page being leaked out of readpages_actor, which
is a thing that should never happen and we definitely want to be noisy
about if it does.
