Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229382A2EE4
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 17:00:59 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyLw1ZwdzDqSq
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 03:00:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332856;
	bh=sV9UzvQ4JSbzzKdVNJW7A1GLFaPm/YiFf/eaBMWSKL0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lrcB+HVnI0ALcgqLeVKJbOMl8XBSLvmDUBZ2YYWZqanY51Tilfv2WNRkXWWzjxcDL
	 qIoBU5Z6CFGL3GBk9lBNdbAwXyE5ZYJZCi4/Q5jQTaponydtC7yE3YJx82a4ifUFRd
	 Y5aLsu1OW2qRM368boVlHWK7iuXZZvh0TTErohoBn97AIB5gSwYUnVoX1OcZquASvU
	 ARibnPiutz7zfg0G9ieRFBFwHw16za+/k0Wi6R13zpW+Kei80JNJ3h3DDNVFCAdCQ4
	 4P7jPXR1sjIfaRLjgnxRlA9mhsAC9EpF0h+BsXX7zi5rKbV5hyXxQ59aWFiVw2aPbB
	 3XTu+d21uKlbg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.82; helo=sonic314-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=V33dxa1m; dkim-atps=neutral
Received: from sonic314-19.consmr.mail.gq1.yahoo.com
 (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyLk0NMszDqRW
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 03:00:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332842; bh=FM+w1PCF2dukMGbwyyTbljrCQa0jHZAF7KwVDXySMWc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=V33dxa1mIZJEfi/S7AYxCH8ftxPyutVgY8btlC/mTa4NNWuJqmZZIo10Bc3DbMwb3RH5vonIo6pJRVIsw9B3Ikoj2Ye5UHX1wsjijK++dFmLW0peb83fr20fEN9hb3oKe80DEjTtau58zQb6uoQ0sUeMURJpY4EqC8RvRGZ1c6qmXY/pvy2tybzgNAtFi0scRtKDoJ20cXKDnizi8cGdB/FXX8bmggcfr+XvaMa4c8kro7cy4s2JZ9wUpViSJYpYkv0N3P7TIm9ZOdBbWICp4YpgHh9S9OaU3Fira+yt6zAsYtffgpOs/4ksPfU/1Q7IZaEZb4NRtFykdj0eD3R7Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332842; bh=HNVp4X0yZ//GWXH5GueQiiAVvMxhdXRr8P3UhIRYhWg=;
 h=From:To:Subject:Date;
 b=LHZroY3/W6daWm8+lDYbkv//JXsYC2a2qAv8ThxrXJGZ/jJsz8IHdrnEzk4Z8/c6IcSyW97RNpwDd7rv/ki2TOT6Flw5dod9QSXvaUY8rvrmg3DoxSlm348/U75rvSmYyzj6fC68vsPTSNklLf0y3CSiRHNHaRBslktXVUkZNKFfzu9XHDbSMWEl0vyPsw9S6rxejSx9vJR8TVXf4TGbbRKEE3b9QxB7lEqg+vET2IjQVzLMk2zA2pbQD7tfYR7j9Ah9kDr8445OBkkyhYD9fDe9sZRRrbCfUyxjf3itmE0MLn5emZ8rn/p+zysGzqk8loWHrtqUrwb4DqZGrPko+Q==
X-YMail-OSG: p20qeQIVM1kqA3Fx97.DweelJ7ps4P7UvnjsX9cvX2ERPV.aN.xBlVb9vxrfiMH
 O9FEErTDRpovWQSo8lYSRMuU6IxW7lEha9o0OBRSNTinYc0v5oKobOroxpkVM2PCEpBQ2024RBtI
 LMh99dJ.A8tGpV0Ov81PASNoFCr.dHjBKyEbloc4tJxHRZIK59qmUXsJNEMaV6JJ.jQfklTDP4Xe
 Gx5.ftyNJUrWEWaItcRf1f.8Jg1r06ujt2impwpW2xxnB.KLS_ReNV9JAapJ78yBCCSR1Hhhsz9m
 ZcryB5b_IQIrygbsZM4gFLyblVphRNrIh4MVISTnCOsYn4wTdYAMrdI8cH9XelCXqt8xFNhngxIx
 gzdrdmvKABwaD1s8UrG3pXpTzG1EeMvKgoH4VEEPZa8uH5mLk3MDnaVfSGs8b6Eel2eXjkHx6i8u
 ATGhR7nZMsK0m3we_uvh1vdUhkmUeWBji1IVx1JInMyNVtJkJSNfrmhDZfaJ0eacOUY1iEm_0srO
 FwIehG2h.0ou2L.F465nQElZ7EprqzG7s2hW1AjLCBH32nqM_caMHeDlfITQI7hrEDRB7QaH4dvT
 bzbKTvqq_vLmg1m5tH3fyAHNLVmKAmvAkpBB3cWN.9nvbmC0WdQ3DbKO39fN.JK9B6j0QDKdQ2_I
 AW2Ibu4.ZSxiZY.XwE2qcLlzYQ6v9wX4lhRLJkkzKdODggDQvsmbXmioja8CPNH.J.Vfylhr9fQb
 OwTqaOcoKjY9EgkSr34yXGCne4DY4tTGVJzZVBhiGrPSVV.BTvOz3eigwd1Bpv80UGf3EmpHRdi8
 NzV54fVDio_I7NKP78OWquCy9LxF2Wgn7xoqh._ByilWqK_YcKQv4gog5ZYl8WGgEVz7vkaKSyYo
 BhMsdMPfJF68LoqaL0P9IbKREFADSQ0p82AWC1RXImSXB06Ft2B3ACQuiO45bPXfk19pxnPlVNa8
 N0lLo1yXL3IpIy1fFAaKDCJkXeXRFv3zBRPMWGNCvZd4ygvq_nUocrHsSh24GjFoX8akaI4LRl.i
 41M1iC3h76ooGprtAOiErxGbq78UkiogbfXOFtv6ZFP5C6t93erPz3B_xb6XTYCjGH82L0cYk55d
 tMV5nYlF01hMAl7orfDr5yAigLRF30wjjA2nH2azqL1u0eu74meRAIP2Lug9uqyGqMlfvpji5U8z
 JALySCh3w1NvsaFePprUU8hm.3zrt.Hv5NmvrhfN1JeuejiCfF5Ibuo36n.EZRc97qN36XNZXHoU
 yfO0wv0UWbme9Cc2VJVgm7mvWJakE_bxy97.RS1_a9G4brn71EG2RAhLJHxSwET4EHaP7a.Colc6
 9rU7J_reZ_ZATFlMqc7RzhVRStC7f7.4mbDFk85Y2XwtNuiTKtGhoaazTsSFYWuBnAzQJMid1Wvk
 0BjJVeZD1l6YynoJB7e0VIucClToEdbH6hYmygQim_zvEzvCbptYtrnTNrLVGQprSNZL6.5dfUB_
 Dy7J1pm1zeZYDQepHZN6oTgBlu2Ok8wQn9f7ZFJK_BHY8Ytp9n.fBgVtX4fO8RuxzYpz7TJbePJh
 NQFoj5v73u6G0S5wD21vjNbkQ4ByVRa64daow0v2tVgW_jBGVrqrpdQnKG_uC.eNMsz1eslrhYvQ
 A.3STHCYTYHMWu4h3z8HIqasIbWr5zcl4sf16Q5tGiFJLnRo_EsbwudlFpmHUJnihyJN6wQBZNSG
 r5rnXTNbAJwBGFzCsVsG47YlIiYcEsr1C9XHVHok0CxN5sVqCkuQSQfyrxPCMV7sASt_BwzJygcR
 gZ4.c5.QshD9RBpbFjZfJDbAX2kxdqRndmlQRfZa1nc3k8gApUxAr6d7FPl_uvJrCHVees9EnJ5_
 7ngBxAP1sLgRKp0BIBV99jIrKpL7newdSvnCtXKv0n_SV6nFk9m5WXRkDwapYtorc3GU3sK3ZK3r
 .l3AXFWhAVXUwUwsoAClo_KhdA6Jor3udtGTamakDdJ2gLkxU_S6_mSeahxQeVcOZjHPPKDSQCfy
 rW5DV8.Q7R47gdq9ApNm3MJc9LmwsWeNFMTD_G32bsCcsgL2tgqzh66EeXTgsy_kOQ.bSQ7V01BA
 Ae1.ePV41IO_JyQVcVLT1xK3gPS9_AOb8SUPjtohoDIXnKCjhXTPBXRPD_QcX0Y3CzGDUTCiJ.E7
 .UXbvGmUnt2CWfCeDc6nLkWm5.qIl3jmwROCotEjIaOq_PlI9pqwTD4oDF5l_hSsWS1tMWwroUVh
 ro_J0wATJakWibEquPT3AAeMMZXRFdXitvcL72qghS4FdLsotPWjetQrDDX_OuCHimbV8QqVusUj
 qnvbd9XxrE5sBz7ArzPcKdtLNjPe7DAhUN8ojV65ELSXONbSUiCEbjRw1l.UvBBQUDq5SfsIYMg8
 S6xgfIy5CQm1YGv.4HTQ7KD9Ev9REPfihJFq_dQ0hIhNMVuNiEfchN_5.hIWzeBggkW8zmwmIiNF
 iA_XHO7eQfRo5FGDaor2bg3DX4OPZ41m.oVwyx5KwQa90gweaIB8APcIqhZu5AP3DsVzPkZqZyeb
 RMTyxmEirTga5DBmI3a5xNvdFjZF_u0wVmcRy7d9jaJD6LNm1zvPLgmREt05rYw5km_7s2bcd3.A
 aLd7zZyOCFMp196Sy9n4s_dIBHxgfkJ67DEES31AccPrAyczTlFYQVylw1gEeO0qFqSEiCBc7FVr
 iB8GUbzqM8xrelWT0sxxK_4eYl1glOy2ZEGZfeascYskNdz.gXg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 16:00:42 +0000
Received: by smtp420.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID aa129971a4deab6e98284c88780a2fc2; 
 Mon, 02 Nov 2020 16:00:37 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 12/12] erofs-utils: fuse: kill incomplate dcache
Date: Mon,  2 Nov 2020 23:59:38 +0800
Message-Id: <20201102155938.2679-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155938.2679-1-hsiangkao@aol.com>
References: <20201102155558.1995-10-hsiangkao@aol.com>
 <20201102155938.2679-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

useless at all, use simplist bare disk lookup way for now
(also libfuse has an internal dcache, we can use it as well.
 plus no need to introduce dcache for unpack tool.)

(will fold into the original patch.)

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am |   2 +-
 fuse/dentry.c    | 130 ----------------------------------
 fuse/dentry.h    |  43 ------------
 fuse/main.c      |   5 --
 fuse/namei.c     | 179 +++++++++++++++++++++++------------------------
 fuse/namei.h     |   5 --
 6 files changed, 88 insertions(+), 276 deletions(-)
 delete mode 100644 fuse/dentry.c
 delete mode 100644 fuse/dentry.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 5ff0b4d0e6ab..84e5f834d6a4 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c namei.c read.c readir.c zmap.c
+erofsfuse_SOURCES = main.c namei.c read.c readir.c zmap.c
 erofsfuse_CFLAGS = -Wall -Werror \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
diff --git a/fuse/dentry.c b/fuse/dentry.c
deleted file mode 100644
index 0f722294d530..000000000000
--- a/fuse/dentry.c
+++ /dev/null
@@ -1,130 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * erofs-utils/fuse/dentry.c
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#include <stdlib.h>
-#include "dentry.h"
-#include "erofs/internal.h"
-#include "erofs/print.h"
-
-#define DCACHE_ENTRY_CALLOC()   calloc(1, sizeof(struct dcache_entry))
-#define DCACHE_ENTRY_LIFE       8
-
-struct dcache_entry root_entry;
-
-int dcache_init_root(uint32_t nid)
-{
-	if (root_entry.nid)
-		return -1;
-
-	/* Root entry doesn't need most of the fields. Namely, it only uses the
-	 * nid field and the subdirs pointer.
-	 */
-	erofs_info("Initializing root_entry dcache entry");
-	root_entry.nid = nid;
-	root_entry.subdirs = NULL;
-	root_entry.siblings = NULL;
-
-	return 0;
-}
-
-/* Inserts a node as a subdirs of a given parent. The parent is updated to
- * point the newly inserted subdirs as the first subdirs. We return the new
- * entry so that further entries can be inserted.
- *
- *      [0]                  [0]
- *       /        ==>          \
- *      /         ==>           \
- * .->[1]->[2]-.       .->[1]->[3]->[2]-.
- * `-----------麓       `----------------麓
- */
-struct dcache_entry *dcache_insert(struct dcache_entry *parent,
-				   const char *name, int namelen, uint32_t nid)
-{
-	struct dcache_entry *new_entry;
-
-	erofs_dbg("Inserting %s,%d to dcache", name, namelen);
-
-	/* TODO: Deal with names that exceed the allocated size */
-	if (namelen + 1 > DCACHE_ENTRY_NAME_LEN)
-		return NULL;
-
-	if (parent == NULL)
-		parent = &root_entry;
-
-	new_entry = DCACHE_ENTRY_CALLOC();
-	if (!new_entry)
-		return NULL;
-
-	strncpy(new_entry->name, name, namelen);
-	new_entry->name[namelen] = 0;
-	new_entry->nid = nid;
-
-	if (!parent->subdirs) {
-		new_entry->siblings = new_entry;
-		parent->subdirs = new_entry;
-	} else {
-		new_entry->siblings = parent->subdirs->siblings;
-		parent->subdirs->siblings = new_entry;
-		parent->subdirs = new_entry;
-	}
-
-	return new_entry;
-}
-
-/* Lookup a cache entry for a given file name.  Return value is a struct pointer
- * that can be used to both obtain the nid number and insert further child
- * entries.
- * TODO: Prune entries by using the LRU counter
- */
-struct dcache_entry *dcache_lookup(struct dcache_entry *parent,
-				   const char *name, int namelen)
-{
-	struct dcache_entry *iter;
-
-	if (parent == NULL)
-		parent = &root_entry;
-
-	if (!parent->subdirs)
-		return NULL;
-
-	/* Iterate the list of siblings to see if there is any match */
-	iter = parent->subdirs;
-
-	do {
-		if (strncmp(iter->name, name, namelen) == 0 &&
-		    iter->name[namelen] == 0) {
-			parent->subdirs = iter;
-
-			return iter;
-		}
-
-		iter = iter->siblings;
-	} while (iter != parent->subdirs);
-
-	return NULL;
-}
-
-struct dcache_entry *dcache_try_insert(struct dcache_entry *parent,
-				   const char *name, int namelen, uint32_t nid)
-{
-	struct dcache_entry *d = dcache_lookup(parent, name, namelen);
-
-	if (d)
-		return d;
-
-	return dcache_insert(parent, name, namelen, nid);
-
-}
-erofs_nid_t dcache_get_nid(struct dcache_entry *entry)
-{
-	return entry ? entry->nid : root_entry.nid;
-}
-
-struct dcache_entry *dcache_root(void)
-{
-	return &root_entry;
-}
-
diff --git a/fuse/dentry.h b/fuse/dentry.h
deleted file mode 100644
index 12f4cf6bafd9..000000000000
--- a/fuse/dentry.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/dentry.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef _EROFS_DENTRY_H
-#define _EROFS_DENTRY_H
-
-#include <stdint.h>
-#include "erofs/internal.h"
-
-/* fixme: Deal with names that exceed the allocated size */
-#ifdef __64BITS
-#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
-#else
-#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
-#endif
-
-/* This struct declares a node of a k-tree.  Every node has a pointer to one of
- * the subdirs and a pointer (in a circular list fashion) to its siblings.
- */
-
-struct dcache_entry {
-	struct dcache_entry *subdirs;
-	struct dcache_entry *siblings;
-	uint32_t nid;
-	uint16_t lru_count;
-	uint8_t user_count;
-	char name[DCACHE_ENTRY_NAME_LEN];
-};
-
-struct dcache_entry *dcache_insert(struct dcache_entry *parent,
-				   const char *name, int namelen, uint32_t n);
-struct dcache_entry *dcache_lookup(struct dcache_entry *parent,
-				   const char *name, int namelen);
-struct dcache_entry *dcache_try_insert(struct dcache_entry *parent,
-				       const char *name, int namelen,
-				       uint32_t nid);
-
-erofs_nid_t dcache_get_nid(struct dcache_entry *entry);
-int dcache_init_root(uint32_t n);
-#endif
diff --git a/fuse/main.c b/fuse/main.c
index e423312d9e1a..563b2c378952 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -116,11 +116,6 @@ static void signal_handle_sigsegv(int signal)
 void *erofs_init(struct fuse_conn_info *info)
 {
 	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
-
-	if (inode_init(sbi.root_nid) != 0) {
-		erofs_err("inode initialization failed");
-		abort();
-	}
 	return NULL;
 }
 
diff --git a/fuse/namei.c b/fuse/namei.c
index 4c428dbc59f6..5ee3f8d2a4b6 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -16,7 +16,6 @@
 #include "erofs/defs.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
-#include "dentry.h"
 
 #define IS_PATH_SEPARATOR(__c)      ((__c) == '/')
 #define MINORBITS	20
@@ -99,124 +98,127 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	return 0;
 }
 
-/* dirent + name string */
-struct dcache_entry *list_name(const char *buf, struct dcache_entry *parent,
-				const char *name, unsigned int len,
-				uint32_t dirend)
+
+struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
+					void *dentry_blk,
+					const char *name, unsigned int len,
+					unsigned int nameoff,
+					unsigned int maxsize)
 {
-	struct dcache_entry *entry = NULL;
-	struct erofs_dirent *ds, *de;
-
-	ds = (struct erofs_dirent *)buf;
-	de = (struct erofs_dirent *)(buf + le16_to_cpu(ds->nameoff));
-
-	while (ds < de) {
-		erofs_nid_t nid = le64_to_cpu(ds->nid);
-		uint16_t nameoff = le16_to_cpu(ds->nameoff);
-		char *d_name = (char *)(buf + nameoff);
-		uint16_t name_len = (ds + 1 >= de) ?
-			(uint16_t)strnlen(d_name, dirend - nameoff) :
-			le16_to_cpu(ds[1].nameoff) - nameoff;
-
-		#if defined(EROFS_DEBUG_ENTRY)
-		{
-			char debug[EROFS_BLKSIZ];
-
-			memcpy(debug, d_name, name_len);
-			debug[name_len] = '\0';
-			erofs_info("list entry: %s nid=%u", debug, nid);
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + nameoff;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* a corrupted entry is found */
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent @ nid %llu", pnid | 0ULL);
+			DBG_BUGON(1);
+			return ERR_PTR(-EFSCORRUPTED);
 		}
-		#endif
-
-		entry = dcache_try_insert(parent, d_name, name_len, nid);
-		if (len == name_len && !memcmp(name, d_name, name_len))
-			return entry;
 
-		entry = NULL;
-		++ds;
+		if (len == de_namelen && !memcmp(de_name, name, de_namelen))
+			return de;
+		++de;
 	}
-
-	return entry;
+	return NULL;
 }
 
-struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
-		unsigned int name_len)
+int erofs_namei(erofs_nid_t *nid,
+		const char *name, unsigned int len)
 {
 	int ret;
 	char buf[EROFS_BLKSIZ];
-	struct dcache_entry *entry = NULL;
 	struct erofs_vnode v;
-	uint32_t nr_cnt, dir_nr, dirsize, blkno;
 
-	ret = erofs_iget_by_nid(parent->nid, &v);
+	ret = erofs_iget_by_nid(*nid, &v);
 	if (ret)
-		return NULL;
-
-	/* to check whether dirent is in the inline dirs */
-	blkno = v.raw_blkaddr;
-	dirsize = v.i_size;
-	dir_nr = erofs_blknr(dirsize);
-
-	nr_cnt = 0;
-	while (nr_cnt < dir_nr) {
-		ret = blk_read(buf, blkno + nr_cnt, 1);
-		if (ret < 0)
-			return NULL;
-
-		entry = list_name(buf, parent, name, name_len, EROFS_BLKSIZ);
-		if (entry)
-			goto next;
-
-		++nr_cnt;
-	}
-
-	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
-		uint32_t dir_off = erofs_blkoff(dirsize);
-		off_t dir_addr = iloc(dcache_get_nid(parent)) +
-			v.inode_isize + v.xattr_isize;
-
-		memset(buf, 0, sizeof(buf));
-		ret = dev_read(buf, dir_addr, dir_off);
-		if (ret < 0)
-			return NULL;
+		return ret;
 
-		entry = list_name(buf, parent, name, name_len, dir_off);
+	{
+		unsigned int offset = 0;
+
+		struct erofs_inode tmp = {
+			.u = {
+				.i_blkaddr = v.raw_blkaddr,
+			},
+			.nid = v.nid,
+			.i_size = v.i_size,
+			.datalayout = v.datalayout,
+			.inode_isize = v.inode_isize,
+			.xattr_isize = v.xattr_isize,
+		};
+
+		while (offset < v.i_size) {
+			int maxsize = min(v.i_size - offset, EROFS_BLKSIZ);
+			struct erofs_dirent *de = (void *)buf;
+			unsigned int nameoff;
+
+			ret = erofs_read_raw_data(&tmp, buf, offset, maxsize);
+			if (ret)
+				return ret;
+
+			nameoff = le16_to_cpu(de->nameoff);
+
+			if (nameoff < sizeof(struct erofs_dirent) ||
+			    nameoff >= PAGE_SIZE) {
+				erofs_err("invalid de[0].nameoff %u @ nid %llu",
+					  nameoff, *nid | 0ULL);
+				return -EFSCORRUPTED;
+			}
+
+			de = find_target_dirent(*nid, buf, name, len,
+						nameoff, maxsize);
+			if (IS_ERR(de))
+				return PTR_ERR(de);
+
+			if (de) {
+				*nid = le64_to_cpu(de->nid);
+				return 0;
+			}
+			offset += maxsize;
+		}
 	}
-next:
-	return entry;
+	return -ENOENT;
 }
 
 extern struct dcache_entry root_entry;
 int walk_path(const char *_path, erofs_nid_t *out_nid)
 {
-	struct dcache_entry *next, *ret;
+	int ret;
+	erofs_nid_t nid = sbi.root_nid;
 	const char *path = _path;
 
-	ret = next = &root_entry;
 	for (;;) {
 		uint8_t path_len;
 
 		path = skip_trailing_backslash(path);
 		path_len = get_path_token_len(path);
-		ret = next;
 		if (path_len == 0)
 			break;
 
-		next = dcache_lookup(ret, path, path_len);
-		if (!next) {
-			next = disk_lookup(ret, path, path_len);
-			if (!next)
-				return -ENOENT;
-		}
+		ret = erofs_namei(&nid, path, path_len);
+		if (ret)
+			return ret;
 
 		path += path_len;
 	}
 
-	if (!ret)
-		return -ENOENT;
-	erofs_dbg("find path = %s nid=%u", _path, ret->nid);
+	erofs_dbg("find path = %s nid=%llu", _path, nid | 0ULL);
 
-	*out_nid = ret->nid;
+	*out_nid = nid;
 	return 0;
 
 }
@@ -233,10 +235,3 @@ int erofs_iget_by_path(const char *path, struct erofs_vnode *v)
 	return erofs_iget_by_nid(nid, v);
 }
 
-int inode_init(erofs_nid_t root)
-{
-	dcache_init_root(root);
-
-	return 0;
-}
-
diff --git a/fuse/namei.h b/fuse/namei.h
index 1803a673daaf..2625ec58d434 100644
--- a/fuse/namei.h
+++ b/fuse/namei.h
@@ -10,13 +10,8 @@
 #include "erofs/internal.h"
 #include "erofs_fs.h"
 
-int inode_init(erofs_nid_t root);
-struct dcache_entry *get_cached_dentry(struct dcache_entry **parent,
-				       const char **path);
 int erofs_iget_by_path(const char *path, struct erofs_vnode *v);
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *v);
-struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
-		unsigned int name_len);
 int walk_path(const char *path, erofs_nid_t *out_nid);
 
 #endif
-- 
2.24.0

