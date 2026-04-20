Return-Path: <linux-erofs+bounces-3338-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JLVDyRv5mmBwAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3338-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 20:23:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A6432C38
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 20:23:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzv4c2Jc4z2ypw;
	Tue, 21 Apr 2026 04:23:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776709408;
	cv=pass; b=dcNdggk4dl04SrAKbAphBURQfesccf629XovC0W5d1LY6yhesnN6YzvGaS8eRMKr9oqWfo/j3YzeJWJul1i5E/cN4miZBCNMrAXUAPaZRCBaFSdRgGp12EG4uEzjG8BuYOphgdx7dEyGtoEjDKOUc40nHOyflBqB2vcWuF8rprSGUZon/yh3teMbXJxGz+xIaGaa0dQw8Q73scPA8E0xgEWvzF4oKJfB9Sf9gZKSoLkRVU7AAz965y0bxyjGx0cdCz+AVROcG8KBJtn0pxBHwQkcILoJ01eEQpgxQ1+wh5SWnIJdlOD1+rjHyRI8JC288GiarueG9rXD7izTcdZ/cQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776709408; c=relaxed/relaxed;
	bh=x4APE98Sy//CiHqwTatilb3429DER7PJS13LPmZdR5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKmZL3uOEYVZh62AfZ1Xe0RI230YPIYszc4C5FsSRqjHKEp1SVBTFJVHcuvlGSj6yT5qxhgdNH+fjVnbQBHuwavOl0KtKU/fhdUy81sL7gZEWPfaCigNoUM5FmSUpCNLvHVynVeidgg+dZIdeNHVVar/IE/1p8pjZwjdM7UAN378PjRATLo3gtRF2UiR6fXv8Un1xArz7HZK6pQrPwYSG6Da1SHpHzkbGVPbX1M7IXFnEVH3V276Y4YIDO1TEZ4i9Uce7w7KhDJjUAw6fF65A6pSWlm5d5+upm8PlZjOGyoIGvhF/eveM935eAJLqGNzglNTAz498FT1ZGWTQ3ytqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=ByIjldNW; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=ByIjldNW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzv4Z5yCzz2xll
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 04:23:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1776709401; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=KuhCPphxOj6nsLVMY52F7AR3wUCYJTtInh0dTiVPtDpq6HzoyuAWhSDsKAY8M5kmvmuvypXosGUI3Pd7sd35+Ez2bhTadCO9iSVL8eAsYbHQ843XfzcDIlUFSavnhIYvmV5ZmCRuSWbgmSmb/wSD8KJnygSxl3x7/cSQNu6bI3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1776709401; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x4APE98Sy//CiHqwTatilb3429DER7PJS13LPmZdR5g=; 
	b=elQ5rcC2pgg2CgkdNGWfV2i3zTgMIFvbY0QhNuQbHkp4p7KfF95LOaA5Uc4B9xv56MrHfoFeIKOBWRjJewrFfKEQHXm27qlGuV4QO6azsVcacypeu84eGgWloyFVUNBoSi1o0zH3BwAKxDQVyAECBiD8v+h9+42v1rfELysTKZ4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776709401;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=x4APE98Sy//CiHqwTatilb3429DER7PJS13LPmZdR5g=;
	b=ByIjldNWWcLL6Ziob/cHC0SwNcIIgzUk4+VUssmJuCTgInQoFYo/26d7j4Txkiuw
	0/XGvbRmxxOFJyQ3XKRNRVOSRnMhPyE5GYcB4uapted11PIKCQoR1FviShNu1I9kflE
	DJYq0035eL91OxNrnxZrE8KIw1D3V1ltDeuJEdyw=
Received: by mx.zoho.in with SMTPS id 1776709399505324.3179571922203;
	Mon, 20 Apr 2026 23:53:19 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: handle short reads in inode fingerprint
Date: Mon, 20 Apr 2026 23:53:18 +0530
Message-ID: <20260420182318.61440-1-ch@vnsh.in>
X-Mailer: git-send-email 2.43.0
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
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3338-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vnsh.in:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:email,vnsh.in:dkim,vnsh.in:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E30A6432C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Treat a zero-byte erofs_io_pread() return as I/O failure when
hashing inode->i_size bytes for the inode fingerprint.

Without that, pread() returning 0 on EOF (source shorter than
i_size, e.g. truncated between stat() and fingerprinting) leaves
"remaining" unchanged and mkfs.erofs spins forever.

Fixes: 5e7cdf7593ae ("erofs-utils: mkfs: add `--xattr-inode-digest` option")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/inode.c b/lib/inode.c
index b3e5f62..bac21dc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2005,6 +2005,8 @@ static int erofs_set_inode_fingerprint(struct erofs_inode *inode, int fd,
 				     min_t(u64, remaining, sizeof(buf)), pos);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
 		if (ret > 0)
 			erofs_sha256_process(&md, buf, ret);
 		remaining -= ret;
-- 
2.43.0


