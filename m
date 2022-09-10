Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979E5B44C6
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 08:51:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPk6n1kHYz303N
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Sep 2022 16:51:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GJmfyYiS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+74593d5eb0e0b46c37a4+6957+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPk6S0BBBz2yxG
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Sep 2022 16:51:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5boGn7vQhK1/qyQ9CrG6mQXzf4WCqUbSGuj00WF3en4=; b=GJmfyYiSjVHZYw5b9vVusVFTJt
	0PSWAGmPJboxa1YQqL5UH68Ksc+TeI9ogIFTsYh+fzj77xXzUEnAUEKXJjUy4pHujRM5ZRP9JXgdC
	7k7z+FVbg+sn2ZDxX9yRO5VKSjwvR3h21uqvVq8qDBCl8lxf1TL6tQIVuc+dRWQNDRQSNItRDrU5C
	C8/67qIXRinUlBjrmE9fRTTmYP0f+2rhs7rOxts84LIB3Hx8yX6GrxJnDnRHaannnal3fweRkxY2j
	vTW8FnRKjlw+Bqvq4H5tMP3x/cYsjXdtnGnXghp9lRL7bdMuTuln7DQ7JH2AT/hxr3YVD+2zgluAt
	/UC45XtQ==;
Received: from [2001:4bb8:198:38af:e8dc:dbbd:a9d:5c54] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWuKX-006pZ6-Rp; Sat, 10 Sep 2022 06:51:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: improve pagecache PSI annotations
Date: Sat, 10 Sep 2022 08:50:53 +0200
Message-Id: <20220910065058.3303831-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

currently the VM tries to abuse the block layer submission path for
the page cache PSI annotations.  This series instead annotates the
->read_folio and ->readahead calls in the core VM code, and then
only deals with the odd direct add_to_page_cache_lru calls manually.

Diffstat:
 block/bio.c               |    8 --------
 block/blk-core.c          |   17 -----------------
 fs/btrfs/compression.c    |   14 ++++++++++++--
 fs/direct-io.c            |    2 --
 fs/erofs/zdata.c          |   13 ++++++++++++-
 include/linux/blk_types.h |    1 -
 include/linux/pagemap.h   |    2 ++
 kernel/sched/psi.c        |    2 ++
 mm/filemap.c              |    7 +++++++
 mm/readahead.c            |   22 ++++++++++++++++++----
 10 files changed, 53 insertions(+), 35 deletions(-)
