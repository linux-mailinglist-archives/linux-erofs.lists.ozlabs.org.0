Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF55B46122C
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 11:23:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J2hJ64dcKz3cDw
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 21:23:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WyDrKe/B;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+13c9c90cf431a9f4f7f6+6672+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=WyDrKe/B; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J2hHQ0yH4z2yg5
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 21:22:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=y+N6T9OX7HOXSR0XwGBs9AqYCmtI5mlyJgGLesZ2HD4=; b=WyDrKe/Bh7nQ7b/8LTVDbNFSYn
 EXxq5n73/ibf7zm6FmAT7XVapvybXUPlIXP78x4LNgdHQjtaVpQbj3XC2X3raEe99lvIRSxOmR7wW
 HiLQFMH92Ia/3oGO/pOBIv+fFbSdLCDdMhrsch/OnvhZd5mpH/29mtxEaEAJmrkCBxOc1wfFWNiM6
 rh/11Uz6PTBjfTQAj6T0jTJTP6rj3K0mpycAiDunQm4hT8eUpq7Ss6q5cooBawGxSohnff0n4TPZ4
 A9BNZkhL6PdqBIQElzxZLhNJAaZpf1SaVpH4aSbq7eHNN5/AkQlQrGoHjmlPCKPlRx4cjrl73Dh/y
 2ICGPwQA==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdnP-0073IP-RJ; Mon, 29 Nov 2021 10:22:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: decouple DAX from block devices v2
Date: Mon, 29 Nov 2021 11:21:34 +0100
Message-Id: <20211129102203.2243509-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

this series decouples the DAX from the block layer so that the
block_device is not needed at all for the DAX I/O path.

Changes since v1:
 - rebase on latest v5.16-rc
 - ensure the new dax zeroing helpers are always declared
 - fix a dax_dev leak in pmem_attach_disk
 - remove '\n' from an xfs format string
 - fix a pre-existing error handling bug in alloc_dev
 - fix a few whitespace issues
 - tighten an error check
 - use s64/u64 a little more
 - improve a few commit messages
 - add a CONFIG_FS_DAX ifdef to stub out IOMAP_DAX
 - improve how IOMAP_DAX is introduced and better document why it is
   added
