Return-Path: <linux-erofs+bounces-3410-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC+ZCWuqCmoK5gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3410-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A545667BE
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnCW3mQtz3dRZ;
	Mon, 18 May 2026 15:57:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083879;
	cv=none; b=Exe1JV5c+U9792klSAXSR9QMQM4LU5cX84ZKTIQ3N7VRDQbSBZDtGY5DC1fnvGFdsY2AeYXKe0Z+nrtF4UZfHniDWxw02esRZe+1PdGnfE0itr3b4SGbS2InTmQ1H2ZNbDOMTtHi7C3oeSD8AGKQ0z1vJHhPDfD67RoGdzZDGy/E6opzt8aEQ3CbNPkfgESh7RQ0SclpbDspIUVWfidUBLTMZHwrjSQwV8nrHlFZ+WTpO7aC8W6dZr9G03v84YLd1lr3wVBxDRTbkgUJBLKmQyqmwTgBVBtP0rI4vKCCtR+Gry2MZvO6+DaJbINNHt0iGoS2ri3Oj1jsFg44usLGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083879; c=relaxed/relaxed;
	bh=zNBjCkgLCNLd0TFoW/ql0+BkXC0NGAZ4SSZHFlT3nig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGRtFNadnRS7QeTgkh2PYMIt/fE7clgzG6jUEjfzFmwkmjt5btKE9CZawwWGrUyR3xuH9F1XCUVBcwhyx4i5ZD+CICcRcNkAxulkr/GdiDQ0y4hEnyJOTR/0or1c5/B4M/EmuWbBWwltEfteMaU+VZsBqHZOfnaX2FZhSK4iB1W7yn4NueRoH3rrLKslqY/PY+hNln6KXw/hyuc2lqeWDOiIRj9VURtB4826Mo7IppQIWq3j+nLu0aYdByyi5NhuNRN4GgZgBfQUVetlC/XrDpQ9DXJfJ8TMkgdcdyrnUEVp4T/7PNs/zdQUEninYpysP+NqtSMSGHeiffLJnH0o2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=OgRWW355; dkim-atps=neutral; spf=pass (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=OgRWW355;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnCS4VcJz3dRH
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 15:57:55 +1000 (AEST)
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de [46.114.109.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6ECDD41788;
	Mon, 18 May 2026 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779083873;
	bh=zNBjCkgLCNLd0TFoW/ql0+BkXC0NGAZ4SSZHFlT3nig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=OgRWW355WJt5ZYTrTRqb4bnphVSb1B5oOywDh3sBvee6VWEK8AF6c2Zwu/p0DcWZy
	 33+Nz1AZ6S7ku2a5hKVald15y03N4SgtbDQaCBQHYh5Ld+auzQXaKpRFtzUdOVqI1g
	 Mg2t8j57ZKHXkd0T9ade/jBmufXd7Lts5lUtpyrrjLvyEcsQQTVj9RpigbcSOBic15
	 aL3QXRbjRKO/xIHJ85lsktwOeqUtqS664hoanA1winSkMm2htsHRSvYMMNlbK7ZxG+
	 yHmEN24xKXFAmnhvHDmToholUQy6FZYav25vbueSouzLk40U8OOZwwNzioFbiXLaBf
	 1aUcHBC4EY0J1gkJmLRzCmVg9tMswC3U+9ePsYw5JaQnFzEcRcYNvROYOJNue+X3b0
	 EUv2FAyG6ew0dWoimGX4qmAfBAm3VLuSeml8Bvt43E+eiXtQWWbXKbv9na3R0WmM2U
	 4my5ew3ghzH94V6WEIs+Udow8dXiXUBXOOCV1VvaeJK2gnaZpPfc6q47U1PRReXnJX
	 bPrdWuQ9I8HjzpFB0Y5BTp1vv86yT0NldNd5er9YJ4qhf9J+lI2s/sQ0SfMoQxPzgn
	 BuhqErZ2wZH1kJOTy689mgiVsm3RIfcAtdHcT+hq3TRcNRvnqWC6x5oPnEqIGrwIDs
	 G9DH8hDLoa7FyTogHG+HG9C8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
	Huang Jianan <jnhuang95@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Tony Dinh <mibodhi@gmail.com>,
	=?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
	Francois Berder <fberder@outlook.fr>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	Sughosh Ganu <sughosh.ganu@arm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	u-boot@lists.denx.de,
	linux-erofs@lists.ozlabs.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/9] fs: ext4: print change date in directory listing
Date: Mon, 18 May 2026 07:57:22 +0200
Message-ID: <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 51A545667BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3410-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:heinrich.schuchardt@canonical.com,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org,canonical.com];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
displays the modification date alongside the file size:

 4096 2024-03-15 09:30 filename.txt

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index f8e4794c10e..482a5523712 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_EXT,
 		.name = "ext4",
 		.null_dev_desc_ok = false,
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+		.caps = FS_CAP_DATE,
+#endif
 		.probe = ext4fs_probe,
 		.close = ext4fs_close,
 		.ls = fs_ls_generic,
-- 
2.53.0


