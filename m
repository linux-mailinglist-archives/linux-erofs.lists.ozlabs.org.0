Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C7430F25
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 06:41:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXkjN3R4tz2ywJ
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 15:41:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RWsnrEN/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+653fb0268b18c2e086a8+6630+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=RWsnrEN/; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXkj92ZjXz2yRS
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 15:41:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=5FVSqxmInxZpxLfquTYTWo3aHtcI6RxpSGZW6UNZj6o=; b=RWsnrEN/AN21+3N1QS/sVzo/pA
 KUprhD61JwCSOViB6cCzwYWYPy8xO6eWNrrG8XEt0LTqvix7ajoUiGCskUDEIh+XmHUnJyX/tgDJj
 Esl/uNdX1ly5Yy9ZBHbYr6yKuDS9X5SLz4ZAngrPtzD/0A2qwFx8g8P1chEP+4L6TG/G9DEqtaDJ6
 jW1vIyTNr2TebDqfs2jg2FxBFf/f/gWdoiabUqKvxpvOm2M2Nvc85QefHdxbJPv9Dys7AN5jmyANn
 iuh0ImYfAhQwPFWqmpyXU78hqF4KUrq+0TQ/4jRUyILMGOEhgr5OTDCogwtAbPD6vKEUBlPEk3aPn
 umppEHQg==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcKSH-00E3Et-TF; Mon, 18 Oct 2021 04:40:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Subject: futher decouple DAX from block devices
Date: Mon, 18 Oct 2021 06:40:43 +0200
Message-Id: <20211018044054.1779424-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

this series cleans up and simplifies the association between DAX and block
devices in preparation of allowing to mount file systems directly on DAX
devices without a detour through block devices.

Diffstat:
 drivers/dax/Kconfig          |    4 
 drivers/dax/bus.c            |    2 
 drivers/dax/super.c          |  220 +++++--------------------------------------
 drivers/md/dm-linear.c       |   51 +++------
 drivers/md/dm-log-writes.c   |   44 +++-----
 drivers/md/dm-stripe.c       |   65 +++---------
 drivers/md/dm-table.c        |   22 ++--
 drivers/md/dm-writecache.c   |    2 
 drivers/md/dm.c              |   29 -----
 drivers/md/dm.h              |    4 
 drivers/nvdimm/Kconfig       |    2 
 drivers/nvdimm/pmem.c        |    9 -
 drivers/s390/block/Kconfig   |    2 
 drivers/s390/block/dcssblk.c |   12 +-
 fs/dax.c                     |   13 ++
 fs/erofs/super.c             |   11 +-
 fs/ext2/super.c              |    6 -
 fs/ext4/super.c              |    9 +
 fs/fuse/Kconfig              |    2 
 fs/fuse/virtio_fs.c          |    2 
 fs/xfs/xfs_super.c           |   54 +++++-----
 include/linux/dax.h          |   30 ++---
 22 files changed, 185 insertions(+), 410 deletions(-)
