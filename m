Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7127B7E4AA6
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 22:27:30 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qRN0vkvE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQ1X02J8wz2ytJ
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 08:27:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qRN0vkvE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQ1WW57jtz2yV3
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Nov 2023 08:27:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EP7joTD4KdhEN+JYaunSKscvkg3WE9Mu9wWDQxtZwaU=; b=qRN0vkvEs+DqYPQ9wvyojFvPip
	llXW+LTsloyNInz83z14hPryJOAdfhILlpUV6VzGgCw7Py3gAFsAYrTV2V8Cx6aRWv9/z9RLtg8pq
	4Xc4WmxdT1sFNUBm8eEzfT52hBD0tLRoXQ/Bc7HMhzcPZMt9+WtXXvpdxIiIyoeajAGopCwzgzL4c
	9Un/dahv36o5lb9YAyPUAOe+4RzbEP8GqJAOLqx2P9uKJLP97Al/aJE6i4kxw/9tXS/5AKx4PkT3E
	7XphcldjtukAjc+8u/+wuGjhPrK67Js9wXXrP3LdlRp/TCeIh+J/YsIg1zOICXJQDTFRJvbngr0gd
	fR40IhDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0Tav-00Ee0T-0I; Tue, 07 Nov 2023 21:26:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] Add folio_zero_tail() and folio_fill_tail()
Date: Tue,  7 Nov 2023 21:26:39 +0000
Message-Id: <20231107212643.3490372-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I'm trying to make it easier for filesystems with tailpacking /
stuffing / inline data to use folios.  The primary function here is
folio_fill_tail().  You give it a pointer to memory where the data
currently is, and it takes care of copying it into the folio at that
offset.  That works for gfs2 & iomap.  Then There's Ext4.  Rather than
gin up some kind of specialist "Here's a two pointers to two blocks
of memory" routine, just let it do its current thing, and let it call
folio_zero_tail(), which is also called by folio_fill_tail().

Other filesystems can be converted later; these ones seemed like good
examples as they're already partly or completely converted to folios.

Matthew Wilcox (Oracle) (3):
  mm: Add folio_zero_tail() and use it in ext4
  mm: Add folio_fill_tail() and use it in iomap
  gfs2: Convert stuffed_readpage() to stuffed_read_folio()

 fs/ext4/inline.c        |  3 +-
 fs/gfs2/aops.c          | 37 +++++++++-----------
 fs/iomap/buffered-io.c  | 14 ++------
 include/linux/highmem.h | 76 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 34 deletions(-)

-- 
2.42.0

