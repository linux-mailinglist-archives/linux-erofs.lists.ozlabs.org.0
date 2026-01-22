Return-Path: <linux-erofs+bounces-2130-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO9eIhiRcWkLJAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2130-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 03:53:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80E6119E
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 03:53:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxQbl4NSgz2yFm;
	Thu, 22 Jan 2026 13:53:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769050387;
	cv=none; b=LEW0VO+w2neRuVjyeDBo2Q+RnH/IuhQmuo8Nntt9lc4tRumkTUc9aMavHjKBQVXpxywt28mb+tgaYu5fsyezASXkNN0xJyqzhSb0qGe5rz4U6BN1geVcxUQHExfZngfSNkSZi94gT1pBRUFFM/uQi8EiOrg5sebrbJdP0mIs9csixLG7QW/o8Cz6ofjshiJR44Nt6JzqDadslHQtLsWHJGjbxAT2Rzcdp48CrNJq84jE6b3ZoQpjnVZ9goTtoxCHpnwEYYgsdWYVIviZRJVlZWgHI4kZUgGSMGINKR/wwyFjOLWzcmGAaIUc9i9xF4fCAVD20WSD6g2D7qlvJpNnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769050387; c=relaxed/relaxed;
	bh=nt2wSvj2MCM8OfrbOs7JCPwj+aEtEkcOalDVcXuRwsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAigI0J+iAb/oROukdpflPXlTgFSx0iXNU4sboxCohqfm51ZQ/+LYJBf4hOIogeCZ+OnnzNNjxrjuMeEcAR8t/vGLcp8fUxl+njcNQZmq5jv+zCNQbTPS7HSGU0aMe0ZlVhtz17rQEkDWHzgOlN6EW4CTqiOUGNXGJAzy0wZ5yBDVz6DBswCerJFduzY8Nu77Qj1grfGfg2A0eoEgvaDeB5+CzFKzn9QsY7z0sRxUe8hiPjmGYe58D3YSQGMn/F15Ebr4EYPmsCC1w3BAm8NTi0PMxMw6iSqCfmR+DBOD+TyW7KjxK7fwX9FVScCPLwF4OAw4c89YrcU0OXVYFGkYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O14NMUST; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O14NMUST;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxQbj0v1sz2xS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 13:53:02 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769050378; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nt2wSvj2MCM8OfrbOs7JCPwj+aEtEkcOalDVcXuRwsM=;
	b=O14NMUSTY9Kn/rwyre14OdZpKWHUaQu9ytS8lK6hOjn6VvcjAM0UNDLI3f05v18agdTYqapKxQySU64R+cIZz7kM6sjxA/ILsRT05DPplaxKTpwW3eyw9oMmfjBy772HinEqAyfhviPn+e3xPdESXx/g521xQsHuBiqbLk1HaF4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxagN8a_1769050373 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 10:52:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yuxuan Liu <cdjddzy@foxmail.com>
Subject: [PATCH] erofs: add missing documentation about `directio` mount option
Date: Thu, 22 Jan 2026 10:52:52 +0800
Message-ID: <20260122025252.3724634-1-hsiangkao@linux.alibaba.com>
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2130-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,foxmail.com:email]
X-Rspamd-Queue-Id: 1C80E6119E
X-Rspamd-Action: no action

Document the `directio` mount option for file-backed mounts, because
recent users need this and this mount option has been available since
commit 6422cde1b0d5 ("erofs: use buffered I/O for file-backed mounts
by default") without proper documentation.

Reported-by: Yuxuan Liu <cdjddzy@foxmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194b94..96101c3fe53a 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -125,6 +125,8 @@ dax={always,never}     Use direct access (no page cache).  See
                        Documentation/filesystems/dax.rst.
 dax                    A legacy option which is an alias for ``dax=always``.
 device=%s              Specify a path to an extra device to be used together.
+directio               (For file-backed mounts) Use direct I/O to access backing
+                       files, and asynchronous I/O will be enabled if supported.
 fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a domain ID in fscache mode so that different images
                        with the same blobs under a given domain ID can share storage.
-- 
2.43.5


