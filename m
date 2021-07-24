Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019C3D449C
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 05:45:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWsXr5J3gz30C7
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 13:45:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=V6zP8t0j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=V6zP8t0j; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWsXh0F1gz2yL6
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 13:45:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=7YaStI1FvzN6rpEWJEqQUaqj9kjMuC7H7ej++bfp29c=; b=V6zP8t0jJDab9lRjdHTXjhreYy
 0U307BiOW2jYElVaxn0pXxDUWSaIvZ5uityE4Cb5Udmxyhkqc17z2fihvZjnvxv/vPv6pjUDdVkdp
 7SIAjGqyOsY8mPFMoMje3oiopvRCc/ZtQu1yfnGcdh+iLsqGtpcJ+H6eL9/FWN4OoL48wt23nfiME
 35COeGGnSwlCuEWz9L72hrbHFX0ykwc2eIpELXE855iwSweRAmQhZ/HmJmPPru5CFVEdaFy4iupP8
 NYRScPs7rx4VTezJkBjGpeYgVAeo4v5PbLIvay1rfXSxqlrzcZRbdOM0NxzT4KPoA5az03ZN/GfFv
 Yyz2gGsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m78ab-00ByXl-DT; Sat, 24 Jul 2021 03:44:41 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org
Subject: [PATCH 0/2] iomap: make inline data support more flexible
Date: Sat, 24 Jul 2021 04:44:33 +0100
Message-Id: <20210724034435.2854295-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The first patch seems to be where Gao Xiang, Christoph and I have
settled for immediate support of EROFS tails.  The second is a prequel
to the folio work.  Because folios are variable size, if we have, eg,
an 8.1KiB file, we must support reading the first two pages of the folio
from blocks and then the last 100 bytes from the tailpack.  That means
effectively supporting block size < page size.  I thought it cleaner to
separate it out, and maybe that can go in this round.

The folio patches are rebased on top of all this; if you're hungry to
see them, they can be found at
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
as usual.  I haven't applied all the R-b yet (and I should probably
figure out which ones still apply since I did some substantial changes
to a couple of the patches).

Gao Xiang (1):
  iomap: Support file tail packing

Matthew Wilcox (Oracle) (1):
  iomap: Support inline data with block size < page size

 fs/iomap/buffered-io.c | 46 +++++++++++++++++++++++++-----------------
 fs/iomap/direct-io.c   | 10 +++++----
 include/linux/iomap.h  | 14 +++++++++++++
 3 files changed, 47 insertions(+), 23 deletions(-)

-- 
2.30.2

