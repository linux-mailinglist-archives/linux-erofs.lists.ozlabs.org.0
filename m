Return-Path: <linux-erofs+bounces-2243-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JEBOBFffGkYMAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2243-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jan 2026 08:34:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EBB7F46
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jan 2026 08:34:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2SSt4nT3z3bf8;
	Fri, 30 Jan 2026 18:34:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769758478;
	cv=none; b=IEew0rrktvOl5N37s40pXJeTjv20I4b0M4fl91XI5UD9dCvXBp6QDa9vvkAhmyBciSzBS+Q0946MeLcJqDLWbYLhOde09CXqgv2RMlVBD8OYTPg8hV+4RE2MoCNXThx45jTRIImVYnh04ki6rko+JHHPLylgkolwj5MJDANi/iCTWXAeEalCUaAgZvaxzg6e45HBBmDJr7/POBR992yqPu8xITzfDv1LM7OljZTrPkBNxdeRcqa+1mtFuTcudAtvj80c8FxYwZJPATp1qpkjUdtSrX36Op6rFABcWBADDxqNDkZJpo0tr+g6WMS9I+DxmLnyBz/CwzGorLqmuwA9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769758478; c=relaxed/relaxed;
	bh=SdbkKy445/WU0XjKKXOeP0qB9ekgbi8ai7BayKxssio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKIZJuvaocvCEjVNMLpEv4norRu8g3nvW5NVKUBB3hjUb0Xvv2gKyd0t7ltwJgVaCNPea7ndVJWDX1D2xbQoZBPC758vQjBRw2iR0Go2+PgoCdcSD0CgtJ5ukop5aleiSNiYJYr6cGF80TLHHBBa15ENjWHApCTbgjxO3+YuI5uYlZFK0/rUpIvPQr6u5j9V7VzL95WRb2teLD839u55K+uHZp909MYSxWowkZbZFdC8HkGNl5ibImBi/z3iLMhDdUv6UG+94wtLA3Sv07oNuLKQpRgq5bWDopP23O3lom0Pu75njEqf68SbUA0LVznZsnjeFjar2Mte51aEouRQHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iYN92TbN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iYN92TbN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2SSr2XPYz30Pr
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Jan 2026 18:34:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769758468; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SdbkKy445/WU0XjKKXOeP0qB9ekgbi8ai7BayKxssio=;
	b=iYN92TbNhMHytzZKdxbxgwjKfaI8RaN6YcJ5CR5hqAETysiY8ibXbDLlfOWaSl5SYRXo3wWDDsCnNgeef1cjELEsxDVVqpoGXEtAINBkQ13djkyAwLHIR0g7+KuEhMnoWkm/eRgwOzYiQcC1arQSgHUFlSa545gWBsd1fh6sJp8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyA.pOL_1769758462 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 15:34:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: handle end of filesystem properly for file-backed mounts
Date: Fri, 30 Jan 2026 15:34:21 +0800
Message-ID: <20260130073421.2012225-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2243-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 070EBB7F46
X-Rspamd-Action: no action

I/O requests beyond the end of the filesystem should be zeroed out,
similar to loopback devices and that is what we need.

Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index c1d0081609dc..23d9e0c57fb3 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -24,12 +24,9 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 			container_of(iocb, struct erofs_fileio_rq, iocb);
 	struct folio_iter fi;
 
-	if (ret > 0) {
-		if (ret != rq->bio.bi_iter.bi_size) {
-			bio_advance(&rq->bio, ret);
-			zero_fill_bio(&rq->bio);
-		}
-		ret = 0;
+	if (ret >= 0 && ret != rq->bio.bi_iter.bi_size) {
+		bio_advance(&rq->bio, ret);
+		zero_fill_bio(&rq->bio);
 	}
 	if (rq->bio.bi_end_io) {
 		if (ret < 0 && !rq->bio.bi_status)
@@ -37,7 +34,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
-			erofs_onlinefolio_end(fi.folio, ret, false);
+			erofs_onlinefolio_end(fi.folio, ret < 0, false);
 		}
 	}
 	bio_endio(&rq->bio);
@@ -48,7 +45,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
 	struct iov_iter iter;
-	int ret;
+	ssize_t ret;
 
 	if (!rq)
 		return;
-- 
2.43.5


