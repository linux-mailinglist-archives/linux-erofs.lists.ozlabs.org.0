Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B620489647E
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 08:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712125463;
	bh=CdnBszR7BQ7MAlLvnNdMt9h/4s6Gm7GIp+cKKlukA0s=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hbCj2N/gLxeU6lprXs6vz2KNk9U8AnuR2qOG16lXQVuslBmZq2HjhCkDlcrT8ytsE
	 QiIBAWl46mte+IKh7h3kH45U0tRMUOID9usakDGh6/yGl/uOUi7Yqm2lr4daJWJIK6
	 9eCd2wErsaMhOTIRX1VssU+e4BrHF56UWgw6kGTvERrnSpBt6Xd43KZOhMqXhjc3DX
	 QPiC6bz6auR9kxTxrynYG3Ifa8cIjtA4cwIkf1CWRdezD6fh1mWup4JmIFL9u/SObt
	 VRc35k3gwc942EWDVymPFsaC3KGQ/zhAGhEUvj1A8boqIF9XI5oC/azoEgh/Rfitvr
	 Ho4Ow+TvmGeWQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8ZTg3cVxz3dWH
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 17:24:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=06gSjWsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3cfymzgckc2abf8t8jcemmejc.amkjglsv-cpmdqjgqrq.mxj89q.mpe@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8ZTS348Yz30PD
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 17:24:12 +1100 (AEDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-615073c8dfbso38687497b3.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Apr 2024 23:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712125449; x=1712730249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdnBszR7BQ7MAlLvnNdMt9h/4s6Gm7GIp+cKKlukA0s=;
        b=Rgb0NeHM81jtZpEvfa1KwUhgyls9Q5BNkAb+HpV0ICI8heCoVuuUNLDo2/vA0LoJ+Q
         r4qidLalqsVSwEs08ufZfdsX7nyHRQClyl30Nn2WPBFE+CzsMfGN6GYsmRK05X21Gq4L
         RYWuah2wC4DDHW3xoOhQJYP6SPLLFXaHWoDDdfkMqQ/X1jwFk4lkzXYYvTfX3tHx5uFx
         vL+pGoz95EgarOcp9U1e8qU6goMIv83SB/bK9TD40ckq6XpEQNue9CEd0NPMCDH7VJOH
         D9VAfFgMgvwO9RzlMPUBKDO8fUVYj1nr+K9S6L09aBkeL3gOfI9SP6lbklvxVBJ8ml2F
         IJ0A==
X-Gm-Message-State: AOJu0Ywrab3Q5WtX0tQhiTnb0hFUfk2HFLZIxlVmWrjsN1Q44srrgNVi
	Mw2eNopVSjs5SOix9Qiq8NfMp3s1H7p7mmLr0ctgp85YUDE4nvXW85HFmBq7/WV4wwgD7or5Wdt
	LMbJnjozKU7pEpzKgu8TzZ75nm1DjtzCYoYoHsZocwpQFGDMiCg2FE/0hrGAZN3hB5X4BpMxXeK
	Sd93GB1wERsRIX9e66PI9e7DpiXO6SJiZ6ojfQ5Hb+NMSrGw==
X-Google-Smtp-Source: AGHT+IFmNzZ+tSbVMw4gIkLFgk4dEj+YQZ37FbDzP9YY4zYfJ5Ar72i5fDW48hz+wAHIfiYzXT77FS7C2ILb
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:9324:8a19:f8f:8ba9])
 (user=dhavale job=sendgmr) by 2002:a05:6902:218c:b0:dc6:e20f:80cb with SMTP
 id dl12-20020a056902218c00b00dc6e20f80cbmr1210691ybb.3.1712125449330; Tue, 02
 Apr 2024 23:24:09 -0700 (PDT)
Date: Tue,  2 Apr 2024 23:23:57 -0700
In-Reply-To: <20240403062357.1705807-1-dhavale@google.com>
Mime-Version: 1.0
References: <20240403062357.1705807-1-dhavale@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403062357.1705807-2-dhavale@google.com>
Subject: [PATCH v1 1/1] erofs-utils: lib: Fix calculation of minextblks when
 working with sparse files
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When we work with sparse files (files with holes), we need to consider
when the contiguous data block starts after each hole to correctly calculate
minextblks so we can merge consecutive chunks later.
Now that we need to recalculate minextblks multiple places, put the logic
in helper function for avoiding repetition and easier reading.

Fixes: 7b46f7a0160a (erofs-utils: lib: merge consecutive chunks if possible)
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/blobchunk.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index ee12194..41bee19 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -223,6 +223,16 @@ out:
 	return 0;
 }
 
+static erofs_blk_t erofs_minblks_from_interval(struct erofs_sb_info *sbi,
+			erofs_off_t start, erofs_off_t end, erofs_blk_t cur_min)
+{
+	erofs_blk_t lb;
+	lb = lowbit((end - start) >> sbi->blkszbits);
+	if (lb && lb < cur_min)
+		return lb;
+	return cur_min;
+}
+
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff)
 {
@@ -231,8 +241,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	unsigned int count, unit;
 	struct erofs_blobchunk *chunk, *lastch;
 	struct erofs_inode_chunk_index *idx;
-	erofs_off_t pos, len, chunksize;
-	erofs_blk_t lb, minextblks;
+	erofs_off_t pos, len, chunksize, interval_start;
+	erofs_blk_t minextblks;
 	u8 *chunkdata;
 	int ret;
 
@@ -267,9 +277,10 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 		goto err;
 	}
 	idx = inode->chunkindexes;
-
 	lastch = NULL;
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
+	interval_start = 0;
+
 	for (pos = 0; pos < inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
@@ -294,12 +305,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 
 		if (offset > pos) {
 			len = 0;
+			minextblks = erofs_minblks_from_interval(sbi,
+					   interval_start, pos, minextblks);
 			do {
 				*(void **)idx++ = &erofs_holechunk;
 				pos += chunksize;
 			} while (pos < offset);
 			DBG_BUGON(pos != offset);
 			lastch = NULL;
+			interval_start = pos;
 			continue;
 		}
 #endif
@@ -320,13 +334,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 		if (lastch && (lastch->device_id != chunk->device_id ||
 		    erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
 		    erofs_pos(sbi, chunk->blkaddr))) {
-			lb = lowbit(pos >> sbi->blkszbits);
-			if (lb && lb < minextblks)
-				minextblks = lb;
+			minextblks = erofs_minblks_from_interval(sbi,
+					    interval_start, pos, minextblks);
+			interval_start = pos;
 		}
 		*(void **)idx++ = chunk;
 		lastch = chunk;
 	}
+	minextblks = erofs_minblks_from_interval(sbi, interval_start, pos,
+					minextblks);
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
 	free(chunkdata);
 	return erofs_blob_mergechunks(inode, chunkbits,
-- 
2.44.0.478.gd926399ef9-goog

