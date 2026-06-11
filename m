Return-Path: <linux-erofs+bounces-3568-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cQGSMIZzKmoepgMAu9opvQ
	(envelope-from <linux-erofs+bounces-3568-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 10:36:22 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C066FEAB
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 10:36:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Kwi8rNgA;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3568-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3568-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbbb540N0z2yQH;
	Thu, 11 Jun 2026 18:36:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781166977;
	cv=none; b=W46U21tZ3kVrgPMSVHtSXDNhsb9E3K78y4ugytopdYd8jLTRFABAzJ8xDsj47y7UyobdwLdcdAAFElJPn3pxOmnFU36yHjKwVmDGuwvdNys8PB1jpbK71Ybp1I0pgH5LzIisdRPr+ud429wwR+s26Z84GDoqXxW4S5VAei7ekoLfxUP9MAXt6CVX0gVzxBjrD/m9vYzFbXun3AJhKB5vkur0wSxwL3YdQW4EuMrNP9RreAn7BliLsBaw6PX2sjjCCxpuTbqDMcpUGjNrzsSphwIPILXy1ldIeaMcD2ZKHP9SpWsuNTF12eFFFB3O0+i0udImZ1GOzN+szc+xO9iajg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781166977; c=relaxed/relaxed;
	bh=DBopcLyQjibZGGyAl8Hn9YW7RqfsOHpTHsw9Nl7X/4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEOW4xjihw6klA9jdZdg0lwPOFhYuOT8PXAbMmpSe64ObE/u0mNPJor+mWgK5tTF+4MJ/76Spb+sEzz1NsZOnyfKRfwjGB5yZzgnzFDK+o4QFCbFibfdlZOvDbF3EZs6/TNSVE2LgiAgaIav+DrhDgu1Me8lGSa/93FwsZffIFLXd05TmA22PbyJdyA3w9rZk6O6rIRfDxhbhIFYRzajVuvFS57JZE9StjOHdQYSekJJg1Gm5H9Kblq+60YiPw2RPVbLsiEWDdxOWb5bwUw41CI5MxWWWVrJM1LzQozH6zvyWR4p7F+ISzh0LgRlgRA5/qI0wYG70xomcqlsKEVTGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kwi8rNgA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbbb42pjGz2xmV
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 18:36:15 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso73674335ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781166974; x=1781771774; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBopcLyQjibZGGyAl8Hn9YW7RqfsOHpTHsw9Nl7X/4M=;
        b=Kwi8rNgAnH0x0hDwW9XpLukNOgF/8Rylpjpb9/F4f1VShpzwNixCeSXMI1vW5c2D90
         GhXyvnMzhqVNJ7ePyAUMviCMPxC/er9xe384Z4P6kXLqi78AbKnuHl13rnRN2vlCZpQ2
         bzlpynZmmL0bbFRwMOPtZnm3cU85tUn1cHnvkKJSxSfXctnXn7Ozy1aWEDYVesX3AcHU
         APuUF9IjcS61g/bYE+VjuRnjuKTBc2DWM0MMULdWDYCprShobZ7DN5t8b0awbfkopo2f
         +LOTTGZYhClLaaHbGwourR3f+z/HJTew/SyR7HxO6OK5hhbgSz1acY7hYfPinWGCN+sZ
         tNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166974; x=1781771774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBopcLyQjibZGGyAl8Hn9YW7RqfsOHpTHsw9Nl7X/4M=;
        b=NhvwtugCGAt7jcS8/pjjjRfDv2zWiIcgYIkpwT8Bb73iprJ2VwAnswEKUpeDQ68ydq
         70z4Zp4FDR8vfkzkrsPzaYvqoggQqH54q+22M1Om9sIrDkhrJ2GQ+9m1Ko/0QMu0yHWg
         EnZ0MZHzhsBu5ZR4DRmXxx62BmAyKkOQq+erdrfliwg30XPwSsz3pTegjtpMfXsTqLRu
         YaHYD1IKgDcHCcLvwRpQzXZtoYCnLYErJjUX4hlXhmNt/omTL9rliYfmUZJnXUhYplkG
         fw8ysxKR40UJhniTu4nBHkYF0Vc25AxPU9Vatw7fI+rW8Ez7HWP6eIxU+ljKQ2LwrssK
         jXGQ==
X-Gm-Message-State: AOJu0YyIz6UWS5bOaOtGwyJSzQSIMDEHYtnUbvN6ivZk2F7K2Iy9dlcs
	fDRQFaT4zGntotm5SEZc0nJ5G3Ss5eaHHqJKPcnFkpQV+d5vmc5vph9nTYGt/g==
X-Gm-Gg: Acq92OElMoEOWQLh5hx0ntMCXihrtBRPdVardyACsA6V9r7KLhakSiUsg7w2/SfozbI
	7hxsUmJh41igvVKIRJyTgTdoEJQ3Wjpzz18doHAZ8NYyo1oT/QAnJpWtHw4HQoy+4Kekj9A63Xt
	+E+PbFao0SVjmPIssBIJYEuKA4WbSSxco2k4M1S88l9BnjBbJkL/uMg/gyIFEbn2d2ZB9pdGXXG
	xR+rufliQXuz5Itn4CmBO13KwOpAlynbck3H4MJYJDZVMZ/CZaV2w+J5P4KciGsiNUdC6mjLOcY
	L0lKymWCp0Q0QY1gkk3wGB9VWIcFDUFLdH+Uj2PXje7Xj+ts2Iuzrg5+8bACn/VjBA2JkmKfK5Q
	IzYmVaRrtGt/ILcsfhWFuXg/emH7Q/YzQ0X4YHI+QGOatkphvnDTe+ikgUUlx8MOSP6NiCjdtua
	GN34by56cUetRxtPukxs+i0DMUhNl5I+QKsNGXKwzxFbMqxSBlmKjXK4l7DzUigy9cLQ==
X-Received: by 2002:a17:903:3807:b0:2c1:e426:70f4 with SMTP id d9443c01a7336-2c2f22a9fdemr22100525ad.23.1781166968736;
        Thu, 11 Jun 2026 01:36:08 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c245dd3b5dsm144009345ad.81.2026.06.11.01.36.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 01:36:08 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v1] fsck.erofs: implement thread-safe global LRU metadata cache
Date: Thu, 11 Jun 2026 14:06:01 +0530
Message-ID: <20260611083601.81061-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3568-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B90C066FEAB

This patch introduces a thread-safe metadata cache to reduce redundant
I/O and decompression overhead during fsck extraction.

To ensure it remains highly concurrent for worker threads extracting
pclusters, the cache utilizes a bucketed, rw-semaphore protected
architecture modeled after the existing fragment cache.

Furthermore, to prevent out-of-memory (OOM) scenarios on exceptionally
large EROFS images, the cache implements a strict Global Least Recently
Used (LRU) eviction policy. The maximum cache size is dynamically
configurable via the new '--cache-size' parameter, which defaults to a
safe, fixed threshold of 32 MB.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              |  12 ++++
 include/erofs/internal.h |   2 +
 lib/data.c               | 149 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ffe7e29..7a1e573 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -67,6 +67,7 @@ static struct option long_options[] = {
 	{"no-xattrs", no_argument, 0, 14},
 	{"nid", required_argument, 0, 15},
 	{"path", required_argument, 0, 16},
+	{"cache-size", required_argument, 0, 17},
 	{"no-sbcrc", no_argument, 0, 512},
 	{0, 0, 0, 0},
 };
@@ -120,6 +121,7 @@ static void usage(int argc, char **argv)
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
 		" --nid=#                check or extract from the target inode of nid #\n"
 		" --path=X               check or extract from the target inode of path X\n"
+		" --cache-size=#        set maximum metadata cache size in bytes (default 32MB)\n"
 		" --no-sbcrc             bypass the superblock checksum verification\n"
 		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
 		"\n"
@@ -261,6 +263,16 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 16:
 			fsckcfg.inode_path = optarg;
 			break;
+		case 17: {
+			char *endptr;
+			unsigned long cache_size = strtoul(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid metadata cache size %s", optarg);
+				return -EINVAL;
+			}
+			erofs_meta_cache_set_capacity(cache_size);
+			break;
+		}
 		case 512:
 			fsckcfg.nosbcrc = true;
 			break;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 94f14da..34b7eb3 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -459,6 +459,8 @@ struct z_erofs_read_ctx {
 
 void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx);
 
+void erofs_meta_cache_set_capacity(unsigned long bytes);
+
 int liberofs_global_init(void);
 void liberofs_global_exit(void);
 
diff --git a/lib/data.c b/lib/data.c
index e9d2218..9acf2bf 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -29,6 +29,84 @@ struct z_erofs_decompress_task {
 	unsigned int nr_reqs;
 };
 
+#define META_HASHSIZE		65536
+#define META_HASH(c)		((c) & (META_HASHSIZE - 1))
+
+struct erofs_meta_bucket {
+	struct list_head hash;
+	erofs_rwsem_t lock;
+};
+
+struct erofs_meta_item {
+	struct list_head list;
+	struct list_head lru;
+	u64 key;
+	char *data;
+	int length;
+	bool evicting;
+};
+
+static struct erofs_meta_bucket meta_bks[META_HASHSIZE];
+static bool meta_cache_inited = false;
+EROFS_DEFINE_MUTEX(meta_cache_init_lock);
+
+static EROFS_DEFINE_MUTEX(meta_lru_lock);
+static struct list_head meta_lru_list;
+static unsigned long meta_cache_bytes = 0;
+static unsigned long meta_cache_max_bytes = 32 * 1024 * 1024; 
+
+void erofs_meta_cache_set_capacity(unsigned long bytes)
+{
+	meta_cache_max_bytes = bytes;
+}
+
+static void erofs_meta_cache_init(void)
+{
+	int i;
+
+	erofs_mutex_lock(&meta_cache_init_lock);
+	if (meta_cache_inited) {
+		erofs_mutex_unlock(&meta_cache_init_lock);
+		return;
+	}
+
+	for (i = 0; i < META_HASHSIZE; ++i) {
+		init_list_head(&meta_bks[i].hash);
+		erofs_init_rwsem(&meta_bks[i].lock);
+	}
+	init_list_head(&meta_lru_list);
+	meta_cache_inited = true;
+	erofs_mutex_unlock(&meta_cache_init_lock);
+}
+
+static void erofs_meta_cache_evict(void)
+{
+	struct erofs_meta_item *item;
+	struct erofs_meta_bucket *bk;
+
+	erofs_mutex_lock(&meta_lru_lock);
+	while (meta_cache_bytes > meta_cache_max_bytes && !list_empty(&meta_lru_list)) {
+		/* Get the least recently used item (tail of the list) */
+		item = list_last_entry(&meta_lru_list, struct erofs_meta_item, lru);
+		item->evicting = true; /* Mark it dead to block cache hits from resurrecting it */
+		list_del(&item->lru);
+		init_list_head(&item->lru);
+		meta_cache_bytes -= item->length;
+		erofs_mutex_unlock(&meta_lru_lock);
+
+		bk = &meta_bks[META_HASH(item->key)];
+		erofs_down_write(&bk->lock);
+		list_del(&item->list);
+		erofs_up_write(&bk->lock);
+
+		free(item->data);
+		free(item);
+
+		erofs_mutex_lock(&meta_lru_lock);
+	}
+	erofs_mutex_unlock(&meta_lru_lock);
+}
+
 static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
 {
 	struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
@@ -604,7 +682,72 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
 void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
 			  erofs_off_t *offset, int *lengthp)
 {
+	u64 key = nid ? nid : *offset;
+	struct erofs_meta_bucket *bk;
+	struct erofs_meta_item *item;
+	void *buffer = NULL;
+
+	if (__erofs_unlikely(!meta_cache_inited))
+		erofs_meta_cache_init();
+
+	bk = &meta_bks[META_HASH(key)];
+
+	erofs_down_read(&bk->lock);
+	list_for_each_entry(item, &bk->hash, list) {
+		if (item->key == key) {
+			buffer = malloc(item->length);
+			if (buffer) {
+				memcpy(buffer, item->data, item->length);
+				*lengthp = item->length;
+				*offset = round_up(*offset, 4);
+				*offset += sizeof(__le16) + item->length;
+				
+				erofs_mutex_lock(&meta_lru_lock);
+                if (!item->evicting)
+                    list_del(&item->lru);
+					list_add(&item->lru, &meta_lru_list);
+                erofs_mutex_unlock(&meta_lru_lock);
+			}
+			break;
+		}
+	}
+	erofs_up_read(&bk->lock);
+
+	if (buffer)
+		return buffer;
+
 	if (nid)
-		return erofs_read_metadata_nid(sbi, nid, offset, lengthp);
-	return erofs_read_metadata_bdi(sbi, offset, lengthp);
-}
+		buffer = erofs_read_metadata_nid(sbi, nid, offset, lengthp);
+	else
+		buffer = erofs_read_metadata_bdi(sbi, offset, lengthp);
+
+	if (IS_ERR(buffer))
+		return buffer;
+
+	item = malloc(sizeof(*item));
+	if (item) {
+		item->key = key;
+		item->length = *lengthp;
+		item->evicting = false;
+		item->data = malloc(*lengthp);
+		if (item->data) {
+			memcpy(item->data, buffer, *lengthp);
+			
+			erofs_down_write(&bk->lock);
+			list_add_tail(&item->list, &bk->hash);
+			erofs_up_write(&bk->lock);
+
+			erofs_mutex_lock(&meta_lru_lock);
+            list_add(&item->lru, &meta_lru_list);
+            meta_cache_bytes += *lengthp;
+            erofs_mutex_unlock(&meta_lru_lock);
+
+			if (meta_cache_bytes > meta_cache_max_bytes)
+				erofs_meta_cache_evict();
+		} else {
+			free(item);
+		}
+	}
+
+	return buffer;
+}
\ No newline at end of file
-- 
2.52.0


