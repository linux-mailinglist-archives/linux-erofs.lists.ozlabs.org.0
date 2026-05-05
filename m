Return-Path: <linux-erofs+bounces-3377-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPr5Nds2+Wki6wIAu9opvQ
	(envelope-from <linux-erofs+bounces-3377-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 05 May 2026 02:16:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094F64C52EC
	for <lists+linux-erofs@lfdr.de>; Tue, 05 May 2026 02:16:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8fFN2yszz2xnZ;
	Tue, 05 May 2026 10:16:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777940184;
	cv=none; b=YDZvtkATiOQQp+KNpGWeWwabH6LFhZXDO8QaYQEUL7xY2sSNgdcIOS6fQZ13PFoS8tSHn3PHEIttGbbeWhQGHCmt87sU95VUi5xC6wPdMYiLNIPDLOrFQ1clgc5aVX4wCgwjSYUrY8M3rtUJ+k4Z2jerSpK5yXyrPW8ce2dvWl2/qSpUN5j0oqCfAMpz6qiut7muhdWyKLixALptTDwyzjXilVTOXVWyY3BrocrEn0aqJZfs2XR++pmh9bRE2HEtISAYJjrRWstmg1ZeXClU/zBfOlFLnYrN/aXGJHu1KXesjlSoUKbgY2or/Xa9jXRkEyynzdPhX9hZja+m6fzltA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777940184; c=relaxed/relaxed;
	bh=JXOa5+RvJ5VSXJ8Gbp12a/oKjNiTswoWwTm8zXltLrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLJlC9sIHoZfnX0Wh7FLIheiPdRdky3L+cv1npRyg4oHtjkk3r1mEWzc0Ngq/ggpNVMUo12/26Mb7mZUPob54FwWxVxPXZVHdB1A5zyVhH8qbg2tfe9hHsykED2oSrQNESXa6qWXJUOWFahZjfr5HGyECY3lFXXDJz33nThetUR1C2F3KDTxalkzPykQjgpS/uZ2OD85xbtORgHJVcHRZV1eOxSSBhAVCbOJJ2STPlnSqAkoscCK+SLae/YjG+k1bf5QO/sKuU4hCist6MM62vdbMpDAJN9tmJfaowCZ4bq8xFJRFgHmFFDMAMpjxifnz5YWuqmVyIrlyexEXGGWSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hFcwqZYQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hFcwqZYQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8fFM3ky4z2xMV
	for <linux-erofs@lists.ozlabs.org>; Tue, 05 May 2026 10:16:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5590060055;
	Tue,  5 May 2026 00:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17732C2BCB8;
	Tue,  5 May 2026 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777940180;
	bh=r0FoTB4Qm9DDsZd69wtvRoYlFr/kq/fGjIA+u/xIp20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFcwqZYQUU+L9w79KOPcaSF3BPDokKxZ9bZ7uSRsV2edkXlsp3qWA2+t2Br9PFZlj
	 Gb3B5WP7GW/LfTPYrxVffumt8KX6Aw4P/uVM0HWBw3ODz6Uu1bAk/UKaiHBoz8kcP0
	 BUVQiyGp9lTkLGQ3dSsb2tNG1aFt+rSPKhp+s+I33ahlXcrYVxG/zgXvphGfSN3YLR
	 vfXzLZO7geW7V8wFtjoyoqz+tEFgFxqHCqKccrdH4RD9H5q3uN3me80GC3MCv9gXlc
	 gIDfe8Azs06yWEykLDXr0DJ3gq3P0bxLVWulZAu/JAPZ0sFJPjRApkc18aLf2KB1JD
	 0rAVGsu2SrDRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fs: prepare for adding LSM blob to backing_file
Date: Mon,  4 May 2026 20:16:14 -0400
Message-ID: <20260505001614.127730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050104-spotter-moody-9d29@gregkh>
References: <2026050104-spotter-moody-9d29@gregkh>
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
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 094F64C52EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3377-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.ozlabs.org,hallyn.com,paul-moore.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:serge@hallyn.com,m:paul@paul-moore.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,ozlabs.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 880bd496ec72a6dcb00cb70c430ef752ba242ae7 ]

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
[PM: use the term "LSM blob", fix comment style to match file]
Signed-off-by: Paul Moore <paul@paul-moore.com>
[ Used kfree() instead of kmem_cache_free(bfilp_cachep, ff) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file_table.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index cf3422edf737c..f7661a7087464 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -60,6 +60,12 @@ struct path *backing_file_user_path(struct file *f)
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+static inline void backing_file_free(struct backing_file *ff)
+{
+	path_put(&ff->user_path);
+	kfree(ff);
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -67,8 +73,7 @@ static inline void file_free(struct file *f)
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kfree(backing_file(f));
+		backing_file_free(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -255,6 +260,12 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	return f;
 }
 
+static int init_backing_file(struct backing_file *ff)
+{
+	memset(&ff->user_path, 0, sizeof(ff->user_path));
+	return 0;
+}
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -277,7 +288,14 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 		return ERR_PTR(error);
 	}
 
+	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = init_backing_file(ff);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
+
 	return &ff->file;
 }
 
-- 
2.53.0


