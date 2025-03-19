Return-Path: <linux-erofs+bounces-89-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A3A68685
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 09:17:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHhQq3mqcz2yb9;
	Wed, 19 Mar 2025 19:17:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742372259;
	cv=none; b=S7s38wGwpaBuGIHseCcgSrq7VIiy7SYHZZTq1VOOfJnnnhUaS8piuH7Icc5nyi77i+lMgp4vthDwW4FBUWXkomU7oM+C+pjp8TuyRRAh+A91Ydt5BN2zQqtvog/+XRAWQrArRUADmlfq4nIYt2eal+jpRqbI3eWOnpw4Z4JbmP7hjUD6acYCnLcbndYHvvnhs74s3UeKwTZyf+42vpeMHHeEea1BPTjwJkJ9pa+EaZSaQXMMMlsReGfsLW47KH0WPntZDaZLDkQddh2ds3KjnK/wVg7dQ9FVJEixsgPbpp6aLNDY7wsvXOOnE4kXLetJqW4ccWraDWIJqJO1FTmuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742372259; c=relaxed/relaxed;
	bh=F/GsEnrJRag/dYkjfsmTmWcPmYvBWBTPs9Bv0JZl0BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUFvVyEpqJQC2fINQWsPO+45JQzbllhvfShUb8KsfqGMYEk82j7oZplJmgAyj1nStKw4AiJpF0TRbaEkoOvY9oYC4NMhR+OdKgPUkU9P3qI5D0eCBeUs8zF8N69jNVQ61/D4jRm0Pqsh9IyFDINVfKWGXnoYz9WqvSQqcNpImpDM9LXzeTLpiHdquXHMp1mRiiD4E3eBK3audXebTLI8gEdwgfb0rPP3Aya9PRTEQPuKPdhAI0+/3wKGFDBtgmYdV2E5XNvGRredYS2+HpLiei6wDt/mfuCkClEDaxBzaDN7QfqUqoMhU1H13IubUh/0bAtv+5no1aq59VWZ4pa96Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHhQp2qbZz2ySb
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 19:17:37 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C30367373; Wed, 19 Mar 2025 09:17:30 +0100 (CET)
Date: Wed, 19 Mar 2025 09:17:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
Message-ID: <20250319081730.GB26281@lst.de>
References: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I'd move the iomap_iter_advance into iomap_read_inline_data, just like
we've pushed it down as far as possible elsewhere, e.g. something like
the patch below.  Although with that having size and length puzzles
me a bit, so maybe someone more familar with the code could figure
out why we need both, how they can be different and either document
or eliminate that.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d52cfdc299c4..7858c8834144 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -332,15 +332,15 @@ struct iomap_readpage_ctx {
  * Only a single IOMAP_INLINE extent is allowed at the end of each file.
  * Returns zero for success to complete the read, or the usual negative errno.
  */
-static int iomap_read_inline_data(const struct iomap_iter *iter,
-		struct folio *folio)
+static int iomap_read_inline_data(struct iomap_iter *iter, struct folio *folio)
 {
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
+	loff_t length = iomap_length(iter);
 	size_t offset = offset_in_folio(folio, iomap->offset);
 
 	if (folio_test_uptodate(folio))
-		return 0;
+		goto advance;
 
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
@@ -349,7 +349,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 
 	folio_fill_tail(folio, offset, iomap->inline_data, size);
 	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
-	return 0;
+advance:
+	return iomap_iter_advance(iter, &length);
 }
 
 static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,

