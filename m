Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979415B97AE
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 11:42:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSsgS3syDz3blT
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 19:42:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pxDLm4xC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+aa90abf7a61f323a8d2f+6962+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pxDLm4xC;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSsgL0yygz30Mr
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 19:42:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kmV+bjuBIbb/1Zd/POYrIraBtwwr2RAc0pWgW32GYaw=; b=pxDLm4xC98kMchQ2l7sCCX9ypx
	yEG1CA9vqMQoSnRfymGegTpnD7aWpNAjR0io9BXKkCJUlaeaImBb5HPHQvpaIEcn7gQlp9MdmyA2u
	ud5HTkIA99OGEQgFFW00Oi3IvT4qXbgu2Bly55ijYDeIKcHa+uDrleY8qQACq9sLyqYqbhy+sCJH4
	axR2Ss+V5nYbvPWnt8c5pCYa2CwDlUHh5DRfgqzyo3K3adLgRqRVBQ+5PhnjU33dzwau//LcLchDQ
	LXMHkjhT2m0c8ylR37ue/UV76hsx/rcvJDhVPj7laWTuXEbPHAhw2KB8FvSSN9CFC6h/aXAQCyCVD
	pkhNmU4Q==;
Received: from [185.122.133.20] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYlNi-005auV-92; Thu, 15 Sep 2022 09:42:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: improve pagecache PSI annotations v2
Date: Thu, 15 Sep 2022 10:41:55 +0100
Message-Id: <20220915094200.139713-1-hch@lst.de>
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

Changes since v1:
 - fix a logic error in ra_alloc_folio
 - drop a unlikely()
 - spell a comment in the weird way preferred by btrfs maintainers

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
