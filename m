Return-Path: <linux-erofs+bounces-887-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742B8B327AA
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Aug 2025 10:37:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c89Qx1MQrz3dCt;
	Sat, 23 Aug 2025 18:37:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755938233;
	cv=none; b=oOZheRIMf9xlAAfuY/3YZQNPnzc33rizVIsSmF1twJ7uztKESdL5qn58I3X9QE4V8WYJd/dNr0+//KU3jldXDyQidy/Ns7rZGCftU5NC/9B3V/bXgQGFfhCR9EXZ0UKblEsA4vftt+hOysQTo8/Pvu7r+jbXIJ6CKQ7o6D99PTI5o8bd77T+kIOEcrQelfqO8SmTFOPfbVu/Frxz9d9zZH5aMYC9RIf4zURIIbLxaPp/22nkbzSX3ZowNqtsYEbpJMq93x7IeIoLDHDQVO/IhVf7Z+CyzM2Wwc+Gul4wDWO4kQDJHg920uusfeSzRZIjSQ1sf1k8gW2i6E4naaD/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755938233; c=relaxed/relaxed;
	bh=rCo5nUxYQHd/pGK7VFAC7fPDhC90H0i9d9Q7/M0G4m4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgNgRRz4CW6ch462dVIsviJMeXYbRztRVFYS85vzZ01d3bBxGpg2HDFF8PFa3S0/doFMwsy0Ffwnx5s7kSL01GUSy/gDcfwJ7zic1CQTCEf/wv8sRAeqqT2vRD/mUbi6aIh7fo/nUb7177wIp13OHwPIYy6ch5zz63lJKF66Oz8IAtCVLmfgfotAK7608AxBOcSwJOzCYU9wJ0P2hz+071YIq3EJmC7uf7/4T/+WnRGbLSUq6S7Okekv6eWZk4YghhqdbIotNQu6HSzrHSkyyv1gX1MXs7XQURybImMFD1C9SUgNJt213hzabIlVXUSFkOr2xooFFEm9NRst/22XzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=Tpzw4lSD; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=Tpzw4lSD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=friendy.su@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c89Qv5D2Nz3d8K
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 18:37:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1755938232; x=1787474232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rCo5nUxYQHd/pGK7VFAC7fPDhC90H0i9d9Q7/M0G4m4=;
  b=Tpzw4lSDJBxxMwWEmCmafeJ48yTblcrsFNg2Y/HbssiuIoExSnS6GoOQ
   GaupfdiXphvs+jrmwP2Ayj0Upaw+QoDLiJPegb3A7222+nnFOqPbP2gES
   SOzlwUXuj301k9qCGmQ8RTZ8TClbjdhvZ7q6oaKNp+oVPxIsEhiUwn1L4
   gC3yQkMswciiuOPdDOm9JV7UeKO3Ub9EmboLHghb3ezFZMcnM5XFcFX2Y
   R3hhKMonONm2wGzmEPSnxFj9E+GdrPQoD0KOX17Xw1GGqp3uum2qyR0Qg
   zuu/BhVr5lpiGZqGaQYmOahUBqVL5+44MVz72vMIv/fBWSUu7b+pvFd+l
   w==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 17:37:04 +0900
X-IronPort-AV: E=Sophos;i="6.17,312,1747666800"; 
   d="scan'208";a="23010329"
Received: from unknown (HELO cscsh-5109200313..) ([IPv6:2403:700:0:20a2::1e0f])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 23 Aug 2025 17:37:04 +0900
From: Friendy Su <friendy.su@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v3] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev
Date: Sat, 23 Aug 2025 16:34:53 +0800
Message-Id: <20250823083453.249576-1-friendy.su@sony.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Set proper 'dsunit' to let file body align on huge page on blobdev,

where 'dsunit' * 'blocksize' = huge page size (2M).

When do mmap() a file mounted with dax=always, aligning on huge page
makes kernel map huge page(2M) per page fault exception, compared with
mapping normal page(4K) per page fault.

This greatly improves mmap() performance by reducing times of page
fault being triggered.

Considering deduplication, 'chunksize' should not be smaller than
'dsunit', then after dedupliation, still align on dsunit.

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 lib/blobchunk.c  | 18 ++++++++++++++++++
 man/mkfs.erofs.1 | 15 +++++++++++++++
 mkfs/main.c      | 12 ++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index bbc69cf..69c70e9 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -309,6 +309,24 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
 	interval_start = 0;
 
+	/*
+	 * dsunit <= chunksize, deduplication will not cause unalignment,
+	 * we can do align with confidence
+	 */
+	if (sbi->bmgr->dsunit > 1 &&
+	    sbi->bmgr->dsunit <= 1u << (chunkbits - sbi->blkszbits)) {
+		off_t off = lseek(blobfile, 0, SEEK_CUR);
+
+		off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
+		if (lseek(blobfile, off, SEEK_SET) != off) {
+			ret = -errno;
+			erofs_err("lseek to blobdev 0x%llx error", off);
+			goto err;
+		}
+		erofs_dbg("Align /%s on block #%d (0x%llx)",
+			  erofs_fspath(inode->i_srcpath), erofs_blknr(sbi, off), off);
+	}
+
 	for (pos = 0; pos < inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 63f7a2f..9075522 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -168,6 +168,21 @@ the output filesystem, with no leading /.
 .TP
 .BI "\-\-dsunit=" #
 Align all data block addresses to multiples of #.
+
+If \fBdsunit\fR and \fBchunksize\fR are both set, \fBdsunit\fR will be ignored
+if it is bigger than \fBchunksize\fR.
+
+This is for keeping alignment after deduplication.
+If \fBdsunit\fR is bigger, it contains several chunks,
+
+E.g. \fBblock-size\fR=4096, \fBdsunit\fR=512 (2M), \fBchunksize\fR=4096
+
+Once 1 chunk is deduplicated, the chunks thereafter will not be aligned any
+longer. In order to achieve the best performance, recommend to set \fBdsunit\fR
+same as \fBchunksize\fR.
+
+E.g. \fBblock-size\fR=4096, \fBdsunit\fR=512 (2M), \fBchunksize\fR=$((4096*512))
+
 .TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
diff --git a/mkfs/main.c b/mkfs/main.c
index 30804d1..5ca098b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1098,6 +1098,18 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	/*
+	 * once align data on dsunit, in order to keep alignment after deduplication
+	 * chunksize should be equal to or bigger than dsunit.
+	 * if chunksize is smaller than dsunit, e.g. chunksize=4k, dsunit=2M,
+	 * once a chunk is deduplicated, all data thereafter will be unaligned.
+	 * so show warning msg here, then NOT do alignment when write file data.
+	 */
+	if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blkszbits) < dsunit) {
+		erofs_warn("chunksize %u bytes is smaller than dsunit %u blocks, ignore dsunit !",
+			   1u << cfg.c_chunkbits, dsunit);
+	}
+
 	if (pclustersize_packed) {
 		if (pclustersize_packed < erofs_blksiz(&g_sbi) ||
 		    pclustersize_packed % erofs_blksiz(&g_sbi)) {
-- 
2.34.1


