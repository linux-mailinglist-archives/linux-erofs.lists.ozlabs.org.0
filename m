Return-Path: <linux-erofs+bounces-3570-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nu4FH6wCK2rK1AMAu9opvQ
	(envelope-from <linux-erofs+bounces-3570-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 20:47:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE346748EC
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 20:47:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="gg1wT/WO";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3570-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3570-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbs7q0qhNz3bqh;
	Fri, 12 Jun 2026 04:47:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781203623;
	cv=none; b=VUVNjy7aABkxeY6LObPeRsei4DmM6KRX7BFBWCen2xQBakixHr+2T8IYM5iFM1TqNdgQV/V/oQKhqj1T+NUEsLHNzRXvfwmLP0Lx6n5O0CwSNMc3vTn2eUWq8aKzT2ezEL0/awPiw6mgxN7NB+vaZwgn6vjwcV6UT3Yv8ZDjsI1Ttvj+6M7Es2WaNftf431xn++Cmd/bFQyFYAcm9FDamLGFCk3bqEbKrjjM0ebBxd1PRhSp2P/jjS7yp1BnKG5tYRowDHay5GwXJjB2qV707KROfjq+Hb4/NFK36+03XEjCrpPBWuXWUstqHpDtHK3VCSWjRS4NshbSClEYNx/nOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781203623; c=relaxed/relaxed;
	bh=Wght5xN+jtWo5jWyqJwlcIzll3ZGCprTvUV06XQIb48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcNnpWPiLgLGEb+Ez0ztR4pUVVr7UO2PdHWVA94IKEIykMi7GJhljmUgPEXkvmHQvkE47cHCLhYvffVEURA3ZccsDd47gTY0i66o9TIviznHb1dFGHLPtiKRytgM89Fe6zjYmFySeUyq+q1ZaRT4Ow6Ek219pFjMcEiqTLHqMKPGF99LhRJA94qDgOSQb754EKMyJYydTJIO6LQOeJl8L7TAa3fRoQ9se0lWAeOBZM2JVgCcHcAsbRqxCEdFTH6hUqIocMXzEbfWwJ/oPsmInYSZGZ2It4NUmqdhOEl6cHP50S4OT4ihG3CDZTI+B7l3s06SWConilMGmvijgkU3fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gg1wT/WO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbs7n5xSPz3bpP
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 04:47:00 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2c0c3543590so1533575ad.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781203618; x=1781808418; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wght5xN+jtWo5jWyqJwlcIzll3ZGCprTvUV06XQIb48=;
        b=gg1wT/WOvpmUyBGOltvyAUkIolu8Esd+SDYa+S5B8y7qT/Qy0zCgumZ9SOcIvhBR1S
         209ULyFuedWtycQ6CHoF1E7ZacWoVr2YEKDklSUro/sX7FvoDrjLJ+07iD5wHTelQh7W
         Jg0YKKAkelKH3M19Vfg5dof6oLM7JdPGQV0W8nySB7XtAB8jIau6DTJte8Qs444ZMmwZ
         9Qbk9Yn7RG8+fZU+45CCmR3+nb0vIWaYmralfMs/WjXA+xE2kCLTUGbqws6xsylwzJNB
         Sk0R6+IyxVUnCHcIce5cm7pWSIsAa3i4Eee1CGYQzlp7f+NrpCxUsNWg4dh/y8sFBLRF
         ny0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203618; x=1781808418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wght5xN+jtWo5jWyqJwlcIzll3ZGCprTvUV06XQIb48=;
        b=fFcZhRSmqSL+Onenhky1lQR8y1ZAqOqZ+LuAHLyVSie6G+tjWtKXzVb8OAEbJgMa8Z
         i65YY05BeLIdwzqUCIjUqaM7/6ygtxQuuM3UDFcF/n2W2k+eC5S48FkOirvb2XX5WNPc
         j5TGgv9IlSqRz+ReMz1Cz+8p8dAhidGKKCTWttznPiqq7tcWcECOxEZrUWGqb4T8e9sH
         xKGkAoX9/14rBlfD/NYYQOEv7rHDANyjBE2TvjKutVHSa0vFpJcXiOCLegdMKR1P/DZI
         sqwxJHJUW51GS0RuuTyOO5cv69quOOQSH6XheGBe7mRUqB9E21BbrJKHBzRKXlW3K6QL
         tRlw==
X-Gm-Message-State: AOJu0YyOXH6OuFZzYve2vGU7UF5r/cn3DHWRgKS/TUSXnOmxllj3gTe2
	TUlaC3u6bNCmNetDowQv5FqSw6jHDqn5pAUwV1oX7GWJsU51j9c3Pih1N2iy1Q==
X-Gm-Gg: Acq92OG05oZVIAAqGEx9q/TDPtTeRlLygABYf6jLnPHFBfq0SQcmV+VFFbD18mjs3VF
	IqLfS2cSYOOQ/Ry0yMwweoPOtnoV0I2BANgH4++PXqjHLRU03xnjXZEIHPaJg5y/IV3gchsNCcC
	GI18GxHwDlUjVCZ4FWZubfG7Es7gwgv57uFCyl196lzYhWrEixAcSaNL0TKX2fSDSYl5aK606ri
	uYtvaH4P43RuxqPT4+eZwMA4XqQdrCXn9AJ0eyitqUfKQlIlnw4xiqEb0UWM0jn4v2iu6452hNY
	HiOy9jOwThM4xgymjhk2YKm2c3QplXvF0knO0xTVmR+lUiT/EEtzEMyrC5aVo201AlZlofwc0zU
	QE202oyzKR4//ADfhuZ52GdJ5tOZnij0oADunmNvS6OfVYXUUyR60IRufZrvYJr17h28WcLkSRw
	Q2IqlFKP+ZcN74tqFgwfsF1d84f5gKkzABOYg9Q8GjyFYYpnDZF96MeJM=
X-Received: by 2002:a17:903:46c4:b0:2bc:ac76:c1cf with SMTP id d9443c01a7336-2c2f21a1cacmr52778625ad.24.1781203618340;
        Thu, 11 Jun 2026 11:46:58 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c302sm277560445ad.73.2026.06.11.11.46.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 11:46:58 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: nithurshen.dev@gmail.com,
	hsiangkao@linux.alibaba.com,
	xiang@kernel.org
Subject: [PATCH v2] fsck.erofs: implement thread-safe global LRU metadata cache
Date: Fri, 12 Jun 2026 00:16:51 +0530
Message-ID: <20260611184651.89363-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611083601.81061-1-nithurshen.dev@gmail.com>
References: <20260611083601.81061-1-nithurshen.dev@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3570-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BE346748EC

This patch introduces a thread-safe userspace metadata cache to reduce
redundant decompression cycles and the overhead of repetitive pread()
syscalls across multiple background worker threads.

To ensure it remains highly concurrent for worker threads extracting
pclusters, the cache utilizes a bucketed, rw-semaphore protected
architecture modeled after the existing fragment cache.

While the introduction of a userspace cache inherently increases the
memory footprint compared to relying solely on the kernel's page cache,
this patch implements a strict Global Least Recently Used (LRU) eviction
policy to safely bound this additional memory overhead. This prevents the
cache from growing unbounded on exceptionally large EROFS images. The
maximum cache capacity is dynamically configurable via the new
'--cache-size' parameter, which defaults to a safe threshold of 32 MB.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              |  12 ++++
 include/erofs/internal.h |   2 +
 lib/data.c               | 150 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 3 deletions(-)

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
index e9d2218..b8d81b3 100644
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
@@ -604,7 +682,73 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
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
+				if (!item->evicting) {
+					list_del(&item->lru);
+					list_add(&item->lru, &meta_lru_list);
+				}
+				erofs_mutex_unlock(&meta_lru_lock);
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
+			list_add(&item->lru, &meta_lru_list);
+			meta_cache_bytes += *lengthp;
+			erofs_mutex_unlock(&meta_lru_lock);
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


