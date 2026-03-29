Return-Path: <linux-erofs+bounces-3079-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JZbDDVjyWlXxwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3079-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 19:36:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 443ED3535EA
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 19:36:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkM4x3qKpz2ySS;
	Mon, 30 Mar 2026 04:36:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774805809;
	cv=pass; b=Eg8lr9ZQATJ1qbQ+oXhULe2PogvlXXFaWeLd6tx7KQ0hT8Rh1oNGQSv3jWF34SB00AIM9PzuaYsgymhzLX5/aaXp/D8EJ3kGqWp40gIqludqWWQPozIMnWUnvxAxHqzR9f5wSyAhxG13WK+QGoPKuRKsLU5hoKVBVVG34vNSYflb20MkxICuN8DmzgRTJgDfq9Vg9wtRf1JKDpSjHUzx6+VxzDVDfbs3KeAeqQ47+IPXjN6B0fVNhOupgypDXsIIl8Uo6Q8B6Y/QxOZ6pLM9Tg/7cfsOfquikP/oLhUL9Ma1noRgf2ipyS20S5VsliKzB0J2ZXBdGiCCKAa7Tyz1/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774805809; c=relaxed/relaxed;
	bh=Yl9AbJORGj3RXT1qZS1odU+6bW6wbR1iMcvjDyewOlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqLiGFp6T9/SbKkEUx2h8lc1AG3jxjPYtMP5aBsm6GFKcyhmCCf11pwzXCIiPXs/YeAZ8wsplzRxIqvU17i2GACA86xDJb4tvIV6SSznEdjd045HvHkdsMB3F67MRQl8778VpS5zwVfVZ6dzxK4WuYQoiOcPhxj4XOgwHDzE/H2uZVPtuOdRo7xg/UTIxbQX125nNf6DoyltLcVSI60cBhxIIZ8D5mwet2rYm4FUrckgfwGG2emGfFa4hQbh1E2CknhK5nRauM2mPA90Z7sP/veTBJToj+gW6vDSWcJNDEEmHXFBli0hd4T+LwPGS8bsfJXnTMRLPlL6KlxT9fmgiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=KG3nn34T; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=KG3nn34T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkM4w29fPz2xgv
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 04:36:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774805801; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=ctE8nm9jUjioWFhKGWrPWuyH3borxJZHj6I+eH7tREJYpeP06qsO4WP3T2oc184r3KL0lcTE2o0GHLjOU7RGNg3l90geOY4MYu5rED7zLXd3Vuixp1eTgc3lhzZSwlKHfFPWUIOAR5vxMZQHiPk+6yCUTNBMLYwdgTmbf+UakvM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774805801; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yl9AbJORGj3RXT1qZS1odU+6bW6wbR1iMcvjDyewOlw=; 
	b=fMKW9QMcuovVPKzCEYW5xr4M0AuSfCBr60DHOIKrFAUAr4kEPFBcxobz3DG79wnQnyWpbLsMPHdjI0jKGHI34DlwqLJ/XchEnBRDZrn6OpKi+9uZe29JM5QCPBMM1R3mRh6OV9dANtY6MgciyDGSlCnBzGdq+BK3C1bGB2sDtis=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774805801;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Yl9AbJORGj3RXT1qZS1odU+6bW6wbR1iMcvjDyewOlw=;
	b=KG3nn34TEjYUkCeQRDL5py3WAfAvICq4FLYOWAw0iWqncz5tHDhRrbZooSSGFN5P
	Zu9FZDzialdwgZLvSVInnAUdB8+QseYNtjz4lQlyuxQb8AFmIRwuwnGJnW1QjCtBNB4
	fXjbjTgvUwbGC0t2+JpphqbvTjhS0nn7kZA/XtoQ=
Received: by mx.zoho.in with SMTPS id 1774805800464719.0327468855128;
	Sun, 29 Mar 2026 23:06:40 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: tar: fix fractional PAX mtime parsing
Date: Sun, 29 Mar 2026 17:36:39 +0000
Message-ID: <20260329173639.54997-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3079-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 443ED3535EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fractional part of PAX mtime values was parsed as a plain integer,
so "123.5" ended up with 5ns instead of 500000000ns.

Scale the fractional part according to its decimal width before storing
it as nanoseconds. Also normalize negative fractional timestamps and
reject malformed mtime values with missing digits or trailing junk.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 4eb0060..4e97522 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <limits.h>
 #include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/diskbuf.h"
@@ -525,6 +526,9 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 				eh->link = strdup(value);
 			} else if (!strncmp(kv, "mtime=",
 					sizeof("mtime=") - 1)) {
+				unsigned int ns = 0;
+				int digits = 0;
+
 				ret = sscanf(value, "%lld %n", &lln, &n);
 				if(ret < 1) {
 					ret = -EIO;
@@ -532,12 +536,31 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 				}
 				eh->st.st_mtime = lln;
 				if (value[n] == '.') {
-					ret = sscanf(value + n + 1, "%d", &n);
-					if (ret < 1) {
+					while (value[n + 1] >= '0' &&
+					       value[n + 1] <= '9') {
+						if (digits < 9)
+							ns = ns * 10 + value[n + 1] - '0';
+						++digits;
+						++n;
+					}
+					if (!digits || value[n + 1] != '\0') {
 						ret = -EIO;
 						goto out;
 					}
-					ST_MTIM_NSEC_SET(&eh->st, n);
+					while (digits++ < 9)
+						ns *= 10;
+					if (ns && value[0] == '-') {
+						if (eh->st.st_mtime == LLONG_MIN) {
+							ret = -EIO;
+							goto out;
+						}
+						--eh->st.st_mtime;
+						ns = 1000000000 - ns;
+					}
+					ST_MTIM_NSEC_SET(&eh->st, ns);
+				} else if (value[n] != '\0') {
+					ret = -EIO;
+					goto out;
 				} else {
 					ST_MTIM_NSEC_SET(&eh->st, 0);
 				}
-- 
2.43.0


