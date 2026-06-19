Return-Path: <linux-erofs+bounces-3686-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hepRAPpKNWpErgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3686-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 15:58:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5706A637A
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 15:58:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E5A3TEN2;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3686-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3686-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghfLt14xMz3bqD;
	Fri, 19 Jun 2026 23:58:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781877494;
	cv=none; b=a44lud+A78B2c/rI1r/Y36Hesjod0qqg8cUPwdJ726CFuAocWgLKhUxXDBWNWIUEzaFR9x6xNV+y+YZZ03plK1/AYjIneeqHwd49jlQnLw2aXlfTilE8W6aiZt2uTl6S8cHgU7MDcXnPlvwpn0RiqXCHbdTcEpQbHSROfdLGJ6uv4eLpjcnklVELN42G4gxfpxgU6oC3UxatBcJ4KSM9oagn/x1sUKAI6ipXj8PIty+NbK6Z6XueT9Ze780K2XfSiwJfYDmnPlaGr7t+lAO4QeevE8lRy/aAf40KIOQmuSnlsNOEP2r+MCuSDwmBwZmUudE/1V56DjN+TH94SBc0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781877494; c=relaxed/relaxed;
	bh=Uz49zhpiaGZXd32cBhi50h5xA43i0wvUuJPXu8fbVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYctk1ULNsCYyQk19pBVbMogHOSi4FhcIBfMKrCOvsJV8JwmTuft64CQehbW0DhK9leN9oBwxn28jNdhD0ZphjLW2kIdSMnSSeoqN0gZs5umkdK7MfPfaSfGvKyqn9VwHKlNp1z/ANH5rXgBEAdTA7ak3eweeDPL/xc8hfKmHcaBJ5uy0DNpSfze6l/4lqSihyjVkycQcIqqRf8qpI7R/t78zgoU+g29V8LmPXWKbV0WGIhzMwTgB+BHxFS2rYBXWvxXR+m4r46juR+FPPdCADSegJDitQbPdRVcTfVV5cttUU4PU34niPmVjvzHr3cCs/FdGRXneYFU18IDrZhzVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E5A3TEN2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=michael.bommarito@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghfLr1pfvz2ykX
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 23:58:11 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-9157b94a07aso227283085a.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781877488; x=1782482288; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz49zhpiaGZXd32cBhi50h5xA43i0wvUuJPXu8fbVQ8=;
        b=E5A3TEN25nqrV507h5rwdcceT8lrcvAgpcOx+afWgS5+TamDVRyxcDjpAyofaoGEOa
         lgPuMldp1VAT54hvgCDJB/soRUFv/CZ6tEOD+1qcov5sKPXhxwaoNtNysUASNBKaVllc
         av8RTZfOCvxv1hgPwQIQRZpYycaSPFOLKBj+zctAxfWQ/ModzMbkfB5kfUh7/l7uCTHp
         RqFu4snRj+3yJ07tx6MAk9YWyZ7CQIInQjhd9RUilb+xU9dBej4Ueq3eMcKzIviYoT+C
         x/jxhlXrMBiPaDXxtw6YE+kX9ZOk1pTFwdk0cy5BNaoGffg3wW6O7v6vBKfOPqt3mHSM
         AQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877488; x=1782482288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz49zhpiaGZXd32cBhi50h5xA43i0wvUuJPXu8fbVQ8=;
        b=QETZGiHjDBnBB2g5Ub2DeC5NIs+6rY5XpIK9CJp50v1+mjXUXS5MQgwJqf5Q2h/qbR
         qNtU4QlBMttnNqvDJLnQI2wzbmskM4qUsHLzek7ZjENbvB6k2ynHwjkQxLIv5FmAzafp
         95tMJxcvnzRCtAtRgrTN7yyp0+S2pMpM0SX7/mjw0V1V9onBhvPhNJkfMdok7iAuKzT1
         +uZiFtzHjSXHenSqCxmNFRVeudfy6v2QbfsNCgUIeUylbS+l3LKDi/BXoHeHPvrQEjb4
         eQZpvkJdgDC8LLavya4n5+zuuvjHQdZWwsgB3a2C42OuHnAjQ+ghAwXT2DUwxW2BpQcv
         8fOg==
X-Forwarded-Encrypted: i=1; AFNElJ/Y/iUJiC3tLp2MrEHf2hYL+Xypy/BHjFjkZzu5Cdufzzhopj81hDQrT1wOgXMjob1UyZryMeLxf1zh7Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4p1FKmhoBoBxHGk5QlEeZiPEmwe8MJOmrZ/4jyR9qSUhO18Se
	oJeRd/KrEMbmxIvszW5prYTWPCOhNm/yxMZrC7t+LPD9DLWDgbdEoTdC
X-Gm-Gg: AfdE7ckYWIo17y7amSUBqYFsGr0GPDJ3xTSYdVA2+7ZAE7aC0i6U+ASTwZngu+NIQvw
	94I9WznvKVUHoQziOV3Hmcyn8/sMVHey/AxbE/TtSUr5YIPhdO4cAhPgyYx6V9RCNMCapNGa4go
	nmPnFC+nQYh3OGcyZ0cT3ARp28lAj4ZnNflg5lT+AgtZ8+Hj9DZm3DXDW7qIxKLU/J8oQTUdcsN
	d8JL5xxy/RiFVIowOILujMDM3hCxBxIqZKXGmwg6OZSjvh0YmTYn64cq0ySIJVk9djqBW5fzq3p
	1DDMz4zSRjr6PW9Xq0v464WaiAJ0J3AK8e3YIBWJNYyErU4YYHx24LGbX9G8O+yW30vCPE56XyR
	OtZcN/CHgCN+O/NThc6j5u5gu7EgCg0bFKxVFO8mCboQuUZaJtIcUqVYmC3XiN/w8TGaVjRPQi1
	yi2+7dJT4u3/ABLQ+eORt5AZWfoiT+kIt+no4xASBZ9Pi4xw2xG2MLYHqQ8hFRxJbmzBd+c6W7L
	optqek3B99gW2JvgFSA8q4oMZyge1EC
X-Received: by 2002:a05:620a:29c6:b0:914:7e9a:2716 with SMTP id af79cd13be357-920d46198e3mr392178685a.38.1781877488024;
        Fri, 19 Jun 2026 06:58:08 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a142f50asm248618785a.12.2026.06.19.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:58:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: complete fscache pseudo-bio once when a read is split
Date: Fri, 19 Jun 2026 09:58:00 -0400
Message-ID: <20260619135800.1594811-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3686-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B5706A637A

In fscache mode a compressed read uses one pseudo-bio whose io->end_io is
erofs_fscache_bio_endio(). When prepare_ondemand_read() splits the read at
a cached/uncached boundary, erofs_fscache_read_io_async() issues several
fscache subreads on the same bio and erofs_fscache_bio_endio() calls
bio_endio() on each. The pseudo-bio is not chained, so z_erofs_endio()
runs once per subread while z_erofs_submit_queue() counted the bio only
once, underflowing pending_bios: the reader hangs in D state, or, on async
completion, the first completion frees the decompress queue and the rest
are use-after-free.

Hold a bio_inc_remaining() reference per issued subread and drop the
submitter's initial reference with one bio_endio() once submission
finishes, so the bio completes exactly once. The request path
(erofs_fscache_req_end_io) is unaffected; it uses its own refcount and
never calls bio_endio().

Fixes: a1bafc3109d7 ("erofs: support compressed inodes over fscache")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

Reproduced on x86-64 with KASAN via the erofs-on-demand path (a cachefiles
ondemand daemon serving a crafted compressed image that splits a pcluster
read). Found with the help of an automated review tool.

Without this patch a stock kernel either hangs the reader:

  task:dd  state:D
  filemap_get_pages / erofs_file_read_iter

or, when completion is asynchronous, faults:

  BUG: KASAN: slab-use-after-free in z_erofs_endio
  Kernel panic - not syncing: Fatal exception in interrupt

With this patch the same daemon, image and reads complete cleanly: no
hang, no KASAN report, no panic. Harness and full logs available on
request.
 fs/erofs/fscache.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 685c68774379b..0cce498faa32d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -29,6 +29,14 @@ struct erofs_fscache_rq {
 	refcount_t		ref;
 };
 
+struct erofs_fscache_bio {
+	struct erofs_fscache_io io;
+	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
+	struct bio_vec bvecs[BIO_MAX_VECS];
+};
+
+static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error);
+
 static bool erofs_fscache_io_put(struct erofs_fscache_io *io)
 {
 	if (!refcount_dec_and_test(&io->ref))
@@ -122,8 +130,13 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 	enum netfs_io_source source;
 	struct netfs_cache_resources *cres = &io->cres;
 	struct iov_iter *iter = &io->iter;
+	struct bio *bio = NULL;
 	int ret;
 
+	/* Chain-account a split pseudo-bio so it completes only once. */
+	if (io->end_io == erofs_fscache_bio_endio)
+		bio = &container_of(io, struct erofs_fscache_bio, io)->bio;
+
 	ret = fscache_begin_read_operation(cres, cookie);
 	if (ret)
 		return ret;
@@ -143,6 +156,8 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 
 		iov_iter_truncate(iter, len);
 		refcount_inc(&io->ref);
+		if (bio)
+			bio_inc_remaining(bio);
 		ret = fscache_read(cres, pstart, iter, NETFS_READ_HOLE_FAIL,
 				   io->end_io, io);
 		if (ret == -EIOCBQUEUED)
@@ -160,12 +175,6 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 	return 0;
 }
 
-struct erofs_fscache_bio {
-	struct erofs_fscache_io io;
-	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
-	struct bio_vec bvecs[BIO_MAX_VECS];
-};
-
 static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error)
 {
 	struct erofs_fscache_bio *io = priv;
@@ -200,9 +209,9 @@ void erofs_fscache_submit_bio(struct bio *bio)
 	ret = erofs_fscache_read_io_async(io->io.private,
 				bio->bi_iter.bi_sector << 9, &io->io);
 	erofs_fscache_io_put(&io->io);
-	if (!ret)
-		return;
-	bio->bi_status = errno_to_blk_status(ret);
+	if (ret)
+		bio->bi_status = errno_to_blk_status(ret);
+	/* Drop the submitter's ref; subread chain refs complete the bio. */
 	bio_endio(bio);
 }
 
-- 
2.53.0


